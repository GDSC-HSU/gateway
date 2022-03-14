import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:gateway/main.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

extension TransformToInputImage on CameraImage {
  InputImage toInputImage() {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize = Size(width.toDouble(), height.toDouble());

    final camera = cameras.last;
    final imageRotation =
        InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    final inputImageFormat = InputImageFormatMethods.fromRawValue(format.raw) ??
        InputImageFormat.NV21;

    final planeData = planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
    return inputImage;
  }
}

extension IsNull on BarcodeValue {
  bool get isNull => rawValue != null ? true : false;
}

/// TODO [LargestQRInFrontOfCamera]
extension LargestQRInFrontOfCamera on List<Barcode> {
  // hmm not sure it gonna work
  Barcode largestQR() {
    final largestQR = reduce((firstBox, secondBox) {
      final acreageFirstBox =
          firstBox.value.boundingBox!.left * firstBox.value.boundingBox!.right;
      final acreageSecondBox = secondBox.value.boundingBox!.left *
          secondBox.value.boundingBox!.right;

      final isFirstBoxLarger = acreageFirstBox > acreageSecondBox;
      return isFirstBoxLarger ? firstBox : secondBox;
    });
    return largestQR;
  }
}
