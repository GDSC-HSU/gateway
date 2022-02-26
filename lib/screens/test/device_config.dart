import 'package:flutter/material.dart';
import 'package:gateway/config/constants/service_constants.dart';
import 'package:gateway/mock/mock_model.dart';
import 'package:gateway/model/device_info.dart';
import 'package:gateway/model/organization_info.dart';
import 'package:gateway/services/device_config_service.dart';

class DeviceIdentityTest extends StatefulWidget {
  const DeviceIdentityTest({Key? key}) : super(key: key);

  @override
  _DeviceIdentityTestState createState() => _DeviceIdentityTestState();
}

class _DeviceIdentityTestState extends State<DeviceIdentityTest> {
  Future<void> _mockLoadIdentity() async {
    await DeviceIdentityService.saveDeviceIdentityConfig(mockDeviceIdentity,
        jwtToken: "jwt:xxxxx");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () async => {await _mockLoadIdentity()},
            child: const Text("load device_identity form API")),
        TextButton(
            onPressed: () async => {print(AppConstantsService.HOST_NAME)},
            child: const Text("print device_identity constance")),
      ],
    );
  }
}
