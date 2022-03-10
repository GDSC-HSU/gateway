import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:gateway/main.dart';
import 'package:gateway/services/tensorflow_service/common_interface.dart';
import 'package:gateway/services/tensorflow_service/extension.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class GoogleMLKitService extends ITensorFlowCommon<InputImage, String> {
  late BarcodeScanner _barcodeScanner;

  @override
  Future<void> initModel() async {
    _barcodeScanner = GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);
  }

  // TODO Handle mutiple QR encouter in Camera buffer T__Ts
  /// Idea by using [Barcode.value.boundingBox] to deterimate with is the largest in camera buffer
  ///
  @override
  Future<void> inference(InputImage data) async {
    isBusy = true;
    var qrRecognitions = await _barcodeScanner.processImage(data);
    for (var element in qrRecognitions) {
      if (element.value.isNull) continue;
      sink.add(element.value.rawValue!);
    }
    isBusy = false;
    return;
  }

  @override
  Future<void> dispose() async {
    await _barcodeScanner.close();
    await super.dispose();
  }
}
