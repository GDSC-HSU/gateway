import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/widgets/adv/carousel_with_dot.dart';

import '../../blocs/ble_sensor_controller/bloc/gateway_controller_bloc.dart';

class AdvScreen extends StatelessWidget {
  const AdvScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/images/INFO.png',
      'assets/images/FIND_A_FAC.png',
      'assets/images/TALK.png',
      'assets/images/Core_team.png',
    ];
    final size = MediaQuery.of(context).size;
    return BlocListener<GatewayControllerBloc, GatewayControllerState>(
      listener: (context, state) {
        if (state is GatewayMotionDetected) {
          if (state.isMotionAppear) {
            Navigator.of(context).pop();
          }
        }
        // TODO: implement listener
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Positioned(
              right: -10.h,
              top: -35.h,
              child: Image.asset(
                'assets/images/giphy.gif',
                scale: 1.3,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.4),
              child: Image.asset(
                  'assets/images/Logo_Google-DSC-Lockup-Centered.png'),
            ),
            Positioned(
              bottom: 350.h,
              child: Image.asset(
                'assets/images/giphy_star.gif',
                scale: 2.5,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.6),
              child: CarouselWithDotsPage(imgList: imgList),
            ),
          ],
        ),
      ),
    );
  }
}
