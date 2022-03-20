import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:equatable/equatable.dart';
import 'package:gateway/generated/locale_keys.g.dart';
import 'package:gateway/model/device_identity.dart';
import 'package:gateway/model/device_info.dart';
import 'package:gateway/model/organization_info.dart';
import 'package:gateway/services/device_config_service.dart';
import 'package:gateway/services/device_service.dart';
import 'package:gateway/services/organization_service.dart';
import 'package:gateway/widgets/connect/device_info.dart';

part 'qr_scan_state.dart';

class QrScanCubit extends Cubit<QrScanState> {
  QrScanCubit() : super(QrScanInitial());
  _handleQRConfig(String qrAsString) async {
    try {
      final json = jsonDecode(qrAsString);
      final deviceIdentity = DeviceIdentity.fromJson(json);
      await DeviceIdentityService.saveDeviceIdentityConfig(deviceIdentity);
    } catch (e) {
      throw "[DEV] error JSON Decode";
    }
  }

  Future<OrganizationInfo> _getOrg() async {
    final orgInfo = await OrganizationService().getOrgPreview();
    print(orgInfo);
    return orgInfo;
  }

  _deviceClaim() async {
    final deviceInfo = await DeviceService.getDeviceInfo();
    return await DeviceService().postDeviceDetail(deviceInfo);
  }

  Future<void> getOrganization(String qrAString) async {
    try {
      emit(QrScanLoading());
      await _handleQRConfig(qrAString);
      OrganizationInfo organizationInfo = await _getOrg();
      emit(QrScanSuccess(organizationInfo: organizationInfo));
    } catch (e) {
      print(e);
      emit(QrScanError(error: LocaleKeys.please_rescan.tr()));
    }
  }

  Future<void> confirmOrganization() async {
    emit(ConfirmOrganizationWaiting());
    DeviceInfo deviceInfo = await _deviceClaim();
    emit(ConfirmOrganizationSuccessful(deviceInfo: deviceInfo));
  }

  Future<void> getDeviceInfo() async {
    DeviceInfo deviceInfo = await _deviceClaim();
    emit(InfoDeviceSuccess(deviceInfo: deviceInfo));
  }
}
