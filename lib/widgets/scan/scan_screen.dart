import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/blocs/ble_scan/bloc/ble_scan_bloc.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/generated/locale_keys.g.dart';
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
    final bloc = BlocProvider.of<BleScanBloc>(context);
    return SingleChildScrollView(
      child: BlocBuilder<BleScanBloc, BleScanState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16.h, left: 16.h, top: 8.h),
                child: Text(
                  LocaleKeys.scanning.tr(),
                  //'SCANNING',
                  style: TextStyle(
                    color: GatewayColors.textDefaultBgLight,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              CardSetup(
                contentCard: Center(child: _buildCenterState(state)),
              ),
              SizedBox(height: 25.h),
              AppBottomButton(
                bgColor: GatewayColors.buttonBgLight,
                leftIconButton: const Icon(
                  Icons.flip,
                  color: Colors.white,
                ),
                title: LocaleKeys.scan.tr(),
                onFunction: () {
                  bloc.add(BLEScanRequestEvent());
                },
              ),
            ],
          );
        },
      ),
    );
  }

  _buildCenterState(BleScanState state) {
    switch (state.scanState) {
      case ScanSate.init:
        return Text(
          LocaleKeys.scan_begin_text.tr(),
          style: TextStyle(
            color: GatewayColors.textDefaultBgLight,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        );
      default:
        return Padding(
          padding: EdgeInsets.all(10.w),
          child: Image.asset("assets/gif/scanning.gif"),
        );
    }
  }
}
