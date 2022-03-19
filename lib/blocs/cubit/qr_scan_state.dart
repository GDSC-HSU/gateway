part of 'qr_scan_cubit.dart';

abstract class QrScanState extends Equatable {
  const QrScanState();

  @override
  List<Object> get props => [];
}

class QrScanInitial extends QrScanState {}

class QrScanLoading extends QrScanState {}

class QrScanSuccess extends QrScanState {
  final OrganizationInfo organizationInfo;
  QrScanSuccess({
    required this.organizationInfo,
  });
  @override
  List<Object> get props => [organizationInfo];
}

class QrScanError extends QrScanState {
  final String error;

  QrScanError({this.error = ''});
  @override
  List<Object> get props => [error];
}

class ConfirmOrganizationWaiting extends QrScanState {}

class ConfirmOrganizationSuccessful extends QrScanState {
  final DeviceInfo deviceInfo;
  const ConfirmOrganizationSuccessful({
    required this.deviceInfo,
  });
  @override
  List<Object> get props => [deviceInfo];
}

class InfoDeviceSuccess extends QrScanState {
  final DeviceInfo deviceInfo;
  InfoDeviceSuccess({
    required this.deviceInfo,
  });
  @override
  List<Object> get props => [deviceInfo];
}
