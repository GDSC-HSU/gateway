// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class AppConstantsService {
  // static const String ENV = 'development';
  // static const String DEFAULT_ENV = 'development';
  // static const String ENV_CONFIG_PATH = 'assets/config/env/';
  // static const String ENV_CONFIG_TYPE = '.json';
  static const String HTTPS = "https";

  static const String ENDPOINT_VERSION = "/api/v1";

  /// danger change in runtime
  static String API_KEY = '';
  static String HOST_NAME = '';
  static String DEVICE_ACCESS_TOKEN = '';
  static String DEVICE_ID = '';
  static String DEVICE_JWT = '';
  static String ORG_ENDPOINT = '';
  static String MQTT_USERNAME = '';
  static String MQTT_PASSWORD = '';
  static String ORG_ID = '';
  //

  // HTTP
  static const String DATA_PATH = "/data";
  static const String ORG_PATH = "/organization";
  static const String DEVICE_PATH = "/device";
  static const String DEVICE_ID_KEY = 'id';
  static const String DEVICE_HARDWARE_INFO_KEY = 'hardwareInfo';
  //

  // HTTP
  static const String CONTENT_TYPE = "application/json";
  static String DEVICE_ACCESS_TOKEN_HEADER = 'access-key';
  static const String API_KEY_HEADER = 'api-x-key';

  static const String PREFIX_CONTENT_TYPE = "Content-Type";
  //
  // SHARE_PER

}
