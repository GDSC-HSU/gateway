import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_reactive_ble/src/discovered_devices_registry.dart';
import 'package:gateway/mock/mock_ble_device.dart';
import 'package:rxdart/rxdart.dart';

class MockFlutterReactiveBle implements FlutterReactiveBle {
  @override
  // TODO: implement characteristicValueStream
  Stream<CharacteristicValue> get characteristicValueStream =>
      throw UnimplementedError();

  @override
  Future<void> clearGattCache(String deviceId) {
    // TODO: implement clearGattCache
    throw UnimplementedError();
  }

  @override
  Stream<ConnectionStateUpdate> connectToAdvertisingDevice(
      {required String id,
      required List<Uuid> withServices,
      required Duration prescanDuration,
      Map<Uuid, List<Uuid>>? servicesWithCharacteristicsToDiscover,
      Duration? connectionTimeout}) {
    // TODO: implement connectToAdvertisingDevice
    return Stream.fromIterable([
      ConnectionStateUpdate(
          connectionState: DeviceConnectionState.connecting,
          deviceId: mock_esp32.id,
          failure: null),
      ConnectionStateUpdate(
          connectionState: DeviceConnectionState.connected,
          deviceId: mock_esp32.id,
          failure: null)
    ]).asyncMap((event) async =>
        await Future.delayed(Duration(seconds: 2), () => event));
  }

  @override
  Stream<ConnectionStateUpdate> connectToDevice(
      {required String id,
      Map<Uuid, List<Uuid>>? servicesWithCharacteristicsToDiscover,
      Duration? connectionTimeout}) {
    // TODO: implement connectToDevice
    return Stream.fromIterable([
      ConnectionStateUpdate(
          connectionState: DeviceConnectionState.connecting,
          deviceId: mock_esp32.id,
          failure: null),
      ConnectionStateUpdate(
          connectionState: DeviceConnectionState.connected,
          deviceId: mock_esp32.id,
          failure: null)
    ]);
  }

  @override
  // TODO: implement connectedDeviceStream
  Stream<ConnectionStateUpdate> get connectedDeviceStream =>
      Stream.fromIterable([
        ConnectionStateUpdate(
            connectionState: DeviceConnectionState.connecting,
            deviceId: mock_esp32.id,
            failure: null),
        ConnectionStateUpdate(
            connectionState: DeviceConnectionState.connected,
            deviceId: mock_esp32.id,
            failure: null)
      ]);

  @override
  Future<void> deinitialize() {
    // TODO: implement deinitialize
    throw UnimplementedError();
  }

  @override
  Future<List<DiscoveredService>> discoverServices(String deviceId) {
    // TODO: implement discoverServices
    throw UnimplementedError();
  }

  @override
  Future<void> initialize() async {
    print("object");
  }

  @override
  Future<List<int>> readCharacteristic(QualifiedCharacteristic characteristic) {
    // TODO: implement readCharacteristic
    throw UnimplementedError();
  }

  @override
  Future<void> requestConnectionPriority(
      {required String deviceId, required ConnectionPriority priority}) {
    // TODO: implement requestConnectionPriority
    throw UnimplementedError();
  }

  @override
  Future<int> requestMtu({required String deviceId, required int mtu}) {
    // TODO: implement requestMtu
    throw UnimplementedError();
  }

  @override
  Stream<DiscoveredDevice> scanForDevices(
      {required List<Uuid> withServices,
      ScanMode scanMode = ScanMode.balanced,
      bool requireLocationServicesEnabled = true}) {
    return Stream.fromFuture(
        Future.delayed(const Duration(seconds: 5), () => mock_esp32));
  }

  @override
  DiscoveredDevicesRegistryImpl get scanRegistry => throw UnimplementedError();

  @override
  // TODO: implement status
  BleStatus get status => BleStatus.ready;

  @override
  // TODO: implement statusStream
  Stream<BleStatus> get statusStream => Stream.fromIterable([BleStatus.ready]);

  @override
  Stream<List<int>> subscribeToCharacteristic(
      QualifiedCharacteristic characteristic) {
    // TODO: implement subscribeToCharacteristic
    return Stream.fromIterable([
      [0, 1, 2, 3, 4, 5]
    ]);
  }

  @override
  Future<void> writeCharacteristicWithResponse(
      QualifiedCharacteristic characteristic,
      {required List<int> value}) {
    // TODO: implement writeCharacteristicWithResponse
    throw UnimplementedError();
  }

  @override
  Future<void> writeCharacteristicWithoutResponse(
      QualifiedCharacteristic characteristic,
      {required List<int> value}) {
    // TODO: implement writeCharacteristicWithoutResponse
    throw UnimplementedError();
  }

  @override
  set logLevel(LogLevel logLevel) {
    // TODO: implement logLevel
  }
}
