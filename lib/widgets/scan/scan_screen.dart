import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/widgets/common/button_custom.dart';
import 'package:gateway/widgets/common/card_setup.dart';

class ScanScreen extends StatefulWidget {
  ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16.h, left: 16.h, top: 8.h),
            child: Text(
              'SCANNING',
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
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 25.h),
          ButtonCustom(
            bgColor: GatewayColors.buttonBgLight,
            iconButton: Icon(
              Icons.flip,
              color: Colors.white,
            ),
            title: 'Scan',
            onFunction: () {},
          ),
        ],
      ),
    );
  }
}
