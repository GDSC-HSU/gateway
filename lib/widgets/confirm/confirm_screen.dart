import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/routes/routing.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/model/device_identity.dart';
import 'package:gateway/services/device_config_service.dart';
import 'package:gateway/widgets/common/button_custom.dart';
import 'package:gateway/widgets/common/card_setup.dart';
import 'package:gateway/widgets/confirm/guide_confirm.dart';
import 'package:gateway/widgets/confirm/organization_confirm.dart';
import 'package:gateway/widgets/confirm/qr_scan_dialog.dart';

class ConfirmScreen extends StatefulWidget {
  ConfirmScreen({Key? key}) : super(key: key);

  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late DeviceIdentity deviceIdentity;

  @override
  void initState() {
    super.initState();
  }

  late bool confirmOrganization = false;
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
                GestureDetector(
                  onTap: () async {
                    final String? qrConfigCode =
                        await Navigator.of(context).push<String>(
                      MaterialPageRoute<String>(
                          builder: (BuildContext context) =>
                              const QRScanDialog()),
                    );
                    if (qrConfigCode != null) {
                      await _handleQRConfig(qrConfigCode);
                      setState(() {
                        confirmOrganization = true;
                      });
                    }
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
                    child: TextFormField(
                      enabled: false,
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
                ),
                confirmOrganization
                    ? const OrganizationConfirm()
                    : const GuideConfirm(),
              ],
            ),
          ),
          SizedBox(height: 25.h),
          FutureBuilder<bool>(
              initialData: false,
              future:
                  Future.value(DeviceIdentityService.isDeviceBeenConfigured),
              builder: (context, snap) {
                return AppBottomButton(
                  bgColor: GatewayColors.buttonBgLight,
                  leftIconButton: const Icon(
                    Icons.confirmation_number_outlined,
                    color: Colors.white,
                  ),
                  title: 'Confirm',
                  onFunction: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRouting.gatewayCheck,
                    );
                  },
                );
              }),
        ],
      ),
    );
  }

  _handleQRConfig(String qrAsString) async {
    try {
      final json = jsonDecode(qrAsString);
      print(json);
      final deviceIdentity = DeviceIdentity.fromJson(json);
      await DeviceIdentityService.saveDeviceIdentityConfig(deviceIdentity);
    } catch (e) {
      print(e);
    }
  }
}
