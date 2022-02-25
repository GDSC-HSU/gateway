// THIS CLASS USE FOR SHARE_PERF
import 'package:gateway/model/device_info.dart';
import 'package:gateway/model/organization_info.dart';

class DeviceIdentity {
  late String deviceId;
  late String deviceApiKey;
  late String deviceAccessKey;
  late String? deviceJwt;
  late String deviceOrgEndPoint;
  late String mqttUserName;
  late String mqttPassword;

  DeviceIdentity(
      {required this.deviceId,
      required this.deviceApiKey,
      required this.deviceAccessKey,
      this.deviceJwt,
      required this.deviceOrgEndPoint,
      required this.mqttUserName,
      required this.mqttPassword});

  DeviceIdentity addDeviceInfo(DeviceInfo deviceInfo) {
    deviceId = deviceInfo.id;
    deviceAccessKey = deviceInfo.accessKey;
    return this;
  }

  DeviceIdentity addOrganizationInfo(OrganizationInfo organizationInfo) {
    deviceOrgEndPoint = organizationInfo.endpoint;
    deviceApiKey = organizationInfo.apiKey;
    return this;
  }

  DeviceIdentity addJWT(String jwtToken) {
    deviceJwt = jwtToken;
    return this;
  }

  DeviceIdentity.fromJson(Map<String, dynamic> json) {
    deviceId = json['id'];
    deviceApiKey = json['apiKey'];
    deviceAccessKey = json['accessKey'];
    deviceJwt = json['device_jwt'];
    deviceOrgEndPoint = json['endpoint'];
    mqttUserName = json['mqttUserName'];
    mqttPassword = json['mqttPassword'];
  }

  Map<String, dynamic> toJson() {
    late Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = deviceId;
    data['apiKey'] = deviceApiKey;
    data['accessKey'] = deviceAccessKey;
    data['device_jwt'] = deviceJwt;
    data['endpoint'] = deviceOrgEndPoint;
    data['mqttUserName'] = mqttUserName;
    data['mqttPassword'] = mqttPassword;
    return data;
  }
}
