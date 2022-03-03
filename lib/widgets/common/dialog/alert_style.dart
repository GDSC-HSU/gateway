import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';

/// Alert types
enum AlertType { error, success, info, warning, none, update }

/// Alert animation types
enum AnimationType { fromRight, fromLeft, fromTop, fromBottom, grow, shrink }

/// Buttons container
enum ButtonsDirection { row, column }

const EdgeInsets defaultAlertPadding =
    EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0);

/// Library images path
const String kImagePath = "assets/images";

typedef AlertAnimation = Widget Function(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
);

class AlertStyle {
  final AnimationType animationType;
  final Duration animationDuration;
  final ShapeBorder? alertBorder;
  final bool isButtonVisible;
  final bool isCloseButton;
  final bool isOverlayTapDismiss;
  final Color? backgroundColor;
  final Color overlayColor;
  final TextStyle titleStyle;
  final TextStyle descStyle;
  final TextAlign titleTextAlign;
  final TextAlign descTextAlign;
  final EdgeInsets buttonAreaPadding;
  final BoxConstraints? constraints;
  final ButtonsDirection buttonsDirection;
  final double? alertElevation;
  final EdgeInsets alertPadding;
  final AlignmentGeometry alertAlignment;

  /// Alert style constructor function
  /// The [animationType] parameter is used for transitions. Default: "fromBottom"
  /// The [animationDuration] parameter is used to set the animation transition time. Default: "200 ms"
  /// The [alertBorder] parameter sets border.
  /// The [isButtonVisible] paramater is used to decide hide or display buttons
  /// The [isCloseButton] parameter sets visibility of the close button. Default: "true"
  /// The [isOverlayTapDismiss] parameter sets closing the alert by clicking outside. Default: "true"
  /// The [backgroundColor] parameter sets the background color.
  /// The [overlayColor] parameter sets the background color of the outside. Default: "Color(0xDD000000)"
  /// The [titleStyle] parameter sets alert title text style.
  /// The [titleTextAlign] parameter sets alignment of the title.
  /// The [descStyle] parameter sets alert desc text style.
  /// The [descTextAlign] parameter sets alignment of the desc.
  /// The [buttonAreaPadding] parameter sets button area padding.
  /// The [constraints] parameter sets Alert size.
  /// The [buttonsDirection] parameter sets button container as Row or Col.
  /// The [alertElevation] parameter sets elevation of alert dialog container.
  /// The [alertPadding] parameter sets alert area padding.
  const AlertStyle({
    this.animationType = AnimationType.fromBottom,
    this.animationDuration = const Duration(milliseconds: 200),
    this.alertBorder,
    this.isButtonVisible = true,
    this.isCloseButton = true,
    this.isOverlayTapDismiss = true,
    this.backgroundColor = GatewayColors.scaffoldBgLight,
    this.overlayColor = Colors.black87,
    this.titleStyle = const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 18,
        fontStyle: FontStyle.normal),
    this.titleTextAlign = TextAlign.center,
    this.descStyle = const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal),
    this.descTextAlign = TextAlign.center,
    this.buttonAreaPadding = const EdgeInsets.only(bottom: 24.0),
    this.constraints,
    this.buttonsDirection = ButtonsDirection.row,
    this.alertElevation,
    this.alertPadding = defaultAlertPadding,
    this.alertAlignment = Alignment.center,
  });
}
