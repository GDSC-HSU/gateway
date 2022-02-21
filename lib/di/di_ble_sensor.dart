// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/ble_device_connection/bloc/ble_device_connection_bloc.dart';
import '../blocs/ble_sensor/ble_sensor.dart';
import '../blocs/ble_sensor/bloc/ble_sensor_bloc.dart';
import '../blocs/ble_sensor_controller/bloc/ble_sensor_controller_bloc.dart';

class AppBLESensorDependencyProvider extends StatelessWidget {
  final Widget child;
  const AppBLESensorDependencyProvider({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) {
            final ble_connection_bloc = context.read<BleDeviceConnectionBloc>();
            return BleSensorControllerBloc([
              ...SensorType.values
                  .map((e) => BleSensorBloc(e, ble_connection_bloc))
            ]);
          },
        ),
      ],
      child: child,
    );
  }
}
