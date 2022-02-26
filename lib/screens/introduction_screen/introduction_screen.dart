import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: Container(
        padding: EdgeInsets.only(bottom: 140.h),
        child: PageView(
          children: [
            Container(
              color: GatewayColors.buttonBgLight,
              child: Center(child: Text('hello')),
            ),
            Container(
              color: GatewayColors.buttonBgLight,
              child: Center(child: Text('hellooooooooooooooo')),
            ),
            Container(
              color: GatewayColors.buttonBgLight,
              child: Center(child: Text('hellooooooo')),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 140.h,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 47.h,
              height: 47.h,
              decoration: BoxDecoration(
                color: GatewayColors.buttonBgLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
