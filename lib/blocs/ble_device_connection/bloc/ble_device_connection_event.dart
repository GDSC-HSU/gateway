part of 'ble_device_connection_bloc.dart';

abstract class BleDeviceConnectionEvent extends Equatable {
  const BleDeviceConnectionEvent();
}

class BLEDeviceConnectionUpdateEvent extends BleDeviceConnectionEvent {
  final ConnectionStateUpdate stateUpdate;

  const BLEDeviceConnectionUpdateEvent(this.stateUpdate);

  @override
  // TODO: implement props
  List<Object?> get props => [stateUpdate];
}

class BLEDeviceConnectionRequestEvent extends BleDeviceConnectionEvent {
  final String scannedDeviceId;
  final bool isDelay;

  const BLEDeviceConnectionRequestEvent(this.scannedDeviceId,
      {this.isDelay = true});

  @override
  // TODO: implement props
  List<Object?> get props => [scannedDeviceId];
}
