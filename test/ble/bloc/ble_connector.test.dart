// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:gateway/business_logic/ble/ble_connector/bloc/ble_connector_bloc.dart';
// import 'package:mockito/annotations.dart';
// import 'ble_connector.test.mocks.dart';

// @GenerateMocks([DiscoveredDevice])
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final FlutterReactiveBle _ble = FlutterReactiveBle();
//   // _ble.cur
//   _whenBLEReady() async {
//     var status = await _ble.statusStream
//         .firstWhere((element) => element == BleStatus.ready);
//     print(status);
//   }

//   DiscoveredDevice mock_device = MockDiscoveredDevice();

//   // DiscoveredDevice(
//   //     id: '',
//   //     name: "",
//   //     serviceData: Map(),
//   //     manufacturerData: Uint8List.fromList([]),
//   //     serviceUuids: [],
//   //     rssi: 10);

//   group("BLE TEST", () {
//     blocTest<BleConnectorBloc, BleConnectorState>("BLE Scaning",
//         setUp: () async => await _whenBLEReady(),
//         build: () => BleConnectorBloc(_ble),
//         act: (bloc) => bloc.add(StartScanningEvent()),
//         expect: () => <BleConnectorState>[ScanningState()]);

//     blocTest<BleConnectorBloc, BleConnectorState>("BLE Scaning + found device",
//         setUp: () async => await _whenBLEReady(),
//         build: () => BleConnectorBloc(_ble),
//         act: (bloc) => bloc.add(StartScanningEvent()),
//         expect: () =>
//             <BleConnectorState>[ScanningState(), ScanningDone(mock_device)]);
//   });
// }
