import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gateway/blocs/ble_device_connection/bloc/ble_device_connection_bloc.dart';
import 'package:gateway/blocs/ble_repository.dart';
import 'package:gateway/blocs/ble_scan/bloc/ble_scan_bloc.dart';
import 'package:gateway/blocs/mqtt_connection/mqtt_connection_cubit.dart';
import 'package:gateway/services/mqtt_service.dart';

class AppDependencyProvider extends StatelessWidget {
  final Widget child;
  final FlutterReactiveBle rxBle = FlutterReactiveBle();

  AppDependencyProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) =>
              BleScanBloc(repository: context.read<BLERepository>()),
        ),
        BlocProvider(
          create: (context) => BleDeviceConnectionBloc(
              repository: context.read<BLERepository>()),
        ),
        BlocProvider(
            create: (context) =>
                MQTTConnectionCubit(mqttService: context.read<MQTTService>()))
      ],
      child: child,
    );
  }
}
