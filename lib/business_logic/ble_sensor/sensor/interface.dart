import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gateway/blocs/ble_device_connection/bloc/ble_device_connection_bloc.dart';

abstract class ISensorBehavior {
  Future<List<int>> read();
  Stream<List<int>> notify();
  Future<void> write(List<int> value);
  void reset();
}

abstract class BaseBLESensor implements ISensorBehavior {
  late QualifiedCharacteristic qualifiedCharacteristic;
  final BleDeviceConnectionBloc bloc;
  final Uuid ble_char_uuid;
  final Uuid ble_ser_uuid;

  BaseBLESensor(this.bloc, this.ble_char_uuid, this.ble_ser_uuid);
}
