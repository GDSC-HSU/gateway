import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gateway/app.dart';
import 'package:gateway/firebase_options.dart';
import 'package:gateway/services/device_config_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  await FlutterReactiveBle().initialize();
  final share = await SharedPreferences.getInstance();
  share.clear();
  await DeviceIdentityService.ensureInitialized();
  final isDeviceBeenConfigure = DeviceIdentityService.isDeviceBeenConfigured;
  cameras = await availableCameras();
  _portraitModeOnly();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vi')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MyApp(isConfigured: isDeviceBeenConfigure),
    ),
  );
}

void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}