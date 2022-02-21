import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gateway/blocs/ble_device_connection/bloc/ble_device_connection_bloc.dart';
import 'package:gateway/blocs/ble_sensor/ble_sensor.dart';
import 'package:gateway/blocs/ble_sensor/bloc/ble_sensor_bloc.dart';
import 'dart:convert';

class BleSensorGridMonitor extends StatefulWidget {
  const BleSensorGridMonitor({Key? key}) : super(key: key);

  @override
  _BleSensorGridMonitorState createState() => _BleSensorGridMonitorState();
}

class _BleSensorGridMonitorState extends State<BleSensorGridMonitor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          ...SensorType.values.map((e) => BlocProvider(
                create: (context) =>
                    BleSensorBloc(e, context.read<BleDeviceConnectionBloc>()),
                child: BlocBuilder<BleSensorBloc, BleSensorState>(
                    builder: (builder, state) {
                  if (state is BleSensorOnData) {
                    return Column(
                      children: [
                        Text(state.sensorType.toString()),
                        Container(
                          child: Text(
                            String.fromCharCodes(
                              state.data,
                            ),
                            // utf8.decode(state.data, allowMalformed: true),
                            style: TextStyle(color: Colors.red, fontSize: 30),
                          ),
                        ),
                        Container(
                          child: Text(
                            state.data.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ],
                    );
                  }
                  return const Text("SensorData ....");
                }),
              ))
        ],
      ),
    );
  }
}
