import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/generated/locale_keys.g.dart';

class GuideConfirm extends StatefulWidget {
  const GuideConfirm({Key? key}) : super(key: key);

  @override
  State<GuideConfirm> createState() => _GuideConfirmState();
}

class _GuideConfirmState extends State<GuideConfirm> {
  // Map<Widget, String> values = {
  //   Icon(Icons.radio_button_checked, color: GatewayColors.buttonBgLight) : LocaleKeys.first_thing_note_confirm.tr(),
  //   Icon(Icons.radio_button_checked, color: GatewayColors.buttonBgLight) : LocaleKeys.second_thing_note_confirm.tr(),
  //   Icon(Icons.radio_button_checked, color: GatewayColors.buttonBgLight) : LocaleKeys.third_thing_note_confirm.tr(),
  // };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
          child: Text(
            LocaleKeys.title_note_confirm.tr(),
            style: TextStyle(
              color: GatewayColors.textDefaultBgLight,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
          child: Row(
            children: [
              Icon(
                Icons.radio_button_checked,
                color: GatewayColors.buttonBgLight,
                size: 18.sp,
              ),
              Container(
                width: 250.w,
                margin: EdgeInsets.only(left: 8.h),
                child: Text(
                  LocaleKeys.first_thing_note_confirm.tr(),
                  style: TextStyle(
                    color: GatewayColors.textDefaultBgLight,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
          child: Row(
            children: [
              Icon(
                Icons.radio_button_checked,
                color: GatewayColors.buttonBgLight,
                size: 18.sp,
              ),
              Container(
                width: 250.w,
                margin: EdgeInsets.only(left: 8.h),
                child: Text(
                  LocaleKeys.second_thing_note_confirm.tr(),
                  style: TextStyle(
                    color: GatewayColors.textDefaultBgLight,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
          child: Row(
            children: [
              Icon(
                Icons.radio_button_checked,
                color: GatewayColors.buttonBgLight,
                size: 18.sp,
              ),
              Container(
                width: 250.w,
                margin: EdgeInsets.only(left: 8.h),
                child: Text(
                  LocaleKeys.third_thing_note_confirm.tr(),
                  style: TextStyle(
                    color: GatewayColors.textDefaultBgLight,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
