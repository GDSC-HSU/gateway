import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gateway/blocs/ble_repository.dart';
import 'package:gateway/mock/mock_ble.dart';
import 'package:gateway/services/device_config_service.dart';
import 'package:gateway/services/mqtt_service.dart';

class AppRepositoryProvider extends StatelessWidget {
  final FlutterReactiveBle rxBle = FlutterReactiveBle();
  final Widget child;
  AppRepositoryProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider(create: (_) => BLERepository(rxBle)),
      RepositoryProvider(create: (_) => DeviceIdentityService()),
      RepositoryProvider(
        create: (_) => MQTTService(),
      )
    ], child: child);
  }
}
