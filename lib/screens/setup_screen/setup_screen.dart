import 'package:flutter/material.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/screens/setup_screen/setup_view.dart';

class SetupScreen extends StatefulWidget {
  SetupScreen({Key? key}) : super(key: key);

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GatewayColors.scaffoldBgLight,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        elevation: 0.0,
        title: const Center(
          child: Text(
            "Setup Gateway",
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: GatewayColors.scaffoldBgLight,
      ),
      body: SetupView(),
    );
  }
}
