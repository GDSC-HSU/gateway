import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gateway/blocs/ble_repository.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

part 'ble_device_connection_event.dart';
part 'ble_device_connection_state.dart';

class BleDeviceConnectionBloc
    extends Bloc<BleDeviceConnectionEvent, BleDeviceConnectionState> {
  final BLERepository repository;
  late StreamSubscription connectionStateSub;
  late DiscoveredDevice connectedDeviceInfo;

  BleDeviceConnectionBloc({required this.repository})
      : super(BleDeviceConnectionState.init()) {
    // Sub
    // map event to State

    // scanBloc.stream
    //     .firstWhere((scanState) => scanState.state == ScanSate.founded)
    //     .then((scanData) => {connectedDeviceInfo = scanData.discoverdDevice!});

    on<BLEDeviceConnectionUpdateEvent>(_handleBLEDeviceConnectionEventUpdate);
    on<BLEDeviceConnectionRequestEvent>(_handleBLEDeviceConnectionRequest);

    listenBLEDeviceConnectionEvent();
  }

  _handleBLEDeviceConnectionRequest(BLEDeviceConnectionRequestEvent event,
      Emitter<BleDeviceConnectionState> emit) {
    repository.connect(event.scannedDeviceId);
  }

  _handleBLEDeviceConnectionEventUpdate(BLEDeviceConnectionUpdateEvent event,
      Emitter<BleDeviceConnectionState> emit) {
    emit(BleDeviceConnectionState(event.stateUpdate));
  }

  /// Status update for a BLE device.
  /// precondition is [BLEDeviceConnectionRequestEvent]
  void listenBLEDeviceConnectionEvent() {
    // hidden notifier
    connectionStateSub = repository.deviceConnectionStream.listen((value) {
      add(BLEDeviceConnectionUpdateEvent(value));
    });
  }

  @override
  Future<void> close() async {
    await connectionStateSub.cancel();
    return super.close();
  }
}
