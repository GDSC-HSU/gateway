import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/blocs/ble_device_connection/bloc/ble_device_connection_bloc.dart';
import 'package:gateway/blocs/ble_scan/bloc/ble_scan_bloc.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/widgets/common/button_custom.dart';
import 'package:gateway/widgets/common/card_setup.dart';
import 'package:gateway/widgets/connect/device_info.dart';

class ConnectScreen extends StatefulWidget {
  ConnectScreen({Key? key}) : super(key: key);

  @override
  _ConnectScreenState createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  late bool connected;
  late bool isWantToConnect = true;
  late bool isBeenConnect;
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BleDeviceConnectionBloc>(context);
    final bleScanBloc = BlocProvider.of<BleScanBloc>(context);
    connected = bleScanBloc.state.scanState == ScanSate.founded ? true : false;
    return SingleChildScrollView(
      child: BlocBuilder<BleDeviceConnectionBloc, BleDeviceConnectionState>(
        builder: (context, state) {
          isBeenConnect = state.connectionSate != null ? true : false;
          final isConnectingToDevice = isDisableState(state);
          // isWantToConnect = isConnectingToDevice;
          return Column(
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
                        child: Image.asset(
                          'assets/images/device.png',
                          scale: 0.1,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 0,
                      child: Container(
                        margin: EdgeInsets.only(left: 6.w, top: 20.h),
                        height: 1.h,
                        decoration: const BoxDecoration(
                          color: GatewayColors.dividerColorLight,
                        ),
                      ),
                    ),
                    Flexible(
                        flex: 2,
                        child: isDeviceConnected(state)
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30.h, vertical: 24.h),
                                  child: const DeviceInfo(),
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
                              )),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              isConnectingToDevice
                  ? loading(
                      bgColor: GatewayColors.disablebuttonBgLight,
                      title: "",
                      isLoading: true,
                      onFunction: () => {})
                  : loading(
                      bgColor: GatewayColors.buttonBgLight,
                      title: isWantToConnect ? "Connect" : "Next",
                      leftIconButton: isWantToConnect
                          ? const Icon(
                              Icons.compare_arrows,
                              color: Colors.white,
                            )
                          : null,
                      rightIconButton: isWantToConnect
                          ? null
                          : const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                      onFunction: () => {
                            if (!isDeviceConnected(state))
                              {
                                isWantToConnect = false,
                                bloc.add(BLEDeviceConnectionRequestEvent(
                                    bleScanBloc.device!.id))
                                // }
                              }
                          })
            ],
          );
        },
      ),
    );
  }

  bool isDisableState(BleDeviceConnectionState state) {
    return isBeenConnect &&
        state.connectionSate == DeviceConnectionState.connecting;
  }

  bool isDeviceConnected(BleDeviceConnectionState state) {
    return !isWantToConnect &&
        state.connectionSate == DeviceConnectionState.connected;
  }

  //   setState(() {
  //   isWantToConnect = true;
  //   if (connected && isWantToConnect && !isBeenConnect) {
  //     bloc.add(BLEDeviceConnectionRequestEvent(
  //         bleScanBloc.device!.id));
  //   }
  // });
}
