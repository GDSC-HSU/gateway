import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:gateway/config/constants/service_constants.dart';
import 'package:gateway/model/device_hardware_info.dart';
import 'package:gateway/model/device_sensor.dart';
import 'package:http/http.dart' as http;

class DeviceService {
  Future<void> postDeviceData(DeviceSensorData deviceSensorData) async {
    final headers = <String, String>{
      AppConstantsService.API_KEY_HEADER: AppConstantsService.API_KEY,
      AppConstantsService.DEVICE_ACCESS_TOKEN_HEADER:
          AppConstantsService.DEVICE_ACCESS_TOKEN,
      AppConstantsService.PREFIX_CONTENT_TYPE: AppConstantsService.CONTENT_TYPE,
    };
    // url
    final url = Uri.parse(AppConstantsService.ORG_ENDPOINT +
        AppConstantsService.ENDPOINT_VERSION +
        AppConstantsService.DATA_PATH);

    try {
      var response = await http.post(url,
          headers: headers, body: jsonEncode(deviceSensorData.toJson()));
      if (response.statusCode == 200) {
        return;
      } else {
        // 404: missing field
        // 403: API-KEY invalid
        //         ACCESS-KEY invalid
        throw "[Dev] Error";
      }
    } catch (e) {
      throw "[Dev] Error";
    }
  }

  Future<void> postDeviceDetail(Map info) async {
    // device header
    final headers = <String, String>{
      AppConstantsService.API_KEY_HEADER: AppConstantsService.API_KEY,
      AppConstantsService.DEVICE_ACCESS_TOKEN_HEADER:
          AppConstantsService.DEVICE_ACCESS_TOKEN,
      AppConstantsService.PREFIX_CONTENT_TYPE: AppConstantsService.CONTENT_TYPE,
    };
    // url
    final url = Uri.parse(AppConstantsService.ORG_ENDPOINT +
        AppConstantsService.ENDPOINT_VERSION +
        AppConstantsService.DEVICE_PATH);
    //
    final body = {
      AppConstantsService.DEVICE_ID_KEY: AppConstantsService.DEVICE_ID,
      AppConstantsService.DEVICE_HARDWARE_INFO_KEY: info
    };

    try {
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        return;
      } else {
        throw "[Dev] Error";
      }
    } catch (e) {
      throw "[Dev] Error";
    }
  }

  static Future<Map<String, dynamic>> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    return deviceInfo.toMap();
// Push [map] to your service.
  }
}
