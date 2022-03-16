part of 'gateway_controller_bloc.dart';

abstract class GatewayControllerEvent extends Equatable {
  const GatewayControllerEvent();

  @override
  List<Object> get props => [];
}

class BleSensorControllerResetEvent extends GatewayControllerEvent {}

// class BleSensorControllerHexoEvent extends GatewayControllerEvent {
//   final HexoState state;

//   const BleSensorControllerHexoEvent(this.state);
//   @override
//   List<Object> get props => [state];
// }

class GatewayControllerBLESensorDataEvent extends GatewayControllerEvent {
  final List<int> data;

  final SensorType sensorType;
  const GatewayControllerBLESensorDataEvent(this.data, this.sensorType);
  @override
  List<Object> get props => [data, sensorType];
}

class BleSensorControllerSensorCommandEvent extends GatewayControllerEvent {
  final String data;
  final SensorType sensorType;
  const BleSensorControllerSensorCommandEvent(this.data, this.sensorType);
  @override
  List<Object> get props => [data, sensorType];
}
