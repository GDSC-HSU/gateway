import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gateway/blocs/ble_sensor/ble_sensor.dart';
import 'package:gateway/blocs/ble_sensor/bloc/ble_sensor_bloc.dart';
import 'package:gateway/blocs/ble_sensor_controller/controller_state.dart';
import 'package:gateway/blocs/ble_sensor_controller/controller_state_from.dart';
import 'package:gateway/services/device_service.dart';
import 'package:reactive_forms/reactive_forms.dart';

part 'gateway_controller_bloc_event.dart';
part 'gateway_controller_bloc_state.dart';

// TODO detect does having person in front
class GatewayControllerBloc
    extends Bloc<GatewayControllerEvent, GatewayControllerState> {
  final List<BleSensorBloc> listOfSensor;
  late StreamController<BleSensorOnData> streamBleSensorDataConsumer;
  final DeviceService deviceService = DeviceService();
  late StreamSubscription streamHexoStateSub;
  final HexoStateForm hexoState = HexoStateForm();

  GatewayControllerBloc(this.listOfSensor)
      : super(BleSensorControllerInitial()) {
    streamBleSensorDataConsumer = StreamController();
    _initListenSenorData();
    _listFormEvent();

    // Send command to BLE sensor
    // inner bloc communication
    on<BleSensorControllerSensorCommandEvent>((event, emit) => {
          listOfSensor
              .firstWhere((sensor) => event.sensorType == sensor.sensorType)
              .add(BleSensorWriteEvent(event.data))
        });

    // listen and add data to hexo State

    on<GatewayControllerBLESensorDataEvent>((event, emit) => {
          if (event.sensorType != SensorType.radar)
            {hexoState.addBLEDataToForm(event)}
          else
            {_ifNoMovementRestartFrom()}
        });

    on<BleSensorControllerResetEvent>((event, emit) => {hexoState.resetFrom()});
  }

  _initListenSenorData() {
    streamBleSensorDataConsumer.stream.listen((sensor) {
      add(GatewayControllerBLESensorDataEvent(sensor.data, sensor.sensorType));
    });
    for (var sensor in listOfSensor) {
      sensor.stream.where((event) => event is BleSensorOnData).listen((sensor) {
        sensor = sensor as BleSensorOnData;
        add(GatewayControllerBLESensorDataEvent(
            sensor.data, sensor.sensorType));
      });
      // .pipe(streamBleSensorDataConsumer);
    }
  }

  _listFormEvent() {
    streamHexoStateSub = hexoState.form.statusChanged.listen((event) async {
      if (hexoState.customControllerStatusValid()) {
        try {
          final data = hexoState.toSensorData();
          hexoState.resetFrom();
          emit(GatewayCheckUploading());
          await deviceService.postDeviceData(data);
          emit(GatewayCheckUploadedSuccessful());
        } catch (e) {
          emit(GatewayCheckUploadError());
        }
      }
    });
  }

  _ifNoMovementRestartFrom() {
    hexoState.resetFrom();
  }

  @override
  void onChange(Change<GatewayControllerState> change) {
    super.onChange(change);
  }

  @override
  Future<void> close() {
    streamHexoStateSub.cancel();
    streamBleSensorDataConsumer.close();
    // TODO: implement close
    return super.close();
  }
}
