import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/generated/locale_keys.g.dart';
import 'package:overlay_dialog/overlay_dialog.dart';

class WalletProgressDialog {
  static DialogWidget? _dialog;

  static _initIfNeeded() {
    if (_dialog == null) {
      _dialog = DialogWidget.custom(child: CustomerProgressDialog());
    }
  }

  static show(BuildContext context) {
    _initIfNeeded();
    if (_dialog != null) {
      DialogHelper().show(context, _dialog!);
    }
  }

  static hide(BuildContext context) {
    DialogHelper().hide(context);
  }

  static Future<void> hideIfNeeded(BuildContext context) async {
    DialogHelper().hide(context);
    return Future.value();
  }
}

class CustomerProgressDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AbsorbPointer(
        absorbing: true,
        child: Stack(
          children: [
            Container(
              color: Color(0xFF0A0A0B).withOpacity(0.5),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                child: Container(
                  color: Color(0x01000000),
                  child: FractionallySizedBox(
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.all(20.h),
                        decoration: BoxDecoration(
                            color: GatewayColors.scaffoldBgLight,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r),),),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircularProgressIndicator(
                              color: GatewayColors.buttonBgLight,
                              strokeWidth: 2,
                            ),
                            SizedBox(height: 10.h),
                            Text(LocaleKeys.please_wait.tr(),
                                style: TextStyle(
                                    color: Colors.black87),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
