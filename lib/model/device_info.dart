import 'package:gateway/model/device_hardware_info.dart';

class DeviceInfo {
  late String id;
  late String accessKey;
  late String oid;
  late String name;
  late String location;
  late DeviceHardwareInfo? hardwareInfo;
  late List<String> tags;

  DeviceInfo(
      {required this.id,
      required this.accessKey,
      required this.oid,
      required this.name,
      required this.location,
      this.hardwareInfo,
      required this.tags});

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accessKey = json['accessKey'];
    oid = json['oid'];
    name = json['name'];
    location = json['location'];
    hardwareInfo = json['hardwareInfo'] != null
        ? DeviceHardwareInfo.fromJson(json['hardwareInfo'])
        : null;
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['accessKey'] = accessKey;
    data['oid'] = oid;
    data['name'] = name;
    data['location'] = location;
    if (hardwareInfo != null) {
      data['hardwareInfo'] = hardwareInfo!.toJson();
    }
    data['tags'] = tags;
    return data;
  }
}
