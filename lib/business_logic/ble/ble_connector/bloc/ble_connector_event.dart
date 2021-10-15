part of 'ble_connector_bloc.dart';

@immutable
abstract class BleConnectorEvent extends Equatable {}

class StartScanningEvent extends BleConnectorEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ConnectingEvent extends BleConnectorEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//TODO setup Paring
