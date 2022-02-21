class DeviceHardwareInfo {
  late String macAddress;
  late String nameHardware;
  late String os;

  DeviceHardwareInfo(
      {required this.macAddress, required this.nameHardware, required this.os});

  DeviceHardwareInfo.fromJson(Map<String, dynamic> json) {
    macAddress = json['macAddress'];
    nameHardware = json['nameHardware'];
    os = json['os'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['macAddress'] = macAddress;
    data['nameHardware'] = nameHardware;
    data['os'] = os;
    return data;
  }
}
