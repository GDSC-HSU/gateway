import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gateway/blocs/ble_device_connection/bloc/ble_device_connection_bloc.dart';
import 'package:gateway/blocs/ble_sensor/ble_sensor.dart';
import 'package:gateway/blocs/ble_sensor/sensor/interface.dart';

part 'ble_sensor_event.dart';
part 'ble_sensor_state.dart';

class BleSensorBloc extends Bloc<BleSensorEvent, BleSensorState> {
  final SensorType sensorType;
  late ISensorBehavior sensorBehavior;
  final BleDeviceConnectionBloc deviceConnectionBloc;
  BleSensorBloc(this.sensorType, this.deviceConnectionBloc)
      : super(BleSensorInitial()) {
    sensorBehavior =
        BLESensorProvider(deviceConnectionBloc).provide(sensorType);
    on<BleSensorEvent>((event, emit) {
      // TODO: implement event handler
    });

    sensorBehavior.notify().listen((event) {
      print(event);
      emit(BleSensorOnData(event, sensorType));
    });
  }
}
