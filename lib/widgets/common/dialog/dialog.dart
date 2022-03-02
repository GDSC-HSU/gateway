import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:async';
import 'alert_style.dart';
import 'animation_transition.dart';
import 'dialog_button.dart';

class DialogUtils {
  static Future showDialogAndNavigation(
      BuildContext context, String content, String appRoute) {
    return showDialog(
        context: context,
        useRootNavigator: false,
        builder: (_) {
          return Center(
            child: AlertDialog(
              backgroundColor: Theme.of(context).dialogBackgroundColor,
              insetPadding: EdgeInsets.symmetric(horizontal: 16.h),
              titlePadding: EdgeInsets.symmetric(vertical: 24.h),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.h))),
              title: Text('hello', textAlign: TextAlign.center),
              content: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        content,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 23),
                    DialogButton(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                      onPressed: () async {
                        Navigator.of(_)
                          ..pop()
                          ..pop()
                          ..pushNamed(appRoute,
                              arguments: {'requestKYCFromOtherScreen': true});
                      },
                      child: Text(
                        'ok',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static void showDialogError(BuildContext context,
      {required String content,
      String? title,
      Function()? onPressed,
      bool canDismissible = false}) {
    Alert(
        context: context,
        barrierDismissible: canDismissible,
        type: AlertType.error,
        showImageInDialog: true,
        style: AlertStyle(
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            titleStyle: Theme.of(context).textTheme.headline4!,
            overlayColor: Colors.black38),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //const SizedBox(height: 8),
            Center(
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
        buttons: [
          DialogButton(
            margin: const EdgeInsets.only(left: 16, right: 16),
            padding: const EdgeInsets.all(0.0),
            color: Theme.of(context).primaryColor,
            radius: BorderRadius.circular(10.0),
            onPressed: onPressed ??
                () {
                  Navigator.of(context).pop();
                },
            child: Text(
              'ok',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ]).show();
  }

  static void showInformationDialog(
    BuildContext context, {
    required String content,
    String? image,
    String? title,
    Function()? onPressed,
    bool barrierDismissible = false,
    bool showCancelButton = false,
    Function()? onCancelPressed,
    AlertType? type,
  }) {
    Alert(
        style: AlertStyle(
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            titleStyle: Theme.of(context).textTheme.headline4!,
            overlayColor: Colors.black38),
        context: context,
        barrierDismissible: barrierDismissible,
        showImageInDialog: true,
        title: title ?? 'hello',
        type: type,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Center(
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
        buttons: [
          if (showCancelButton)
            DialogButton(
              child: Text(
                'cancal',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              color: Colors.redAccent,
              onPressed: onCancelPressed ?? () => Navigator.pop(context),
            ),
          DialogButton(
            radius: BorderRadius.circular(16.0),
            margin: EdgeInsets.only(left: 16, right: 16),
            onPressed: onPressed ?? () => Navigator.pop(context),
            child: Text(
              'ok',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ]).show();
  }
}

class Alert {
  final String? id;
  final BuildContext context;
  final AlertType? type;
  final AlertStyle style;
  final Widget? image;
  final bool showImageInDialog;
  final String? title;
  final String? desc;
  final Widget content;
  final List<DialogButton>? buttons;
  final Function? closeFunction;
  final Widget? closeIcon;
  final bool onWillPopActive;
  final bool useRootNavigator;
  final AlertAnimation? alertAnimation;
  final bool barrierDismissible;

  /// Alert constructor
  ///
  /// [context], [title] are required.
  Alert({
    required this.context,
    this.title,
    this.id,
    this.type,
    this.barrierDismissible = true,
    this.style = const AlertStyle(),
    this.image,
    this.desc,
    this.content = const SizedBox(),
    this.buttons,
    this.closeFunction,
    this.closeIcon,
    this.onWillPopActive = false,
    this.alertAnimation,
    this.useRootNavigator = false,
    this.showImageInDialog = false,
  });

  /// Displays defined alert window
  Future<bool?> show() async {
    return await showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return _buildDialog();
        },
        barrierDismissible: barrierDismissible,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: style.overlayColor,
        useRootNavigator: useRootNavigator,
        transitionDuration: style.animationDuration,
        transitionBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) =>
            alertAnimation == null
                ? _showAnimation(animation, secondaryAnimation, child)
                : alertAnimation!(
                    context, animation, secondaryAnimation, child));
  }

  /// Dismisses the alert dialog.
  Future<void> dismiss() async {
    Navigator.of(context, rootNavigator: useRootNavigator).pop();
  }

  /// Alert dialog content widget
  Widget _buildDialog() {
    var width = MediaQuery.of(context).size.width;
    final Widget _child = ConstrainedBox(
      constraints: style.constraints ??
          BoxConstraints.expand(
              width: double.infinity, height: double.infinity),
      child: Align(
        alignment: style.alertAlignment,
        child: SingleChildScrollView(
          child: AlertDialog(
              key: id == null ? null : Key(id!),
              backgroundColor: style.backgroundColor,
              shape: style.alertBorder ?? _defaultShape(),
              insetPadding: style.alertPadding,
              elevation: style.alertElevation,
              titlePadding: const EdgeInsets.all(0.0),
              title: Container(
                width: width - 16 * 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Image.asset(
                      //   'assets/images/banner-dialog-update.png',
                      //   fit: BoxFit.fitWidth,
                      // ),
                      if (showImageInDialog && type == AlertType.update)
                        _getImage(),
                      _getCloseButton(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            20, (style.isCloseButton ? 0 : 10), 20, 0),
                        child: Column(
                          children: <Widget>[
                            if (showImageInDialog && type != AlertType.update)
                              _getImage(),
                            SizedBox(
                              height: 16,
                            ),
                            if (title != null)
                              Text(
                                title ?? '',
                                style: style.titleStyle,
                                textAlign: style.titleTextAlign,
                              ),
                            if (title != null)
                              SizedBox(
                                height: desc == null ? 5 : 10,
                              ),
                            desc == null
                                ? const SizedBox()
                                : Text(
                                    desc!,
                                    style: style.descStyle,
                                    textAlign: style.descTextAlign,
                                  ),
                            content,
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              contentPadding: style.buttonAreaPadding,
              content: style.buttonsDirection == ButtonsDirection.row
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _getButtons(),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _getButtons(),
                    )),
        ),
      ),
    );
    return onWillPopActive
        ? WillPopScope(onWillPop: () async => false, child: _child)
        : _child;
  }

  /// Returns the close button on the top right
  Widget _getCloseButton() {
    return style.isCloseButton
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
            child: GestureDetector(
              onTap: () {
                if (closeFunction == null) {
                  Navigator.of(context, rootNavigator: useRootNavigator).pop();
                } else {
                  closeFunction!();
                }
              },
              child: Container(
                alignment: FractionalOffset.topRight,
                child: this.closeIcon != null
                    ? Container(child: this.closeIcon)
                    : SizedBox(),
              ),
            ),
          )
        : Container();
  }

  /// Returns defined buttons. Default: Cancel Button
  List<Widget> _getButtons() {
    List<Widget> expandedButtons = [];
    if (style.isButtonVisible) {
      if (buttons != null) {
        buttons!.forEach(
          (button) {
            var buttonWidget = Padding(
              padding: const EdgeInsets.only(left: 2, right: 2),
              child: button,
            );
            if ((button.width != null && buttons!.length == 1) ||
                style.buttonsDirection == ButtonsDirection.column) {
              expandedButtons.add(buttonWidget);
            } else {
              expandedButtons.add(Expanded(
                child: buttonWidget,
              ));
            }
          },
        );
      } else {
        Widget cancelButton = DialogButton(
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
        );
        if (style.buttonsDirection == ButtonsDirection.row) {
          cancelButton = Expanded(
            child: cancelButton,
          );
        }
        expandedButtons.add(cancelButton);
      }
    }
    return expandedButtons;
  }

  /// Returns alert default border style
  ShapeBorder _defaultShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
      side: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  /// Returns alert image for icon
  Widget _getImage() {
    Widget response = image ?? Container();
    switch (type) {
      case AlertType.success:
        response = Icon(Icons.done);
        break;
      case AlertType.error:
        response = Icon(Icons.priority_high);
        break;
      case AlertType.info:
        response = Icon(Icons.info);
        break;
      case AlertType.warning:
        response = Icon(Icons.warning);
        break;
      case AlertType.update:
        response = Icon(Icons.update);
        break;
      case AlertType.none:
      default:
        response = Container();
        break;
    }
    return response;
  }

  /// Shows alert with selected animation
  _showAnimation(animation, secondaryAnimation, child) {
    switch (style.animationType) {
      case AnimationType.fromRight:
        return AnimationTransition.fromRight(
            animation, secondaryAnimation, child);
      case AnimationType.fromLeft:
        return AnimationTransition.fromLeft(
            animation, secondaryAnimation, child);
      case AnimationType.fromBottom:
        return AnimationTransition.fromBottom(
            animation, secondaryAnimation, child);
      case AnimationType.grow:
        return AnimationTransition.grow(animation, secondaryAnimation, child);
      case AnimationType.shrink:
        return AnimationTransition.shrink(animation, secondaryAnimation, child);
      case AnimationType.fromTop:
        return AnimationTransition.fromTop(
            animation, secondaryAnimation, child);
    }
  }
}
