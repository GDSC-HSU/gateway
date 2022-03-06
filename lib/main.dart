import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gateway/app.dart';
import 'package:gateway/screens/gateway_check_screen/gateway_check_screen.dart';
import 'package:gateway/services/device_config_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await FlutterReactiveBle().initialize();
  await DeviceIdentityService.ensureInitialized();
  cameras = await availableCameras();

  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('vn')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: App()));
}
