import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/widgets/common/button_custom.dart';
import 'package:gateway/widgets/common/card_setup.dart';
import 'package:gateway/widgets/confirm/organization_confirm.dart';

class ConfirmScreen extends StatefulWidget {
  ConfirmScreen({Key? key}) : super(key: key);

  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 16.h,
              left: 16.h,
              top: 8.h,
            ),
            child: Text(
              'ADD ORGANIZATION',
              style: TextStyle(
                color: GatewayColors.textDefaultBgLight,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          CardSetup(
            contentCard: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
                  child: TextFormField(
                    style: TextStyle(
                      color: GatewayColors.textDefaultBgLight,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: GatewayColors.textDefaultBgLight,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      suffixIcon: Icon(
                        Icons.filter_center_focus,
                        color: GatewayColors.buttonBgLight,
                        size: 21.h,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GatewayColors.textDefaultBgLight,
                          width: 1.h,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GatewayColors.buttonBgLight,
                          width: 1.h,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      hintText: 'QR Code',
                    ),
                  ),
                ),
                //GuideConfirm(),
                OrganizationConfirm(),
              ],
            ),
          ),
          SizedBox(height: 25.h),
          ButtonCustom(
            bgColor: GatewayColors.buttonBgLight,
            prefixIcon: Icon(
              Icons.confirmation_number_outlined,
              color: Colors.white,
            ),
            title: 'Confirm',
            onFunction: () {},
          ),
        ],
      ),
    );
  }
}
