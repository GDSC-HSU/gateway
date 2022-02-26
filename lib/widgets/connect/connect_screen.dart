import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/widgets/common/button_custom.dart';
import 'package:gateway/widgets/common/card_setup.dart';

class ConnectScreen extends StatefulWidget {
  ConnectScreen({Key? key}) : super(key: key);

  @override
  _ConnectScreenState createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  late bool connected = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16.h, left: 16.h, top: 8.h),
            child: Text(
              'CONNECT DEVICE',
              style: TextStyle(
                color: GatewayColors.textDefaultBgLight,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          CardSetup(
            contentCard: Column(
              children: [
                Flexible(
                  flex: 4,
                  child: Container(
                    height: 225.h,
                    child: Image.asset('assets/images/device.png'),
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: Container(
                    margin: EdgeInsets.only(left: 6.w, top: 20.h),
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: GatewayColors.dividerColorLight,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: connected
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.h, vertical: 24.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                        color: GatewayColors.textDefaultBgLight,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'Version',
                                      style: TextStyle(
                                        color: GatewayColors.textDefaultBgLight,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'Manufactor',
                                      style: TextStyle(
                                        color: GatewayColors.textDefaultBgLight,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'esp32-gateway',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'v0.1.0',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'GDSC-HSU',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            'We’re found the device in range,\npress connect to begin device pairing',
                            style: TextStyle(
                              color: GatewayColors.textDefaultBgLight,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25.h),
          ButtonCustom(
            bgColor: GatewayColors.buttonBgLight,
            iconButton: connected
                ? Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.compare_arrows,
                    color: Colors.white,
                  ),
            title: connected ? 'Next' : 'Connect',
            onFunction: () {
              setState(() {
                connected = !connected;
              });
            },
          ),
        ],
      ),
    );
  }
}
