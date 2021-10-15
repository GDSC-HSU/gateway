import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gateway/config/constants/ble_desgin_constants.g.dart'
    as ble_constants;

import 'package:meta/meta.dart';

part 'ble_connector_event.dart';
part 'ble_connector_state.dart';

// TODO BleConnectorBloc
// [ ] Devices BLE _ble.statusStream [READY,OFFLINE,....]
// [x] MockConnect by using BLE DEVICE NAME

/**
 * [BleConnectorBloc] sanning & connect to device
 */
class BleConnectorBloc extends Bloc<BleConnectorEvent, BleConnectorState> {
  var isScanning = false;
  final FlutterReactiveBle _ble;
  late DiscoveredDevice device;

  BleConnectorBloc(this._ble) : super(BleConnectorInitial()) {
    on<StartScanningEvent>(onScaning);
  }
  Future<void> onScaning(
      StartScanningEvent event, Emitter<BleConnectorState> emitter) async {
    try {
      emitter(ScanningState());
      // NOTE handle devices withServices[]
      device =
          await _ble.scanForDevices(withServices: []).firstWhere((element) {
        return element.name == ble_constants.DEVICE_NAME;
      });
      emitter(ScanningDone(device));
    } catch (e) {
      emitter(ScanningErrorState(e.toString()));
    }
  }
}

// TODO connection bloc state
