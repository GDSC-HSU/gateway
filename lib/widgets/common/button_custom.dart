import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';

class ButtonCustom extends StatefulWidget {
  ButtonCustom({
    Key? key,
    required this.bgColor,
    required this.title,
    this.suffixIcon,
    required this.prefixIcon,
    required this.onFunction,
  }) : super(key: key);
  final Color bgColor;
  final String title;
  final Icon? suffixIcon;
  final Icon prefixIcon;
  final Function onFunction;
  @override
  _ButtonCustomState createState() => _ButtonCustomState();
}

class _ButtonCustomState extends State<ButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: InkWell(
        onTap: () {
          widget.onFunction;
        },
        child: Container(
          height: 45.sp,
          width: 300.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: widget.bgColor,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.prefixIcon,
                // Icon(
                //   Icons.flip,
                //   color: Colors.white,
                // ),
                SizedBox(
                  width: 10.h,
                ),

                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
