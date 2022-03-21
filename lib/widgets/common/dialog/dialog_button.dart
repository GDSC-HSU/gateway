import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';

class DialogButton extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double height;
  final Color? color;
  final Color? highlightColor;
  final Color? splashColor;
  final Gradient? gradient;
  final BorderRadius radius;
  final VoidCallback? onPressed;
  final BoxBorder border;
  final EdgeInsets padding;
  final EdgeInsets margin;

  /// DialogButton constructor
  DialogButton({
    Key? key,
    required this.child,
    this.width,
    this.height = 50.0,
    this.color,
    this.highlightColor,
    this.splashColor,
    this.gradient,
    this.radius = const BorderRadius.all(Radius.circular(0)),
    this.border = const Border.fromBorderSide(
      BorderSide(
        color: const Color(0x00000000),
        width: 0,
        style: BorderStyle.solid,
      ),
    ),
    this.padding = const EdgeInsets.only(left: 6, right: 6),
    this.margin = const EdgeInsets.all(0),
    required this.onPressed,
  }) : super(key: key);

  /// Creates alert buttons based on constructor params
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.h, right: 12.h),
      child: Container(
        //padding: padding,
       //margin: EdgeInsets.only(left: 6.h, right: 6.h, top: 0.h),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? GatewayColors.buttonBgLight,
          gradient: gradient,
          borderRadius: radius,
          border: border,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: highlightColor ?? Theme.of(context).highlightColor,
            splashColor: splashColor ?? Theme.of(context).splashColor,
            onTap: onPressed,
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
