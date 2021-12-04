import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gateway/blocs/ble_sensor_controller/controller_state.dart';
import 'package:gateway/business_logic/ble_sensor/ble_sensor.dart';
import 'package:gateway/business_logic/ble_sensor/bloc/ble_sensor_bloc.dart';

part 'ble_sensor_controller_event.dart';
part 'ble_sensor_controller_state.dart';

// TODO detect does having person in front
class BleSensorControllerBloc
    extends Bloc<BleSensorControllerEvent, BleSensorControllerState> {
  final List<BleSensorBloc> listOfSensor;
  late HexoStateProcessing hexoStateProcessing;
  late StreamController<BleSensorOnData> streamBleSensorDataConsumer;
  late StreamSubscription<HexoState> streamHexoStateSub;

  BleSensorControllerBloc(this.listOfSensor)
      : super(BleSensorControllerInitial()) {
    hexoStateProcessing = HexoStateProcessing();
    _initListenSenorData();
    _listenHexoState();

    // Send command to BLE sensor
    // inner bloc communication
    on<BleSensorControllerSensorCommandEvent>((event, emit) => {
          listOfSensor
              .firstWhere((sensor) => event.sensorType == sensor.sensorType)
              .add(BleSensorWriteEvent(event.data))
        });
    // listen and add data to hexo State
    on<BleSensorControllerSensorDataEvent>(
        (event, emit) => {hexoStateProcessing.addEvent(event)});

    // logic for hexo state (processed) event
    on<BleSensorControllerHexoEvent>((event, emit) => {
          // TODO How to add Debounce
          if (event.state.isDone)
            {emit(BleSensorControllerValidState())}
          else
            {
              if (event.state.currentError != null)
                {
                  emit(BleSensorControllerInValidState(
                      event.state.currentError!.sensorType, event.state.mess))
                }
            }
        });

    on<BleSensorControllerResetEvent>((event, emit) =>
        {hexoStateProcessing.isReset = !hexoStateProcessing.isReset});
  }

  _listenHexoState() {
    streamHexoStateSub =
        hexoStateProcessing.streamStateController.stream.listen((event) {
      add(BleSensorControllerHexoEvent(event));
      // Bloclistener when state is done
    });
  }

  _initListenSenorData() {
    streamBleSensorDataConsumer.stream.listen((sensor) {
      add(BleSensorControllerSensorDataEvent(sensor.data, sensor.sensorType));
    });
    for (var sensor in listOfSensor) {
      sensor.stream
          .where((event) => event is BleSensorOnData)
          .pipe(streamBleSensorDataConsumer);
    }
  }

  @override
  Future<void> close() {
    streamHexoStateSub.cancel();
    streamBleSensorDataConsumer.close();
    // TODO: implement close
    return super.close();
  }
}
