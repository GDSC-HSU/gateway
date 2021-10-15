part of 'ble_connector_bloc.dart';

abstract class BleConnectorState extends Equatable {}

class BleConnectorInitial extends BleConnectorState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ScanningDone extends BleConnectorState {
  final DiscoveredDevice device;

  ScanningDone(this.device);

  @override
  // TODO: implement props
  List<Object?> get props => [device];
}

class ScanningState extends BleConnectorState {
  @override
  // TODO: implement props
  List<Object?> get props => ["scanning"];
}

class ScanningErrorState extends BleConnectorState {
  final String errorMess;
  ScanningErrorState(this.errorMess);

  @override
  // TODO: implement props
  List<Object?> get props => [errorMess];
}
