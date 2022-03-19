import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gateway/config/constants/app_delay_timmer_constants.dart';
import 'package:gateway/services/mqtt_service.dart';

part 'mqtt_connection_state.dart';

class MQTTConnectionCubit extends Cubit<MQTTConnectionState> {
  final MQTTService mqttService;
  MQTTConnectionCubit({required this.mqttService})
      : super(const MQTTConnectionState.init()) {}

  // TODO add check when device is configured by singleton injection
  connectToMQTTBroker() {
    if (!mqttService.isMQTTConnected()) {
      mqttService.init((connectionUpdate) async {
        if (connectionUpdate == MQTTConnectionStatus.connected) {
          Future.delayed(MQTTtimer.mqttConnectedDelay,
              () => emit(MQTTConnectionState(connectionUpdate)));
        } else {
          emit(MQTTConnectionState(connectionUpdate));
        }
      });
    }
  }

  dispose() {
    mqttService.dispose();
  }
}
