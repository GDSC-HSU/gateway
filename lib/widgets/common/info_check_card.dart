import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';

class InfoCheckCard extends StatelessWidget {
  const InfoCheckCard({
    Key? key,
    required this.imageIcon,
    required this.title,
    required this.iconStatus,
  }) : super(key: key);
  final String imageIcon, title;
  final bool iconStatus;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      width: double.infinity,
      height: 45.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: GatewayColors.borderCheck,
        ),
        borderRadius: BorderRadius.circular(10.h),
      ),
      child: ListTile(
        leading: Image.asset(
          imageIcon,
          //'assets/images/thermometer-gun.png',
          scale: 13,
        ),
        title: Text(
          title,
          //'RFID Temperature',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        trailing: iconStatus == true
            ? Icon(
                Icons.check_circle_outline,
                color: GatewayColors.successColor,
              )
            : Icon(
                Icons.cancel_outlined,
                color: GatewayColors.failColor,
              ),
      ),
    );
  }
}
