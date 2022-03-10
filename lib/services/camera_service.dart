import 'package:camera/camera.dart';
import 'package:gateway/main.dart';

// STEP BY STEP => Flutter camera packge open (tflite) then qr_code_scanner

class CameraService {
  // singleton boilerplate
  static final CameraService _cameraServiceService = CameraService._internal();

  factory CameraService() {
    return _cameraServiceService;
  }
  // singleton boilerplate
  CameraService._internal();

  late CameraController controller;

  CameraImage? cameraImage;

  bool get isInitialized => controller.value.isInitialized;
  bool get isImgBeenStream => cameraImage != null ? true : false;

  /// camera locations
  Future<void> initialize(
      {required CameraDescription cameraDescription}) async {
    controller = CameraController(cameraDescription, ResolutionPreset.low,
        enableAudio: false);
    await controller.initialize();
  }

  startImgStream() async {
    if (!isImgBeenStream) {
      await controller.startImageStream((image) => cameraImage = image);
    }
  }

  stopImgStream() async {
    if (isImgBeenStream) {
      await controller.stopImageStream();
      cameraImage = null;
    }
  }

  Future<void> dispose() async {
    await controller.dispose();
  }
}
