import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/widgets/introduction/introduction_content.dart';

class IntroductionScreen extends StatefulWidget {
  IntroductionScreen({Key? key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  late StreamController<int> _streamController;
  //List<IntroductionItem> _introductionItems = [];
  PageController _pageController = PageController(initialPage: 0);
  bool valuePolicy = false;
  bool valueBle = false;
  bool valueNetwork = false;
  bool valueStroge = false;
  int _initialIndex = 0;

  int _curerentPage = 0;
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
            _curerentPage = index;
            _streamController.sink.add(index);
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
                                    fontSize: 13.sp,
                                  ),
                                ),
                                Text(
                                  '“Term of services”',
                                  style: TextStyle(
                                    color: GatewayColors.buttonBgLight,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.sp,
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
                                    fontSize: 13.sp,
                                  ),
                                ),
                                Text(
                                  '“Privacy policy”',
                                  style: TextStyle(
                                    color: GatewayColors.buttonBgLight,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.sp,
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
                          CheckboxListTile(
                            activeColor: GatewayColors.buttonBgLight,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              'I agree with BLE permission',
                              style: TextStyle(
                                color: GatewayColors.textPermissionBgLight,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                              ),
                            ),
                            value: valueBle,
                            onChanged: (bool? value) {
                              setState(() {
                                valueBle = value!;
                              });
                            },
                          ),
                          CheckboxListTile(
                            activeColor: GatewayColors.buttonBgLight,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              'I agree with network permission',
                              style: TextStyle(
                                color: GatewayColors.textPermissionBgLight,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                              ),
                            ),
                            value: valueNetwork,
                            onChanged: (bool? value) {
                              setState(() {
                                valueNetwork = value!;
                              });
                            },
                          ),
                          CheckboxListTile(
                            activeColor: GatewayColors.buttonBgLight,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              'I agree with create stroge',
                              style: TextStyle(
                                color: GatewayColors.textPermissionBgLight,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                              ),
                            ),
                            value: valueStroge,
                            onChanged: (bool? value) {
                              setState(() {
                                valueStroge = value!;
                              });
                            },
                          ),
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
                _pageController.nextPage(
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    curve: Curves.easeInOut);
              },
              child: Container(
                width: 47.h,
                height: 47.h,
                decoration: BoxDecoration(
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
