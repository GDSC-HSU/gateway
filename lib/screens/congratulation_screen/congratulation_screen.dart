import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/blocs/mqtt_connection/mqtt_connection_cubit.dart';
import 'package:gateway/config/routes/routing.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/generated/locale_keys.g.dart';
import 'package:gateway/model/device_info.dart';
import 'package:gateway/model/language.dart';
import 'package:gateway/services/device_config_service.dart';
import 'package:gateway/services/mqtt_service.dart';
import 'package:gateway/utils/check_language.dart';
import 'package:gateway/widgets/common/build_appbar.dart';
import 'package:gateway/widgets/common/button_custom.dart';

class CongratulationScreen extends StatelessWidget {
  final DeviceInfo deviceInfo;
  const CongratulationScreen({Key? key, required this.deviceInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<MQTTConnectionCubit>().connectToMQTTBroker();
    LanguageModel languageModel =
        CheckLanguage.checkLanguage(context.locale.languageCode);
    return Scaffold(
      appBar: BuildAppBar(
        languageModel: languageModel,
        title: '',
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 26.h),
              child: Text(
                LocaleKeys.congratulation.tr(),
                style: TextStyle(
                  color: GatewayColors.buttonBgLight,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 26.h),
              child: SizedBox(
                height: 20.h,
                child: Divider(
                  color: GatewayColors.borderCheck,
                  thickness: 4.h,
                ),
              ),
            ),
            Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/device.png',
                    fit: BoxFit.cover,
                    width: 210.h,
                    height: 210.h,
                    //scale: 0.5,
                  ),
                ),
                BlocBuilder<MQTTConnectionCubit, MQTTConnectionState>(
                  builder: (context, state) {
                    // TODO add shimmer effect for [MQTTConnectionStatus.connecting]
                    final isConnected =
                        state.status == MQTTConnectionStatus.connected;
                    return Positioned(
                      bottom: 20.h,
                      right: 35.h,
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: isConnected
                                ? GatewayColors.onlineColor
                                : GatewayColors.disableButtonBgLight,
                            size: 20.sp,
                          ),
                          SizedBox(width: 10.h),
                          Text(
                            isConnected
                                ? LocaleKeys.online.tr()
                                : LocaleKeys.offline.tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15.sp,
                                color: GatewayColors.textDefaultBgLight),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.only(left: 26.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.device_name.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: GatewayColors.textDefaultBgLight,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        LocaleKeys.device_id.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: GatewayColors.textDefaultBgLight,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 30.h),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          deviceInfo.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          deviceInfo.location,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 20.h),
              child: Text(
                LocaleKeys.content_congratulation.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: GatewayColors.textDefaultBgLight),
              ),
            ),
            Center(
              child: Icon(
                Icons.check_circle,
                color: Colors.greenAccent[700],
                size: 70.sp,
              ),
            ),
            SizedBox(height: 30.h),
            FutureBuilder<bool>(
                initialData: false,
                future:
                    Future.value(DeviceIdentityService.isDeviceBeenConfigured),
                builder: (context, snap) {
                  return AppBottomButton(
                    bgColor: GatewayColors.buttonBgLight,
                    rightIconButton: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    title: LocaleKeys.next.tr(),
                    onFunction: () {
                      Navigator.pushReplacementNamed(
                        context,
                        //AppRouting.congratulation,
                        AppRouting.gatewayCheck,
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
