import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/widgets/common/info_check_card.dart';

late List<CameraDescription> cameras;

class GatewayCheckScreen extends StatefulWidget {
  GatewayCheckScreen({
    Key? key,
  }) : super(key: key);
  @override
  _GatewayCheckScreenState createState() => _GatewayCheckScreenState();
}

class _GatewayCheckScreenState extends State<GatewayCheckScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = CameraController(cameras.last, ResolutionPreset.medium,
        enableAudio: false);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GatewayColors.scaffoldBgLight,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        elevation: 0.0,
        title: Center(
          child: Text(
            "Gateway Check",
            style: const TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: GatewayColors.scaffoldBgLight,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              FutureBuilder(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.7,
                      decoration: BoxDecoration(
                          color: GatewayColors.bgDark,
                          borderRadius: BorderRadius.circular(20.r)),
                      child: Padding(
                        padding: EdgeInsets.all(0.h),
                        child: CameraPreview(
                          _controller,
                        ),
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
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: GatewayColors.scaffoldBgLight,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                      //bottomRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.h,
                          left: 16.h,
                          top: 16.h,
                        ),
                        child: Text(
                          'CHECK INFORMATION',
                          style: TextStyle(
                            color: GatewayColors.textDefaultBgLight,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const InfoCheckCard(
                        iconStatus: false,
                        imageIcon: 'assets/images/thermometer-gun.png',
                        title: 'RFID Temperature',
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const InfoCheckCard(
                        iconStatus: false,
                        imageIcon: 'assets/images/face-mask.png',
                        title: 'Face Mask',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          const InfoCheckCard(
            iconStatus: false,
            imageIcon: 'assets/images/petition.png',
            title: 'Health Declaration',
          ),
          SizedBox(
            height: 10.h,
          ),
          const InfoCheckCard(
            iconStatus: true,
            imageIcon: 'assets/images/hand-sanitizer.png',
            title: 'Hand Sanitizer',
          ),
        ],
      ),
    );
  }
}
