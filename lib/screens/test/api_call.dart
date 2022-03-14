import 'package:flutter/material.dart';
import 'package:gateway/config/constants/service_constants.dart';
import 'package:gateway/mock/mock_model.dart';
import 'package:gateway/services/device_service.dart';

class APICallTest extends StatefulWidget {
  const APICallTest({Key? key}) : super(key: key);

  @override
  _APICallTestState createState() => _APICallTestState();
}

class _APICallTestState extends State<APICallTest> {
  final service = DeviceService();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.greenAccent,
      child: Column(
        children: [
          const Text(
              'TEST API ${AppConstantsService.ENDPOINT_VERSION} SECTION'),
          TextButton(
              onPressed: () => {service.postDeviceData(mockDeviceSensorData)},
              child: Text("postDeviceData")),
          TextButton(
              onPressed: () async => {
                    service
                        .postDeviceDetail(await DeviceService.getDeviceInfo())
                  },
              child: Text("device Claim"))
        ],
      ),
    );
  }
}
