import 'package:camera/camera.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/generated/locale_keys.g.dart';
import 'package:gateway/model/language.dart';
import 'package:gateway/utils/check_language.dart';
import 'package:gateway/widgets/common/build_appbar.dart';
import 'package:gateway/main.dart';
import 'package:gateway/services/camera_service.dart';
import 'package:gateway/widgets/common/info_check_card.dart';

class GatewayCheckScreen extends StatefulWidget {
  const GatewayCheckScreen({
    Key? key,
  }) : super(key: key);
  @override
  _GatewayCheckScreenState createState() => _GatewayCheckScreenState();
}

class _GatewayCheckScreenState extends State<GatewayCheckScreen> {
  CameraService cameraService = CameraService();
  late Future<void> _initializeControllerFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initializeControllerFuture =
        cameraService.initialize(cameraDescription: cameras.last);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraService.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LanguageModel languageModel =
        CheckLanguage.checkLanguage(context.locale.languageCode);
    return Scaffold(
      bottomSheet: Container(
        width: double.infinity,
        height: 250.h,
        color: GatewayColors.scaffoldBgLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            InfoCheckCard(
              iconStatus: false,
              imageIcon: 'assets/images/thermometer-gun.png',
              title: LocaleKeys.body_temperature.tr(),
            ),
            SizedBox(
              height: 10.h,
            ),
            InfoCheckCard(
              iconStatus: false,
              imageIcon: 'assets/images/face-mask.png',
              title: LocaleKeys.face_mask.tr(),
            ),
            SizedBox(
              height: 10.h,
            ),
            InfoCheckCard(
              iconStatus: false,
              imageIcon: 'assets/images/petition.png',
              title: LocaleKeys.health_declaration.tr(),
            ),
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
        title: '',
        leading: Image.asset('assets/images/logo_gateway.png'),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                      color: GatewayColors.bgDark,
                      borderRadius: BorderRadius.circular(20.r)),
                  child: CameraPreview(
                    cameraService.controller,
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
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
                  Text(
                    '37°C',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  )
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
                      onPressed: () {},
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
  }
}

