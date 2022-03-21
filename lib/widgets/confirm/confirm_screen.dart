import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/blocs/cubit/qr_scan_cubit.dart';
import 'package:gateway/config/routes/routing.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/generated/locale_keys.g.dart';
import 'package:gateway/model/device_identity.dart';
import 'package:gateway/model/device_info.dart';
import 'package:gateway/widgets/common/button_custom.dart';
import 'package:gateway/widgets/common/card_setup.dart';
import 'package:gateway/widgets/common/dialog/progress_dialog.dart';
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

  bool confirmOrganization = false;
  late DeviceInfo deviceInfo;
  late QrScanCubit _cubit;
  late String qrConfigCode = '';  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QrScanCubit(),
      child: GestureDetector(
        onTap: () {
          // FocusScopeNode currentFocus = FocusScope.of(context);
          // if (!currentFocus.hasPrimaryFocus) {
          //   currentFocus.unfocus();
          // }
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
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
                  LocaleKeys.add_organization.tr(),
                  style: TextStyle(
                    color: GatewayColors.textDefaultBgLight,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Builder(builder: (context) {
                return CardSetup(
                  contentCard: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.h, vertical: 16.h),
                        child: TextFormField(
                          enableInteractiveSelection: true,
                          //enabled: false,
                          readOnly: true,
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
                            suffixIcon: GestureDetector(
                              onTap: () async {
                                qrConfigCode =
                                    (await Navigator.of(context).push<String>(
                                  MaterialPageRoute<String>(
                                      builder: (BuildContext context) =>
                                          const QRScanDialog()),
                                ))!;
                                if (qrConfigCode != null) {
                                  await BlocProvider.of<QrScanCubit>(context)
                                      .getOrganization(qrConfigCode);
                                  //_handleQRConfig(qrConfigCode);
                                  // setState(() {
                                  //   confirmOrganization = !confirmOrganization;
                                  // });
                                }
                              },
                              child: Icon(
                                Icons.filter_center_focus,
                                color: GatewayColors.buttonBgLight,
                                size: 21.h,
                              ),
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
                            hintText: LocaleKeys.qr_code.tr(),
                          ),
                        ),
                      ),
                      BlocBuilder<QrScanCubit, QrScanState>(
                        builder: (context, state) {
                          if (state is QrScanLoading) {
                            return Padding(
                              padding: EdgeInsets.only(top: 100.h),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: GatewayColors.buttonBgLight,
                                ),
                              ),
                            );
                          }
                          if (state is QrScanSuccess) {
                            return OrganizationConfirm(
                              organizationInfo: state.organizationInfo,
                              callBack: () {
                                setState(() {
                                  confirmOrganization = !confirmOrganization;
                                });
                              },
                            );
                          }
                          if (state is QrScanError) {
                            return Padding(
                              padding: EdgeInsets.only(top: 100.h),
                              child:
                                  Center(child: Text(state.error.toString())),
                            );
                          }
                          return GuideConfirm();
                        },
                      ),
                      // confirmOrganization
                      //     ? OrganizationConfirm()
                      //     : GuideConfirm(),
                    ],
                  ),
                );
              }),
              SizedBox(height: 25.h),
              BlocConsumer<QrScanCubit, QrScanState>(
                listener: _stateListener,
                builder: (context, state) {
                  return BlocBuilder<QrScanCubit, QrScanState>(
                    builder: (context, state) {
                      if (state is QrScanSuccess) {
                        return confirmOrganization
                            ? AppBottomButton(
                                bgColor: GatewayColors.buttonBgLight,
                                leftIconButton: const Icon(
                                  Icons.confirmation_number_outlined,
                                  color: Colors.white,
                                ),
                                title: LocaleKeys.confirm.tr(),
                                onFunction: () async {
                                  BlocProvider.of<QrScanCubit>(context)
                                      .confirmOrganization();
                                },
                              )
                            : AppBottomButton(
                                bgColor: GatewayColors.disableButtonBgLight,
                                leftIconButton: const Icon(
                                  Icons.confirmation_number_outlined,
                                  color: Colors.white,
                                ),
                                title: LocaleKeys.confirm.tr(),
                                onFunction: () async {},
                              );
                      }
                      return Container();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StateHandler on _ConfirmScreenState {
  _stateListener(BuildContext context, QrScanState state) {
    if (state is ConfirmOrganizationWaiting) {
      return GatewayProgressDialog.show(context);
    }
    if (state is ConfirmOrganizationSuccessful) {
      final data = state.deviceInfo;
      Navigator.pushReplacementNamed(context, AppRouting.congratulation,
          arguments: data);
    }
  }
}
