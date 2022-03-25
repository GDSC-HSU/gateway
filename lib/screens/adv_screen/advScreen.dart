import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/widgets/adv/carousel_with_dot.dart';

class AdvScreen extends StatelessWidget {
  const AdvScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     int _current = 0;
    final List<String> imgList = [
      'assets/images/INFO.png',
      'assets/images/FIND_A_FAC.png',
      'assets/images/TALK.png',
      'assets/images/Core_team.png',
    ];
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/Logo_Google-DSC-Lockup-Centered.png'),
          SizedBox(height: 30.h),
          CarouselWithDotsPage(imgList: imgList),
        ],
      ),
    );
  }
}
