import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/widgets/common/card_setup.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Text(
            'Scaning',
            style: TextStyle(
              color: GatewayColors.textDefaultBgLight,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        CardSetup(
          contentCard: Center(
            child: Text(
              'Now press the scan button to \nfind the device',
              style: TextStyle(
                color: GatewayColors.textDefaultBgLight,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: 40.sp),
        Container(
          height: 45.sp,
          width: 300.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: GatewayColors.buttonBgLight,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.flip,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10.h,
                ),
                Text(
                  'Scan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
