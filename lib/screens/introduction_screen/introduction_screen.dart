import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';

class IntroductionScreen extends StatefulWidget {
  IntroductionScreen({Key? key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  late StreamController<int> _streamController;
  //List<IntroductionItem> _introductionItems = [];
  PageController _pageController = PageController(initialPage: 0);

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
        padding: EdgeInsets.only(bottom: 140.h),
        child: PageView(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index) {
            _curerentPage = index;
            _streamController.sink.add(index);
          },
          children: [
            Container(
              color: GatewayColors.buttonBgLight,
              child: Center(child: Text('hello')),
            ),
            Container(
              color: GatewayColors.buttonBgLight,
              child: Center(child: Text('hellooooooooooooooo')),
            ),
            Container(
              color: GatewayColors.buttonBgLight,
              child: Center(child: Text('hellooooooo')),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 160.h,
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
