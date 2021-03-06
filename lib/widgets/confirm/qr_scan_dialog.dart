import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/routes/routing.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/main.dart';
import 'package:gateway/services/camera_service.dart';
import 'package:gateway/services/tensorflow_service/extension.dart';
import 'package:gateway/services/tensorflow_service/qr_code_service.dart';
import 'package:gateway/widgets/common/button_custom.dart';
import 'package:gateway/widgets/confirm/organization_confirm.dart';

import '../../model/device_identity.dart';

class QRScanDialog extends StatefulWidget {
  const QRScanDialog({Key? key}) : super(key: key);

  @override
  State<QRScanDialog> createState() => _QRScanDialogState();
}

class _QRScanDialogState extends State<QRScanDialog> {
  CameraService cameraService = CameraService();
  GoogleMLKitQRService googleMLKitQRService = GoogleMLKitQRService();
  var selectedCamera = 0;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    // OMG :>
    _initCamera(selectedCamera);
    super.initState();
  }

  _initCamera(int cameraIndex) {
    _initializeControllerFuture = Future.wait([
      googleMLKitQRService.initModel(),
      cameraService.initialize(
          cameraDescription: cameras[cameraIndex],
          cameraResolution: ResolutionPreset.medium)
    ]).then((value) => cameraService.controller.startImageStream(
        (image) => googleMLKitQRService.inference(image.toInputImage())));
  }

  _takePicture() {}
  _changeCamera() {
    setState(() => {
          selectedCamera = selectedCamera == 0 ? 1 : 0,
          _initCamera(selectedCamera)
        });
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
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: GatewayColors.buttonBgLight,
                  ),
                );
              }
              return Stack(
                children: [
                  Positioned.fill(
                      child: CameraPreview(cameraService.controller)),
                  Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () => {_changeCamera()},
                        child: const Icon(Icons.flip_camera_ios),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                          primary: Colors.white,
                          onPrimary: Colors.black,
                        ),
                      )),
                  Positioned(
                    bottom: 16.h,
                    right: 0,
                    left: 0,
                    child: Container(
                      child: StreamBuilder<String>(
                          stream: googleMLKitQRService.stream,
                          builder: (builder, snapshot) {
                            var isLoading = true;
                            if (snapshot.hasData) {
                              // TODO validate JSON format before pop
                              isLoading = false;
                            }
                            final qrString = snapshot.data;
                            return AppBottomButton(
                              isLoading: isLoading,
                              bgColor: isLoading
                                  ? GatewayColors.disableButtonBgLight
                                  : GatewayColors.buttonBgLight,
                              title: "OK",
                              onFunction: () {
                                if (!isLoading) {
                                  Navigator.of(context).pop(qrString);
                                }
                                // Navigator.of(context).push<String>(
                                //   MaterialPageRoute<String>(
                                //       builder: (BuildContext context) =>
                                //           const OrganizationConfirm()),
                                // );
                              },
                            );
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
