import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gateway/blocs/ble_device_connection/bloc/ble_device_connection_bloc.dart';
import 'package:gateway/business_logic/ble_sensor/sensor/interface.dart';
import 'package:gateway/business_logic/ble_sensor/sensor/ble_sensor.dart';
import 'package:gateway/config/constants/ble_desgin_constants.g.dart';

enum SensorType { proximity, temp, distance }

class BLESensorProvider {
  final BleDeviceConnectionBloc bloc;

  BLESensorProvider(this.bloc);

  ISensorBehavior provide(SensorType sensorType) {
    switch (sensorType) {
      case SensorType.proximity:
        return BLESensor(bloc, BLE_CHARACTERISTIC_PROXIMITY_DISTANCE,
            BLE_SERVICE_PROXIMITY_UUID);
      case SensorType.temp:
        return BLESensor(bloc, BLE_CHARACTERISTIC_THERMOMETER_READ,
            BLE_SERVICE_THERMOMETER_UUID);
      default:
        throw ("Not Imp yet");
    }
  }
}
