import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gateway/blocs/ble_device_connection/bloc/ble_device_connection_bloc.dart';
import 'package:gateway/blocs/ble_scan/bloc/ble_scan_bloc.dart';
import 'package:gateway/blocs/mqtt_connection/mqtt_connection_cubit.dart';
import 'package:gateway/widgets/common/dialog/progress_dialog.dart';

class BLEReconnect extends StatefulWidget {
  final Widget child;
  const BLEReconnect({Key? key, required this.child}) : super(key: key);

  @override
  State<BLEReconnect> createState() => _BLEReconnectState();
}

class _BLEReconnectState extends State<BLEReconnect> {
  late BleScanBloc scanBloc;
  late MQTTConnectionCubit mqttBloc;
  late BleDeviceConnectionBloc bleConnectionBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scanBloc = context.read<BleScanBloc>();
    mqttBloc = context.read<MQTTConnectionCubit>();
    bleConnectionBloc = context.read<BleDeviceConnectionBloc>();

    mqttBloc.connectToMQTTBroker();
    scanBloc.add(BLEScanRequestEvent());
  }

  @override
  Widget build(BuildContext context) {
    // TODO Add scan not found
    // TODO dialog combie MQTT and BLE SCANN + Connect
    return MultiBlocListener(listeners: [
      BlocListener<BleScanBloc, BleScanState>(
        listener: (context, state) {
          if (state.scanState == ScanSate.init) {
            scanBloc.add(BLEScanRequestEvent());
          }
          if (state.scanState == ScanSate.loading) {
            GatewayProgressDialog.show(context);
          }
          if (state.scanState == ScanSate.founded) {
            bleConnectionBloc.add(BLEDeviceConnectionRequestEvent(
                state.discoverdDevice!.id,
                isDelay: false));
            GatewayProgressDialog.hide(context);
          }
        },
      ),
    ], child: widget.child);
  }
}
