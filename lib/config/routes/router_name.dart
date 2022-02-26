import 'package:flutter/material.dart';
import 'package:gateway/screens/introduction_screen/introduction_screen.dart';
import 'package:gateway/widgets/confirm/confirm_screen.dart';
import 'package:gateway/widgets/connect/connect_screen.dart';
import 'package:gateway/widgets/scan/scan_screen.dart';

class RouterName {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'introduction':
        return MaterialPageRoute(builder: (context) => IntroductionScreen());
      case 'scanning':
        return MaterialPageRoute(builder: (context) => ScanScreen());
      case 'connecting':
        return MaterialPageRoute(builder: (context) => ConnectScreen());
      case 'confirm':
        return MaterialPageRoute(builder: (context) => ConfirmScreen());
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
