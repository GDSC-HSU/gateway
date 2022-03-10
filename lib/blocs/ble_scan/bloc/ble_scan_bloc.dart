import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gateway/blocs/ble_repository.dart';
import 'package:gateway/config/constants/ble_desgin_constants.g.dart'
    as ble_constants;
import 'package:gateway/config/constants/ble_timmer.dart';
import 'package:gateway/generated/locale_keys.g.dart';
part 'ble_scan_event.dart';
part 'ble_scan_state.dart';

class BleScanBloc extends Bloc<BleScanEvent, BleScanState> {
  static int scanDelay = 5;
  final BLERepository repository;
  DiscoveredDevice? device;

  late StreamSubscription<DiscoveredDevice> scanSubscription;

  BleScanBloc({required this.repository}) : super(BleScanState.init()) {
    on<BLEScanRequestEvent>(onScanning);
  }
  Future<void> onScanning(
      BLEScanRequestEvent event, Emitter<BleScanState> emitter) async {
    try {
      emitter(BleScanState.load());
      scanSubscription = repository.ble
          .scanForDevices(withServices: ble_constants.deviceServices)
          .listen((data) {
        if (data.name == ble_constants.DEVICE_NAME) {
          device = data;
        }
      });
      await Future.delayed(BLETimer.scanDelay);
      scanSubscription.cancel();
      if (device == null) {
        emitter(BleScanState.notFound());
        return;
      } else {
        emitter(BleScanState.founded(device!));
      }
    } catch (e) {
      emitter(BleScanState.error());
    }
  }
}
