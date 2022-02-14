import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gateway/blocs/ble_device_connection/bloc/ble_device_connection_bloc.dart';
import 'package:gateway/blocs/ble_sensor/sensor/interface.dart';

class BLESensor extends BaseBLESensor {
  BLESensor(BleDeviceConnectionBloc bloc, Uuid ble_char_uuid, Uuid ble_ser_uuid)
      : super(bloc, ble_char_uuid, ble_ser_uuid) {
    qualifiedCharacteristic = QualifiedCharacteristic(
        characteristicId: ble_char_uuid,
        serviceId: ble_ser_uuid,
        deviceId: bloc.state.deviceConnectionState!.deviceId);
  }

  @override
  notify() {
    return bloc.repository.ble
        .subscribeToCharacteristic(qualifiedCharacteristic);
  }

  @override
  Future<List<int>> read() async {
    return await bloc.repository.ble
        .readCharacteristic(qualifiedCharacteristic);
  }

  @override
  Future<void> write(List<int> value) async {
    await bloc.repository.ble
        .writeCharacteristicWithResponse(qualifiedCharacteristic, value: value);
  }

  @override
  void reset() {
    // TODO: implement reset
  }
}
