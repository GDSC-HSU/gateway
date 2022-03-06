import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';

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

    _controller = CameraController(cameras.last, ResolutionPreset.high);
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              FutureBuilder(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        width: double.infinity,
                        height: 300.h,
                        decoration: BoxDecoration(
                            color: GatewayColors.bgDark,
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Padding(
                          padding: EdgeInsets.all(5.h),
                          child: CameraPreview(
                            _controller,
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
              Container(
                width: 90.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: GatewayColors.bgDark,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.r),
                    topLeft: Radius.circular(20.r),
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
                right: 0,
                top: 0,
                child: Container(
                  width: 20.h,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: GatewayColors.bgDark,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: 20.h,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: GatewayColors.bgDark,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 40.h,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: GatewayColors.bgDark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 25.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 45.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: GatewayColors.borderCheck,
                        ),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/thermometer-gun.png',
                          scale: 13,
                        ),
                        title: Text(
                          'RFID Temperature',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.sp),
                        ),
                        trailing: Icon(
                          Icons.check_circle_outline,
                          color: GatewayColors.successColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: double.infinity,
                      height: 45.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: GatewayColors.borderCheck,
                        ),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/face-mask.png',
                          scale: 13,
                        ),
                        title: Text(
                          'Face Mask',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.sp),
                        ),
                        trailing: Icon(
                          Icons.cancel_outlined,
                          color: GatewayColors.failColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: double.infinity,
                      height: 45.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: GatewayColors.borderCheck,
                        ),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/petition.png',
                          scale: 13,
                        ),
                        title: Text(
                          'Health Declaration',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.sp),
                        ),
                        trailing: Icon(
                          Icons.check_circle_outline,
                          color: GatewayColors.successColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: double.infinity,
                      height: 45.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: GatewayColors.borderCheck,
                        ),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/hand-sanitizer.png',
                          scale: 13,
                        ),
                        title: Text(
                          'Hand Sanitizer',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.sp),
                        ),
                        trailing: Icon(
                          Icons.check_circle_outline,
                          color: GatewayColors.successColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
