import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gateway/business_logic/ble/ble_connector/bloc/ble_connector_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  group("BLE TEST", () {
    final FlutterReactiveBle _ble = FlutterReactiveBle();
    blocTest<BleConnectorBloc, BleConnectorState>("BLE Scaning",
        setUp: () async {
          var status = await _ble.statusStream
              .firstWhere((element) => element == BleStatus.ready);
          print(status);
        },
        build: () => BleConnectorBloc(_ble),
        act: (bloc) => bloc.add(StartScanningEvent()),
        expect: () => <BleConnectorState>[ScanningState()]);
  });
}
