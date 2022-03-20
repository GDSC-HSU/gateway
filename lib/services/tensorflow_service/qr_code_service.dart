import 'package:gateway/services/tensorflow_service/common_interface.dart';
import 'package:gateway/services/tensorflow_service/extension.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class GoogleMLKitQRService extends ITensorFlowCommon<InputImage, String> {
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
    if (isBusy) return;
    isBusy = true;
    var qrRecognitions = await _barcodeScanner.processImage(data);
    for (var element in qrRecognitions) {
      sink.add(element.value.rawValue!);
      // print(element.value.rawValue);
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
