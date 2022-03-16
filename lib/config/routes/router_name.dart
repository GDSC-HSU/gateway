import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gateway/config/routes/routing.dart';
import 'package:gateway/di/di_ble_sensor.dart';
import 'package:gateway/screens/congratulation_screen/congratulation_screen.dart';
import 'package:gateway/screens/gateway_check_screen/gateway_check_screen.dart';
import 'package:gateway/screens/introduction_screen/introduction_screen.dart';
import 'package:gateway/screens/setup_screen/setup_screen.dart';
import 'package:gateway/widgets/confirm/confirm_screen.dart';
import 'package:gateway/widgets/connect/connect_screen.dart';
import 'package:gateway/widgets/scan/scan_screen.dart';

class RouterName {
  late List<CameraDescription> cameras;
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouting.introduction:
        return MaterialPageRoute(builder: (context) => IntroductionScreen());
      case AppRouting.scanning:
        return MaterialPageRoute(builder: (context) => ScanScreen());
      case AppRouting.connecting:
        return MaterialPageRoute(builder: (context) => ConnectScreen());
      case AppRouting.confirm:
        return MaterialPageRoute(builder: (context) => ConfirmScreen());
      case AppRouting.setup:
        return MaterialPageRoute(builder: (context) => SetupScreen());
      case AppRouting.gatewayCheck:
        return MaterialPageRoute(
            builder: (context) =>
                AppBLESensorDependencyProvider(child: GatewayCheckScreen()));
      case AppRouting.congratulation:
        return MaterialPageRoute(builder: (context) => CongratulationScreen());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}
