part of 'ble_device_connection_bloc.dart';

class BleDeviceConnectionState extends Equatable {
  final ConnectionStateUpdate? deviceConnectionState;

  get deviceId => deviceConnectionState!.deviceId;
  DeviceConnectionState get connectionSate =>
      deviceConnectionState!.connectionState;

  const BleDeviceConnectionState(this.deviceConnectionState);

  factory BleDeviceConnectionState.connected(
          ConnectionStateUpdate deviceConnectionState) =>
      BleDeviceConnectionState(deviceConnectionState);

  factory BleDeviceConnectionState.init() =>
      const BleDeviceConnectionState(null);

  //TODO FIX
  @override
  List<Object> get props => [deviceConnectionState ?? ""];
}
