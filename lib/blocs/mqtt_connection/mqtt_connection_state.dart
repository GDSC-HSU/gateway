part of 'mqtt_connection_cubit.dart';

class MQTTConnectionState extends Equatable {
  final MQTTConnectionStatus status;

  const MQTTConnectionState(this.status);

  const MQTTConnectionState.init() : status = MQTTConnectionStatus.init;
  const MQTTConnectionState.connected()
      : status = MQTTConnectionStatus.connected;

  const MQTTConnectionState.disconnected()
      : status = MQTTConnectionStatus.disconnected;

  const MQTTConnectionState.reconnecting()
      : status = MQTTConnectionStatus.reconnecting;

  const MQTTConnectionState.connecting()
      : status = MQTTConnectionStatus.connecting;

  @override
  // TODO: implement props
  List<Object?> get props => [status];
}
