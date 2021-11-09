import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:rxdart/subjects.dart';

class BLERepository {
  final FlutterReactiveBle ble;
  get bleStatus => ble.statusStream;

  BehaviorSubject<ConnectionStateUpdate> deviceConnectionStream =
      BehaviorSubject();

  BLERepository(this.ble);
// TODO BLE STAtUS CHECK SCREEN
  connect(String deviceID) {
    try {
      ble.connectToDevice(id: deviceID).pipe(deviceConnectionStream);
    } catch (e) {
      // Timeout is notable
    }
    // TODO Hmm not gonna cut it
  }
}
