import 'package:gateway/config/constants/service_constants.dart';
import 'package:gateway/services/device_config_service.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

enum MQTTConnectionStatus {
  init,
  connected,
  connecting,
  disconnected,
  reconnecting,
  error
}

// - [ ] TODO JWT for IOT Core
class MQTTService {
  MqttServerClient? _client;

  // most case you wont need it
  MqttServerClient get mqttClient => _client!;

  _initMQTTConfig() {
    /// setup mqtt client
    _client!.setProtocolV311();
    _client!.logging(on: true);
    _client!.autoReconnect = true;
    _client!.resubscribeOnAutoReconnect = true;
    // configuration will be configured in boot up
    final connectionMess = MqttConnectMessage()
        .withClientIdentifier(AppConstantsService.DEVICE_ID)
        .authenticateAs(AppConstantsService.MQTT_USERNAME,
            AppConstantsService.MQTT_PASSWORD)
        .startClean();
    _client!.connectionMessage = connectionMess;

    ///
  }

  bool isMQTTConnected() {
    if (_client != null) {
      bool isConnected =
          _client!.connectionStatus?.state == MqttConnectionState.connected;
      return isConnected;
    }
    return false;
  }

  init(Function(MQTTConnectionStatus) connectionUpdate) async {
    final isConfigured = DeviceIdentityService.isDeviceBeenConfigured;
    if (!isConfigured) throw "[DEV] error device no been configured";
    try {
      // configuration will be configured in boot up
      final serverAddress = Uri.parse(AppConstantsService.ORG_ENDPOINT);
      _client = MqttServerClient(serverAddress.authority, '');
      _initMQTTConfig();
      _listenMQTTStatus(connectionUpdate);
      connectionUpdate(MQTTConnectionStatus.connecting);
      await _client!.connect();
    } catch (e) {
      connectionUpdate(MQTTConnectionStatus.error);
      rethrow;
    }
  }

  _listenMQTTStatus(Function(MQTTConnectionStatus) connectionUpdate) {
    _client!.onConnected =
        () => connectionUpdate(MQTTConnectionStatus.connected);
    _client!.onDisconnected =
        () => connectionUpdate(MQTTConnectionStatus.disconnected);
    _client!.onAutoReconnect =
        () => connectionUpdate(MQTTConnectionStatus.reconnecting);
  }

  void dispose() {
    _client!.disconnect();
  }
}
