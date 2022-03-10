import 'package:tflite/tflite.dart';
import 'package:camera/camera.dart';

import 'common_interface.dart';

class FaceMaskDetectorService extends ITensorFlowCommon<CameraImage, bool> {
  // init tensorflow
  @override
  initModel() async {
    await Tflite.loadModel(
        model: "assets/model/model.tflite",
        labels: "assets/model/labels.txt",
        numThreads: 2,
        useGpuDelegate: true);
  }

  // TODO using threading for alocate IMG translation for Dart
  @override
  Future<void> inference(CameraImage img) async {
    isBusy = true;
    //
    final unionBytes = img.planes.map((e) => e.bytes).toList();
    final recognitions = await Tflite.runModelOnFrame(
      bytesList: unionBytes,
      imageHeight: img.height,
      imageWidth: img.width,
      threshold: 0.3,
      numResults: 2,
      asynch: true,
    );
    //
    isBusy = false;
    recognitions?.forEach((element) {
      sink.add(_translateToBool(element));
    });
  }

  bool _translateToBool(dynamic data) {
    String label = data["label"];
    return label == "with_mask" ? true : false;
  }

  @override
  Future<void> dispose() async {
    await Tflite.close();
    await super.dispose();
  }
}
