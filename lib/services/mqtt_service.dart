import 'package:gateway/config/constants/service_constants.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

enum MQTTConnectionStatus { connected, disconnected, reconnecting }

// - [ ] TODO JWT for IOT Core
class MQTTService {
  late MqttServerClient _client;

  // most case you wont need it
  MqttServerClient get mqttClient => _client;

  _initMQTTConfig() {
    /// setup mqtt client
    _client.setProtocolV311();
    _client.logging(on: false);
    _client.autoReconnect = true;
    _client.resubscribeOnAutoReconnect = true;
    // configuration will be configured in boot up
    final connectionMess = MqttConnectMessage()
        .withClientIdentifier(AppConstantsService.DEVICE_ID)
        .authenticateAs(AppConstantsService.MQTT_USERNAME,
            AppConstantsService.MQTT_PASSWORD)
        .startClean();
    _client.connectionMessage = connectionMess;

    ///
  }

  init(Function(MQTTConnectionStatus) connectionUpdate) async {
    try {
      // configuration will be configured in boot up
      _client = MqttServerClient(AppConstantsService.ORG_ENDPOINT, '');
      _initMQTTConfig();
      await _client.connect();
      _listenMQTTStatus(connectionUpdate);
    } catch (e) {
      rethrow;
    }
  }

  _listenMQTTStatus(Function(MQTTConnectionStatus) connectionUpdate) {
    _client.onConnected =
        () => connectionUpdate(MQTTConnectionStatus.connected);
    _client.onDisconnected =
        () => connectionUpdate(MQTTConnectionStatus.disconnected);
    _client.onAutoReconnect =
        () => connectionUpdate(MQTTConnectionStatus.reconnecting);
  }

  void dispose() {
    _client.disconnect();
  }
}
