import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';

class GuideConfirm extends StatelessWidget {
  const GuideConfirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
          child: Text(
            'Type in your organization devide code for device regisation.',
            style: TextStyle(
              color: GatewayColors.textDefaultBgLight,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
          child: Text(
            '1. Make sure you already register device in the web-dashboard.',
            style: TextStyle(
              color: GatewayColors.textDefaultBgLight,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
          child: Text(
            '2. After adding device will be apper in your ogaziation dasdboard.',
            style: TextStyle(
              color: GatewayColors.textDefaultBgLight,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
          child: Text(
            '3. If error click on the question mark icon to watch our guide video.',
            style: TextStyle(
              color: GatewayColors.textDefaultBgLight,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
