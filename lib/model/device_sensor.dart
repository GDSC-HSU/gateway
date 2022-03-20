// ignore_for_file: unnecessary_new

import 'package:gateway/blocs/ble_sensor_controller/controller_state_from.dart';
import 'package:gateway/config/constants/service_constants.dart';
import 'package:gateway/model/covid_identification.dart';

class DeviceSensorData {
  late String did;
  late double bodyTemperature;
  late bool faceMask;
  late CovidIdentification? covidIdentification;
  late bool isComplete;

  DeviceSensorData(
      {required this.did,
      required this.bodyTemperature,
      required this.faceMask,
      required this.covidIdentification,
      required this.isComplete});

  DeviceSensorData.fromJson(Map<String, dynamic> json) {
    did = json['did'];
    bodyTemperature = json['bodyTemperature'];
    faceMask = json['faceMask'];
    if (json['covidIdentification'] != null) {
      covidIdentification =
          CovidIdentification.fromJson(json['covidIdentification']);
    } else {
      covidIdentification = null;
    }
    isComplete = json['isComplete'];
  }

  DeviceSensorData.fromFromData(Map<String, dynamic> json) {
    did = AppConstantsService.DEVICE_ID;
    bodyTemperature = json[FromType.temperature.name];
    faceMask = json[FromType.maskCamera.name];
    final identificationMethod =
        json[FromType.qrCamera.name] == null ? "RFID" : "QR";
    final identificationData =
        json[FromType.qrCamera.name] ?? json[FromType.identification.name];
    covidIdentification = CovidIdentification.fromFormData(
        method: identificationMethod, data: identificationData);
    isComplete = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['did'] = did;
    data['bodyTemperature'] = bodyTemperature;
    data['faceMask'] = faceMask;
    if (covidIdentification != null) {
      data['covidIdentification'] = covidIdentification!.toJson();
    }
    data['isComplete'] = isComplete;
    return data;
  }
}
