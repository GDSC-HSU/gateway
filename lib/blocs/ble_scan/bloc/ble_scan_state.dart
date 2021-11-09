// ignore_for_file: prefer_const_constructors_in_immutables

part of 'ble_scan_bloc.dart';

enum ScanSate { founded, notFound, start, init, error }

class BleScanState extends Equatable {
  final ScanSate scanState;
  final DiscoveredDevice? discoverdDevice;
  BleScanState({required this.scanState, this.discoverdDevice});

  factory BleScanState.init() =>
      BleScanState(scanState: ScanSate.init, discoverdDevice: null);

  factory BleScanState.start() =>
      BleScanState(scanState: ScanSate.start, discoverdDevice: null);

  factory BleScanState.notFound() =>
      BleScanState(scanState: ScanSate.notFound, discoverdDevice: null);

  factory BleScanState.founded(DiscoveredDevice device) =>
      BleScanState(scanState: ScanSate.founded, discoverdDevice: device);

  // Haha error
  @override
  List<Object> get props => [scanState, discoverdDevice ?? ""];
}

// class BleScanInitial extends BleScanState {}
