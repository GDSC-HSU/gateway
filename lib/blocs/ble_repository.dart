import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:rxdart/subjects.dart';

class BLERepository {
  final FlutterReactiveBle ble;
  get bleStatus => ble.statusStream;

  BehaviorSubject<ConnectionStateUpdate> deviceConnectionStream =
      BehaviorSubject();

  late StreamSubscription<ConnectionStateUpdate> _subscription;

  BLERepository(this.ble);

  bool get isBLEPermissionEnable => this.ble.status == BleStatus.ready;

// TODO BLE STAtUS CHECK SCREEN

  Future<void> connect(String deviceID) async {
    try {
      if (isBLEPermissionEnable) {
        // deviceConnectionStream = BehaviorSubject();
        _subscription = ble.connectToDevice(id: deviceID).listen((event) {
          deviceConnectionStream.add(event);
        });
      }
    } catch (e) {
      // Timeout is notable
    }
    // TODO Hmm not gonna cut it
  }

  Future<void> reConnect(String deviceID) async {
    try {
      if (isBLEPermissionEnable) {
        // deviceConnectionStream = BehaviorSubject();
        _subscription = ble.connectToDevice(id: deviceID).listen((event) {
          deviceConnectionStream.add(event);
        });
      }
    } catch (e) {
      // Timeout is notable
    }
    // TODO Hmm not gonna cut it
  }

  Future<void> disConnect(String deviceID) async {
    if (isBLEPermissionEnable) {
      await _subscription.cancel();
    }
  }
}
