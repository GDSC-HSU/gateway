import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroductionCuntent extends StatelessWidget {
  const IntroductionCuntent(
      {Key? key,
      required this.title,
      required this.image,
      required this.content})
      : super(key: key);
  final String title, image;
  final Widget content;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 115.h,
          height: 115.h,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        Expanded(child: content),
      ],
    );
  }
}
