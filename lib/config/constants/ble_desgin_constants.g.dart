//THIS IS GENERATED IN ble_uuid_conf.yml
//Generate in git submodule (ble_devices) -> ble_uuid+generator.py
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
// ignore_for_file: non_constant_identifier_names
Uuid BLE_SERVICE_PROXIMITY_UUID = Uuid.parse("00000A00-5226-4AE0-8977-656FD3C42DA2");
            
Uuid BLE_CHARACTERISTIC_PROXIMITY_DISTANCE = Uuid.parse("00000A02-5226-4AE0-8977-656FD3C42DA2");
            
Uuid BLE_SERVICE_THERMOMETER_UUID = Uuid.parse("00000B00-5226-4AE0-8977-656FD3C42DA2");
            
Uuid BLE_CHARACTERISTIC_THERMOMETER_READ = Uuid.parse("00000B01-5226-4AE0-8977-656FD3C42DA2");
            
Uuid BLE_SERVICE_RFID_UUID = Uuid.parse("00000B00-5226-4AE0-8977-656FD3C42DA2");
            
Uuid BLE_CHARACTERISTIC_RFID_READ = Uuid.parse("00000B01-5226-4AE0-8977-656FD3C42DA2");
            
Uuid BLE_SERVICE_OTA_UUID = Uuid.parse("1d14d6ee-fd63-4fa1-bfa4-8f47b42119f0");
            
Uuid BLE_CHARACTERISTIC_OTA_CONTROL = Uuid.parse("f7bf3564-fb6d-4e53-88a4-5e37e0326063");
            
Uuid BLE_CHARACTERISTIC_OTA_WRITE_NO_RSP = Uuid.parse("e984227f3-34fc-4045-a5d0-2c581f81a153");
            
Uuid BLE_SERVICE_BATTERY = Uuid.parse("180F");
            
Uuid BLE_CHARACTERISTIC_BATTERY_LEVEL = Uuid.parse("2A19");
            

List<Uuid> deviceServices = [BLE_SERVICE_PROXIMITY_UUID,BLE_SERVICE_THERMOMETER_UUID,BLE_SERVICE_RFID_UUID,BLE_SERVICE_OTA_UUID,BLE_SERVICE_BATTERY,];
const String DEVICE_NAME = "esp32-gateway";