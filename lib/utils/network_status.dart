import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';

class NetworkStatus extends StatefulWidget {
  final Widget child;

  const NetworkStatus({Key? key, required this.child}) : super(key: key);

  @override
  _NetworkStatusState createState() => _NetworkStatusState();
}

class _NetworkStatusState extends State<NetworkStatus> {
  bool isOnline = true;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        setState(() {
          isOnline = true;
        });
        break;
      case ConnectivityResult.none:
        setState(() {
          isOnline = false;
        });
        break;
      default:
      // do nothing here
    }
  }

  Widget renderNetworkStatus(double bottomPadding) {
    if (isOnline) return Container();

    return Container(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: GatewayColors.blur_background.withOpacity(0.8),
          boxShadow: [
            BoxShadow(
              color: GatewayColors.inactive_white.withOpacity(0.8),
              blurRadius: 4.0,
              spreadRadius: 15.0,
              offset: Offset(
                15.0,
                15.0,
              ),
            ),
          ],
        ),
        child: Padding(
          padding:
              EdgeInsets.only(top: 4, bottom: bottomPadding, left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                'No connection internet',
                style: TextStyle(
                    fontSize: 15,
                    color: GatewayColors.inactive_white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                width: 8,
                height: 1,
              ),
              SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      GatewayColors.inactive_white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final bool isIphoneX = Device.screenHeight >= 812.0;
    final double bottomPadding = 10.h;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: <Widget>[widget.child, renderNetworkStatus(bottomPadding)],
      ),
    );
  }
}
