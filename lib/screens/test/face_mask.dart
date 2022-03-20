import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/main.dart';
import 'package:gateway/services/camera_service.dart';
import 'package:gateway/services/tensorflow_service/face_mask_detector_service.dart';

class FaceMaskTest extends StatefulWidget {
  const FaceMaskTest({Key? key}) : super(key: key);

  @override
  State<FaceMaskTest> createState() => _FaceMaskTestState();
}

class _FaceMaskTestState extends State<FaceMaskTest> {
  CameraService cameraService = CameraService();

  FaceMaskDetectorService faceMaskDetectorService = FaceMaskDetectorService();
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    // OMG :>

    _initializeControllerFuture = Future.wait([
      faceMaskDetectorService.initModel(),
      cameraService.initialize(cameraDescription: cameras.last)
    ]).then((value) {
      if (!mounted) return;
      setState(() {
        cameraService.controller.startImageStream((image) => {
              // googleMLKitQRService.inference(image.toInputImage()),
              faceMaskDetectorService.inference(image)
            });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FutureBuilder(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                      color: GatewayColors.bgDark,
                      borderRadius: BorderRadius.circular(20.r)),
                  child: CameraPreview(
                    cameraService.controller,
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          // StreamBuilder<bool>(
          //     stream: faceMaskDetectorService.stream,
          //     builder: ((context, snapshot) {
          //       if (snapshot.hasData) {
          //         return Container(
          //           child: Text(snapshot.data.toString()),
          //         );
          //       }
          //       return Container();
          //     }))
        ],
      ),
    );
  }
}
