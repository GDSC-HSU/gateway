import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_reactive_ble/src/discovered_devices_registry.dart';
import 'package:gateway/mock/mock_ble_device.dart';

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
    throw UnimplementedError();
  }

  @override
  Stream<ConnectionStateUpdate> connectToDevice(
      {required String id,
      Map<Uuid, List<Uuid>>? servicesWithCharacteristicsToDiscover,
      Duration? connectionTimeout}) {
    // TODO: implement connectToDevice
    throw UnimplementedError();
  }

  @override
  // TODO: implement connectedDeviceStream
  Stream<ConnectionStateUpdate> get connectedDeviceStream =>
      throw UnimplementedError();

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
  Future<void> initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  set logLevel(LogLevel logLevel) {
    // TODO: implement logLevel
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
  Stream<BleStatus> get statusStream => throw UnimplementedError();

  @override
  Stream<List<int>> subscribeToCharacteristic(
      QualifiedCharacteristic characteristic) {
    // TODO: implement subscribeToCharacteristic
    throw UnimplementedError();
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
}
