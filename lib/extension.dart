// ignore_for_file: camel_case_extensions

extension BLE_DATA_AS_STRING on List<int> {
  // [51 49] => String 31
  String get asBLEData => String.fromCharCodes(this);
}
