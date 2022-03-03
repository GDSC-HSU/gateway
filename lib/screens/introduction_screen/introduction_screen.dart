import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/routes/routing.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/utils/app_permission.dart';
import 'package:gateway/widgets/introduction/introduction_content.dart';

class IntroductionScreen extends StatefulWidget {
  IntroductionScreen({Key? key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  late StreamController<int> _streamController;
  final PageController _pageController = PageController(initialPage: 0);
  bool valuePolicy = false;
  bool valueBle = false;
  bool valueCamera = false;
  //bool valueStroge = false;
  bool isLastPage = false;
  bool check = false;
  @override
  void initState() {
    _streamController = StreamController.broadcast();
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        elevation: 0.0,
        backgroundColor: GatewayColors.scaffoldBgLight,
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 200.h),
        child: PageView(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index) {
            _streamController.sink.add(index);
            setState(() {
              isLastPage = index == 2;
            });
          },
          children: [
            IntroductionCuntent(
              content: Padding(
                padding: EdgeInsets.only(left: 20.h, right: 20.h),
                child: Column(
                  children: [
                    Text(
                      'We’re “google developer student clubs of hoa sen university” \n(gdsc-hsu) which create an solution for the coivd-19 out-break.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: GatewayColors.textDefaultBgLight,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: GatewayColors.outLineCheckBox,
                      ),
                      child: CheckboxListTile(
                        activeColor: GatewayColors.buttonBgLight,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'I agree with gateway ',
                                  style: TextStyle(
                                    color: GatewayColors.textPermissionBgLight,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  '“Term of services”',
                                  style: TextStyle(
                                    color: GatewayColors.buttonBgLight,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  ' and ',
                                  style: TextStyle(
                                    color: GatewayColors.textPermissionBgLight,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  '“Privacy policy”',
                                  style: TextStyle(
                                    color: GatewayColors.buttonBgLight,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        value: valuePolicy,
                        onChanged: (bool? value) {
                          setState(() {
                            valuePolicy = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              image: 'assets/images/logo_gateway.png',
              title: 'Welcome To Gateway',
            ),
            IntroductionCuntent(
              content: Container(
                width: 298.w,
                height: 164.h,
                child: Image.asset(
                  'assets/images/hoasen.png',
                  fit: BoxFit.cover,
                ),
              ),
              image: 'assets/images/logo_gateway.png',
              title: 'What Is Gateway',
            ),
            IntroductionCuntent(
              content: Padding(
                padding: EdgeInsets.only(left: 30.h, right: 30.h),
                child: Column(
                  children: [
                    Text(
                      'In order to gateway fully run, yours device has to agree some of our permission.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: GatewayColors.textDefaultBgLight,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: GatewayColors.outLineCheckBox,
                      ),
                      child: Column(
                        children: [
                          FutureBuilder<bool>(
                              future: PermissionUtils.checkIsGranted(
                                  PermissionType.bluetooth),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  valueBle = snapshot.data!;
                                }
                                return CheckboxListTile(
                                  activeColor: GatewayColors.buttonBgLight,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Text(
                                    'I agree with bluetooth permission',
                                    style: TextStyle(
                                      color:
                                          GatewayColors.textPermissionBgLight,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  value: valueBle,
                                  onChanged: (bool? value) async {
                                    bool valueChooseImage =
                                        await PermissionUtils.chooseSourceImage(
                                            context, PermissionType.bluetooth);
                                    setState(() {
                                      valueBle = valueChooseImage;
                                    });
                                  },
                                );
                              }),
                          FutureBuilder<bool>(
                              future: PermissionUtils.checkIsGranted(
                                  PermissionType.camera),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  valueCamera = snapshot.data!;
                                }
                                return CheckboxListTile(
                                  activeColor: GatewayColors.buttonBgLight,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Text(
                                    'I agree with camera permission',
                                    style: TextStyle(
                                      color:
                                          GatewayColors.textPermissionBgLight,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  value: valueCamera,
                                  onChanged: (bool? newValueCamera) async {
                                    print(valueCamera);
                                    bool valueChooseImage =
                                        await PermissionUtils.chooseSourceImage(
                                            context, PermissionType.camera);
                                    setState(() {
                                      valueCamera = valueChooseImage;
                                    });
                                  },
                                );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              image: 'assets/images/key_permission.png',
              title: 'App Permission',
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 200.h,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<int>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  return _buildIndicator(snapshot.data ?? 0);
                }),
            InkWell(
              onTap: () {
                if (isLastPage) {
                  if (valueBle == true && valueCamera == true) {
                    Navigator.pushReplacementNamed(context, AppRouting.setup);
                  }
                }
                _pageController.nextPage(
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    curve: Curves.easeInOut);
              },
              child: Container(
                width: 47.h,
                height: 47.h,
                decoration: isLastPage
                    ? BoxDecoration(
                        color: valueBle == true && valueCamera == true
                            ? GatewayColors.buttonBgLight
                            : GatewayColors.disablebuttonBgLight,
                        shape: BoxShape.circle,
                      )
                    : BoxDecoration(
                        color: GatewayColors.buttonBgLight,
                        shape: BoxShape.circle,
                      ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < 3; i++)
          Row(
            children: [
              SizedBox(width: 5.h),
              Icon(
                Icons.circle,
                color: currentIndex == i
                    ? GatewayColors.buttonBgLight
                    : GatewayColors.textDefaultBgLight,
                size: 16.r,
              ),
              SizedBox(width: 5.h),
            ],
          )
      ],
    );
  }
}
