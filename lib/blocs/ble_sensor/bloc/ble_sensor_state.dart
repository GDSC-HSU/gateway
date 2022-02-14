part of 'ble_sensor_bloc.dart';

abstract class BleSensorState extends Equatable {
  const BleSensorState();

  @override
  List<Object> get props => [];
}

class BleSensorInitial extends BleSensorState {}

class BleSensorOnData extends BleSensorState {
  final List<int> data;
  final SensorType sensorType;
  const BleSensorOnData(this.data, this.sensorType);
  @override
  List<Object> get props => [data, sensorType];
}
