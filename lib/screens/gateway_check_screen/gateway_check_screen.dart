import 'dart:async';

import 'package:camera/camera.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/blocs/ble_sensor_controller/bloc/gateway_controller_bloc.dart';
import 'package:gateway/blocs/ble_sensor_controller/controller_state_from.dart';
import 'package:gateway/config/routes/routing.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/di/di_ble_sensor.dart';
import 'package:gateway/generated/locale_keys.g.dart';
import 'package:gateway/model/language.dart';
import 'package:gateway/services/tensorflow_service/extension.dart';
import 'package:gateway/services/tensorflow_service/face_mask_detector_service.dart';
import 'package:gateway/services/tensorflow_service/qr_code_service.dart';
import 'package:gateway/utils/check_language.dart';
import 'package:gateway/widgets/common/build_appbar.dart';
import 'package:gateway/main.dart';
import 'package:gateway/services/camera_service.dart';
import 'package:gateway/widgets/common/dialog/loading_dialog.dart';
import 'package:gateway/widgets/common/dialog/progress_dialog.dart';
import 'package:gateway/widgets/common/info_check_card.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rxdart/transformers.dart';

class GatewayCheckScreen extends StatefulWidget {
  const GatewayCheckScreen({
    Key? key,
  }) : super(key: key);
  @override
  _GatewayCheckScreenState createState() => _GatewayCheckScreenState();
}

class _GatewayCheckScreenState extends State<GatewayCheckScreen> {
  //
  CameraService cameraService = CameraService();
  GoogleMLKitQRService googleMLKitQRService = GoogleMLKitQRService();
  FaceMaskDetectorService faceMaskDetectorService = FaceMaskDetectorService();
  //
  //
  late Future<void> _initializeControllerFuture;
  late StreamSubscription googleMLKitQRServiceSub;
  late StreamSubscription faceMaskDetectorServiceSub;
  late GatewayControllerBloc bloc;
  late HexoStateForm hexoState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      bloc = context.read<GatewayControllerBloc>();
      hexoState = bloc.hexoState;

      ///
      ///
    });
    _initializeControllerFuture = Future.wait([
      googleMLKitQRService.initModel(),
      faceMaskDetectorService.initModel(),
      cameraService.initialize(
        cameraResolution: ResolutionPreset.low,
        cameraDescription: cameras.last,
      )
    ]).then((value) => {
          _mlServiceListener(),
          //TODO auto re-start
          cameraService.controller.startImageStream((image) => {
                googleMLKitQRService.inference(image.toInputImage()),
                faceMaskDetectorService.inference(image)
              })
        });
  }

  void _mlServiceListener() {
    googleMLKitQRServiceSub = googleMLKitQRService.stream.listen((event) {
      hexoState.addHardWareSensorToForm(event, FromType.qrCamera);
    });
    faceMaskDetectorServiceSub = faceMaskDetectorService.stream
        .where((isWearMask) => isWearMask)
        .throttleTime(const Duration(seconds: 1))
        .listen((event) {
      hexoState.addHardWareSensorToForm(event, FromType.maskCamera);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    googleMLKitQRService.dispose();
    faceMaskDetectorService.dispose();
    faceMaskDetectorServiceSub.cancel();
    googleMLKitQRServiceSub.cancel();
    cameraService.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LanguageModel languageModel =
        CheckLanguage.checkLanguage(context.locale.languageCode);
    return Container(
      color: Colors.white,
      child: FutureBuilder(
          future: _initializeControllerFuture,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return BlocListener<GatewayControllerBloc, GatewayControllerState>(
              listener: (context, state) async {
                if (state is GatewayMotionDetected) {
                  // if (state.isMotionAppear) {
                  //   Navigator.of(context)
                  //       .popUntil(ModalRoute.withName(AppRouting.gatewayCheck));
                  // } else {
                  //   await Navigator.of(context)
                  //       .pushNamed(AppRouting.introduction);
                  // }
                }
                if (state is GatewayCheckUploading) {
                  await GatewayProgressDialog.show(context);
                }
                if (state is GatewayCheckUploadedSuccessful ||
                    state is GatewayCheckUploadError) {
                  await GatewayProgressDialog.hide(context);
                }
              },
              child: ReactiveFormBuilder(
                form: () => hexoState.form,
                builder: (context, from, child) {
                  return Scaffold(
                    bottomSheet: Container(
                      width: double.infinity,
                      height: 250.h,
                      color: GatewayColors.scaffoldBgLight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ReactiveFormConsumer(builder: (context, from, child) {
                            final valid =
                                from.controls[FromType.temperature.name]?.valid;
                            return InfoCheckCard(
                              iconStatus: valid ?? false,
                              imageIcon: 'assets/images/thermometer-gun.png',
                              title: LocaleKeys.body_temperature.tr(),
                            );
                          }),
                          SizedBox(
                            height: 10.h,
                          ),
                          ReactiveValueListenableBuilder(
                              formControlName: FromType.maskCamera.name,
                              builder: (context, from, child) {
                                return InfoCheckCard(
                                  iconStatus: from.valid,
                                  imageIcon: 'assets/images/face-mask.png',
                                  title: LocaleKeys.face_mask.tr(),
                                );
                              }),
                          SizedBox(
                            height: 10.h,
                          ),
                          ReactiveFormConsumer(builder: (context, from, child) {
                            final isDone =
                                hexoState.isProvideCovidIdentificationMethod();
                            return InfoCheckCard(
                              iconStatus: isDone,
                              imageIcon: 'assets/images/petition.png',
                              title: LocaleKeys.health_declaration.tr(),
                            );
                          }),
                          SizedBox(
                            height: 10.h,
                          ),
                          InfoCheckCard(
                            iconStatus: true,
                            imageIcon: 'assets/images/hand-sanitizer.png',
                            title: LocaleKeys.hand_sanitizer.tr(),
                          ),
                        ],
                      ),
                    ),
                    backgroundColor: GatewayColors.scaffoldBgLight,
                    appBar: BuildAppBar(
                      languageModel: languageModel,
                      title: LocaleKeys.gateway_home.tr(),
                      leading: Image.asset('assets/images/gateway_logo.png'),
                    ),
                    body: Stack(
                      children: [
                        FutureBuilder(
                          future: _initializeControllerFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                decoration: BoxDecoration(
                                    color: GatewayColors.bgDark,
                                    borderRadius: BorderRadius.circular(20.r)),
                                child: CameraPreview(
                                  cameraService.controller,
                                ),
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                        Container(
                          width: 90.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: GatewayColors.bgDark,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.r),
                              //topLeft: Radius.circular(20.r),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/images/celsius.png',
                                  scale: 15.h,
                                ),
                                ReactiveValueListenableBuilder(
                                    formControlName: FromType.temperature.name,
                                    builder: (context, from, child) {
                                      const degreeText = "°C";
                                      return Text(
                                        from.valid
                                            ? from.value.toString()
                                            : "" + degreeText,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    })
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 40.h,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: GatewayColors.bgDark,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.r),
                              ),
                            ),
                            child: Center(
                                child: IconButton(
                                    onPressed: () {
                                      hexoState.resetFrom();
                                    },
                                    icon: Icon(
                                      Icons.refresh,
                                      color: Colors.white,
                                      size: 25.sp,
                                    ))),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
