import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';

class AppBottomButton extends StatefulWidget {
  AppBottomButton({
    Key? key,
    required this.bgColor,
    required this.title,
    required this.onFunction,
    this.isLoading,
    this.rightIconButton,
    this.leftIconButton,
  }) : super(key: key);
  final Color bgColor;
  final String title;
  // only one icon per side
  final Widget? leftIconButton;
  final Widget? rightIconButton;
  final Function onFunction;
  // showing loadding mode
  final bool? isLoading;
  @override
  _AppBottomButtonState createState() => _AppBottomButtonState();
}

class _AppBottomButtonState extends State<AppBottomButton> {
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
            child: widget.isLoading != null && widget.isLoading == true
                ? SizedBox(
                    width: 25.w,
                    height: 25.w,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.0,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [...buildTextWithIcon()],
                  ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildTextWithIcon() {
    if (widget.rightIconButton == null && widget.leftIconButton != null) {
      return [
        widget.leftIconButton!,
        SizedBox(
          width: 10.h,
        ),
        Text(widget.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ))
      ];
    }
    if (widget.leftIconButton == null && widget.rightIconButton != null) {
      return [
        Text(widget.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            )),
        SizedBox(
          width: 10.h,
        ),
        widget.rightIconButton!,
      ];
    }
    return [
      Text(widget.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ))
    ];
  }
}
