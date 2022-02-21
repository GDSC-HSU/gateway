import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gateway/blocs/ble_sensor_controller/bloc/ble_sensor_controller_bloc.dart';
import 'package:gateway/di/di_ble_sensor.dart';

class HexoStateTest extends StatefulWidget {
  const HexoStateTest({Key? key}) : super(key: key);

  @override
  _HexoStateTestState createState() => _HexoStateTestState();
}

class _HexoStateTestState extends State<HexoStateTest> {
  @override
  Widget build(BuildContext context) {
    return AppBLESensorDependencyProvider(
      child: Container(
        child: Column(
          children: [
            Builder(builder: (context) {
              return FloatingActionButton(
                  onPressed: () => {
                        context
                            .read<BleSensorControllerBloc>()
                            .hexoStateProcessing
                            .processState()
                      });
            }),
            Builder(builder: (context) {
              return BlocBuilder<BleSensorControllerBloc,
                  BleSensorControllerState>(builder: (builder, state) {
                if (state is BleSensorControllerValidState) {
                  print(state.hexoState.listOfSensorState
                      .map((e) => e.sensor.data.toString()));
                }
                return Container();
              });
            })
          ],
        ),
      ),
    );
  }
}
