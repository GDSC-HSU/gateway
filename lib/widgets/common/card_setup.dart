import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';

class CardSetup extends StatelessWidget {
  const CardSetup({Key? key, required this.contentCard}) : super(key: key);
  final Widget contentCard;
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 10.w),
      //padding: const EdgeInsets.only(left: 24, top: 3, bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(
        //     color: ColorAndTextStyleMode().disableButtonBackground),
        borderRadius: BorderRadius.circular(10.r),
        gradient: LinearGradient(
          stops: [0.018, 0.018],
          colors: [
            GatewayColors.buttonBgLight,
            Colors.white,
          ],
        ),
      ),
      height: 300.h,
      child: contentCard,
    );
  }
}
