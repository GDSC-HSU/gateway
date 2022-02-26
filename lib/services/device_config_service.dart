import 'dart:convert';

import 'package:gateway/config/constants/service_constants.dart';
import 'package:gateway/model/device_identity.dart';
import 'package:gateway/model/device_info.dart';
import 'package:gateway/model/organization_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceIdentityService {
  // state
  static const _isLocalBeenCachedKey = "is-device-config-cached";
  static bool _isLocalBeenCached = false;
  //

  // importance
  static const _sharedPreferencesDeviceIdentityKey = "device-identity";
  //

  // TODO add removable

  static Future<void> saveDeviceIdentityConfig(DeviceIdentity deviceIdentity,
      {String? jwtToken}) async {
    final _preferences = await SharedPreferences.getInstance();
    // builder
    if (jwtToken != null) {
      deviceIdentity.addJWT(jwtToken);
    }
    //

    // save to SharedPreferences
    final jsonString = jsonEncode(deviceIdentity.toJson());
    await _preferences.setString(
        _sharedPreferencesDeviceIdentityKey, jsonString);

    // After save we update constance
    deviceIdentity = await _readDeviceIdentityConfig();
    _updateConstance(deviceIdentity);
    await _updateState(isCached: true);
  }

  static void _updateConstance(DeviceIdentity deviceIdentity) {
    // DANGER OPERATION
    AppConstantsService.ORG_ENDPOINT = deviceIdentity.deviceOrgEndPoint;
    AppConstantsService.DEVICE_ID = deviceIdentity.deviceId;
    AppConstantsService.HOST_NAME = deviceIdentity.deviceOrgEndPoint;
    AppConstantsService.DEVICE_ACCESS_TOKEN = deviceIdentity.deviceAccessKey;
    AppConstantsService.API_KEY = deviceIdentity.deviceApiKey;
    AppConstantsService.MQTT_USERNAME = deviceIdentity.mqttUserName;
    AppConstantsService.MQTT_PASSWORD = deviceIdentity.mqttPassword;
    if (deviceIdentity.deviceJwt != null) {
      AppConstantsService.DEVICE_JWT = deviceIdentity.deviceJwt!;
    }
  }

  static bool get isDeviceBeenConfigured {
    bool doNotNull = [
      AppConstantsService.ORG_ENDPOINT,
      AppConstantsService.DEVICE_ACCESS_TOKEN,
      AppConstantsService.API_KEY
    ].every((element) => element.isNotEmpty);
    return _isLocalBeenCached && doNotNull;
  }

  static Future<void> _updateState({required bool isCached}) async {
    final _preferences = await SharedPreferences.getInstance();
    _preferences.setBool(_isLocalBeenCachedKey, isCached);
  }

  static Future<void> ensureInitialized() async {
    final _preferences = await SharedPreferences.getInstance();
    var result = _preferences.get(_isLocalBeenCachedKey);
    if (result != null && result == true) {
      //  device identity has been cached we read and update constance
      _isLocalBeenCached = true;
      _preferences.setBool(_isLocalBeenCachedKey, true);
      final deviceIdentity = await _readDeviceIdentityConfig();
      _updateConstance(deviceIdentity);
    } else {
      _isLocalBeenCached = false;
      _preferences.setBool(_isLocalBeenCachedKey, false);
    }
  }

  static Future<DeviceIdentity> _readDeviceIdentityConfig() async {
    final _preferences = await SharedPreferences.getInstance();
    final jsonString =
        _preferences.getString(_sharedPreferencesDeviceIdentityKey);
    // decode
    final json = jsonDecode(jsonString!);
    //
    final deviceIdentity = DeviceIdentity.fromJson(json);
    return deviceIdentity;
  }
}
