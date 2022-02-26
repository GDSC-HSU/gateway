import 'package:flutter/material.dart';
import 'package:gateway/config/themes/gateway_color.dart';

class IntroductionScreen extends StatefulWidget {
  IntroductionScreen({Key? key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Container(
            color: GatewayColors.scaffoldBgLight,
            child: Center(child: Text('hello')),
          ),
          Container(
            color: GatewayColors.scaffoldBgLight,
            child: Center(child: Text('hellooooooooooooooo')),
          ),
          Container(
            color: GatewayColors.scaffoldBgLight,
            child: Center(child: Text('hellooooooo')),
          ),
        ],
      ),
    );
  }
}
