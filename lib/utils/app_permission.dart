import 'package:flutter/cupertino.dart';
import 'package:gateway/widgets/common/dialog/dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

enum PermissionType { camera, bluetooth }

class PermissionUtils {
  static Future<bool> checkIsGranted(PermissionType permissionType) async {
    bool isGranted = false;

    switch (permissionType) {
      case PermissionType.camera:
        isGranted = await Permission.camera.isGranted;
        break;
      case PermissionType.bluetooth:
        isGranted = await Permission.bluetooth.isGranted;
        if (Platform.isAndroid) {
          isGranted = await Permission.bluetoothScan.isGranted;
          isGranted = await Permission.bluetoothConnect.isGranted;
        }
        break;
      default:
    }
    return isGranted;
  }

  static Future<bool> chooseSourceImage(
      BuildContext context, PermissionType permissionType) async {
    bool isGranted = false;

    late PermissionStatus statusPermission;
    switch (permissionType) {
      case PermissionType.camera:
        statusPermission = await Permission.camera.request();
        break;
      case PermissionType.bluetooth:
        statusPermission = await Permission.bluetooth.request();
        if (Platform.isAndroid) {
          statusPermission = await Permission.bluetoothScan.request();
          statusPermission = await Permission.bluetoothConnect.request();
        }
        break;
      default:
    }

    if (statusPermission == PermissionStatus.granted) {
      isGranted = true;
      print('Permission Granted');
    } else if (statusPermission == PermissionStatus.denied) {
      //Navigator.of(context).pop();
      //valueCheck = !valueCamera;
      print('Permission denied');
    } else if (statusPermission == PermissionStatus.permanentlyDenied ||
        statusPermission == PermissionStatus.restricted) {
      //valueCamera = valueCheck == false;
      print('Permission Permanently Denied');
      DialogUtils.showInformationDialog(
        context,
        content: 'Please access the system to provide permissions',
        onPressed: () async {
          Navigator.of(context).pop();
          await openAppSettings();
        },
        showCancelButton: true,
        onCancelPressed: () => Navigator.of(context).pop(),
      );
    } else if (statusPermission == PermissionStatus.limited) {
      //valueCamera = valueCheck == false;
      print('Permission Permanently Denied');
      DialogUtils.showInformationDialog(
        context,
        content: 'Please access the system to provide permissions',
        onPressed: () async {
          Navigator.of(context).pop();
          await openAppSettings();
        },
        showCancelButton: true,
        onCancelPressed: () => Navigator.of(context).pop(),
      );
    }

    return isGranted;
  }
}
