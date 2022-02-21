import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gateway/blocs/ble_repository.dart';
import 'package:gateway/config/constants/ble_desgin_constants.g.dart'
    as ble_constants;
part 'ble_scan_event.dart';
part 'ble_scan_state.dart';

class BleScanBloc extends Bloc<BleScanEvent, BleScanState> {
  var isScanning = false;
  final BLERepository repository;
  late DiscoveredDevice device;

  BleScanBloc({required this.repository}) : super(BleScanState.init()) {
    on<BLEScanRequestEvent>(onScanning);
  }
  Future<void> onScanning(
      BLEScanRequestEvent event, Emitter<BleScanState> emitter) async {
    try {
      emitter(BleScanState.start());
      // NOTE handle devices withServices[]
      device = await repository.ble
          .scanForDevices(withServices: ble_constants.deviceServices)
          .firstWhere((element) {
        return element.name == ble_constants.DEVICE_NAME;
      });
      //TODO Impl RSSI range
      emitter(BleScanState.founded(device));
    } catch (e) {
      print(e);
      emitter(BleScanState.notFound());
    }
  }
}
