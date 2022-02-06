part of 'ble_sensor_bloc.dart';

abstract class BleSensorEvent extends Equatable {
  const BleSensorEvent();

  @override
  List<Object> get props => [];
}

class BleSensorResetEvent extends BleSensorEvent {}

class BleSensorReadEvent extends BleSensorEvent {}

class BleSensorWriteEvent extends BleSensorEvent {
  final String data;

  const BleSensorWriteEvent(this.data);
  @override
  List<Object> get props => [data];
}
