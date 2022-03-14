part of 'ble_sensor_controller_bloc.dart';

abstract class BleSensorControllerState extends Equatable {
  BleSensorControllerState();

  @override
  List<Object> get props => [];
}

class BleSensorControllerInitial extends BleSensorControllerState {}

class BleSensorControllerValidState extends BleSensorControllerState {
  final HexoState hexoState;

  BleSensorControllerValidState(this.hexoState);

  @override
  List<Object> get props => [hexoState];
}

class BleSensorControllerInValidState extends BleSensorControllerState {
  final SensorType sensorTypeLocation;
  final String mess;

  BleSensorControllerInValidState(this.sensorTypeLocation, this.mess);

  @override
  List<Object> get props => [sensorTypeLocation, mess];
}
