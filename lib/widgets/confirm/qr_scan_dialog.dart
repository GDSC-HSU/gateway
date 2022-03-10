import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/services/camera_service.dart';
import 'package:gateway/services/tensorflow_service/extension.dart';
import 'package:gateway/services/tensorflow_service/qr_code_service.dart';
import 'package:gateway/widgets/common/button_custom.dart';

class QRScanDialog extends StatefulWidget {
  const QRScanDialog({Key? key}) : super(key: key);

  @override
  State<QRScanDialog> createState() => _QRScanDialogState();
}

class _QRScanDialogState extends State<QRScanDialog> {
  CameraService cameraService = CameraService();
  GoogleMLKitQRService googleMLKitQRService = GoogleMLKitQRService();
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    // OMG :>
    _initializeControllerFuture = Future.wait(
            [googleMLKitQRService.initModel(), cameraService.initialize()])
        .then((value) => cameraService.controller.startImageStream(
            (image) => googleMLKitQRService.inference(image.toInputImage())));
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await googleMLKitQRService.dispose();
    await cameraService.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Stack(
                children: [
                  Positioned.fill(
                      child: CameraPreview(cameraService.controller)),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: StreamBuilder<String>(
                          stream: googleMLKitQRService.stream,
                          builder: (builder, snapshot) {
                            var isLoading = true;
                            if (snapshot.hasData) {
                              isLoading = false;
                            }
                            final qrString = snapshot.data;
                            return AppBottomButton(
                                isLoading: isLoading,
                                bgColor: isLoading
                                    ? GatewayColors.disableButtonBgLight
                                    : GatewayColors.buttonBgLight,
                                title: "OK",
                                onFunction: () =>
                                    {Navigator.of(context).pop(qrString)});
                          }),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
