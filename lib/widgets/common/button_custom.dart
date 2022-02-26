import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';

class ButtonCustom extends StatefulWidget {
  ButtonCustom({
    Key? key,
    required this.bgColor,
    required this.title,
    required this.onFunction,
    this.isLoading,
    required this.iconButton,
  }) : super(key: key);
  final Color bgColor;
  final String title;
  final Icon iconButton;
  final Function onFunction;
  final bool? isLoading;
  @override
  _ButtonCustomState createState() => _ButtonCustomState();
}

class _ButtonCustomState extends State<ButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: InkWell(
        onTap: () {
          widget.onFunction();
        },
        child: Container(
          height: 45.sp,
          width: 300.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: widget.bgColor,
          ),
          child: Center(
            child: widget.isLoading == true
                ? CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.title == 'Next'
                          ? Text(
                              widget.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          : widget.iconButton,
                      SizedBox(
                        width: 10.h,
                      ),
                      widget.title == 'Next'
                          ? widget.iconButton
                          : Text(
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
