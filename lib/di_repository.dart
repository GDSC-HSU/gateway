import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gateway/blocs/ble_repository.dart';

class AppRepositoryProvider extends StatelessWidget {
  final FlutterReactiveBle rxBle = FlutterReactiveBle();
  final Widget child;
  AppRepositoryProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [RepositoryProvider(create: (_) => BLERepository(rxBle))],
        child: child);
  }
}
