import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gateway/blocs/mqtt_connection/mqtt_connection_cubit.dart';
import 'package:gateway/blocs/mqtt_connection/mqtt_connection_cubit.dart';

class MQTTConnectionScreen extends StatefulWidget {
  const MQTTConnectionScreen({Key? key}) : super(key: key);

  @override
  State<MQTTConnectionScreen> createState() => _MQTTConnectionScreenState();
}

class _MQTTConnectionScreenState extends State<MQTTConnectionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MQTTConnectionCubit>().connectToMQTTBroker();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      width: 200,
      height: 300,
      child: Center(
        child: BlocConsumer<MQTTConnectionCubit, MQTTConnectionState>(
          listener: (context, state) {
            print(state);
          },
          builder: (context, state) {
            if (state == const MQTTConnectionState.connecting()) {
              return Container(
                  width: 200, height: 200, child: CircularProgressIndicator());
            }
            return Text(
              state.status.name,
              style: TextStyle(color: Colors.red),
            );
          },
        ),
      ),
    );
  }
}
