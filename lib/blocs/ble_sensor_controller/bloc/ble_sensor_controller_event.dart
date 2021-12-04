part of 'ble_sensor_controller_bloc.dart';

abstract class BleSensorControllerEvent extends Equatable {
  const BleSensorControllerEvent();

  @override
  List<Object> get props => [];
}

class BleSensorControllerResetEvent extends BleSensorControllerEvent {}

class BleSensorControllerHexoEvent extends BleSensorControllerEvent {
  final HexoState state;

  const BleSensorControllerHexoEvent(this.state);
  @override
  List<Object> get props => [state];
}

class BleSensorControllerSensorDataEvent extends BleSensorControllerEvent {
  final List<int> data;

  final SensorType sensorType;
  const BleSensorControllerSensorDataEvent(this.data, this.sensorType);
  @override
  List<Object> get props => [data, sensorType];
}

class BleSensorControllerSensorCommandEvent extends BleSensorControllerEvent {
  final String data;
  final SensorType sensorType;
  const BleSensorControllerSensorCommandEvent(this.data, this.sensorType);
  @override
  List<Object> get props => [data, sensorType];
}
