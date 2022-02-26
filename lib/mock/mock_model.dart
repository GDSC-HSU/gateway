import 'package:gateway/model/covid_identification.dart';
import 'package:gateway/model/device_hardware_info.dart';
import 'package:gateway/model/device_identity.dart';
import 'package:gateway/model/device_info.dart';
import 'package:gateway/model/device_sensor.dart';
import 'package:gateway/model/organization_info.dart';

final DeviceInfo mockDeviceInfo = DeviceInfo(
    name: "xxx-flutter-device-name-xxx",
    accessKey: "xxx-flutter-accessKey-xxxx",
    oid: "xxx-hsu-xxx",
    location: "",
    id: "xxx-flutter-device-id-xxx",
    tags: []);

final DeviceHardwareInfo mockDeviceHardWareInfo = DeviceHardwareInfo(
    macAddress: "", nameHardware: "IphoneXXX", os: "AppleVSSony");

final OrganizationInfo mockOrgInfo = OrganizationInfo(
    id: "xxx-hsu-xxx",
    apiKey: "xxx-org-api-key",
    name: "hsu",
    endpoint: "http://192.168.1.6:3000");

final DeviceSensorData mockDeviceSensorData = DeviceSensorData(
    bodyTemperature: 30.5,
    covidIdentification: CovidIdentification(
        identificationMethod: "QR", identificationData: "xxx-covid-string-xxx"),
    did: mockDeviceInfo.id,
    faceMask: true,
    isComplete: true);

final DeviceIdentity mockDeviceIdentity = DeviceIdentity(
    deviceAccessKey: 'ce9go8K34sCipHy_AsotD',
    deviceApiKey: '123',
    deviceId: 'z2OnUdMhstbJRpf1Wqp2',
    deviceOrgEndPoint: "http://192.168.1.6:3000",
    mqttPassword: 'xxx-xxx',
    mqttUserName: 'xxx-xxx');
