import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gateway/blocs/ble_repository.dart';

class DependencyProvider extends StatelessWidget {
  final Widget child;
  final FlutterReactiveBle rxBle = FlutterReactiveBle();

  DependencyProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<BLERepository>(
      create: (_) => BLERepository(rxBle),
      child: child,
    );
  }
}
