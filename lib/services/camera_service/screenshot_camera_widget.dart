import 'package:camera/camera.dart';
import 'package:eperumahan_bancian/components/live_date_time.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bloc/bancian_bloc.dart';
import 'package:eperumahan_bancian/services/camera_service/camera_helper.dart';
import 'package:eperumahan_bancian/services/camera_service/camera_overlay.dart';
import 'package:eperumahan_bancian/services/camera_service/camera_scaffold.dart';
import 'package:eperumahan_bancian/services/camera_service/screenshot_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class ScreenshotCameraWidget extends StatefulWidget {
  final void Function(Uint8List uintImg) onTakePicture;
  final CameraOverlay? overlay;
  const ScreenshotCameraWidget({
    super.key,
    required this.onTakePicture,
    this.overlay,
  });

  @override
  State<ScreenshotCameraWidget> createState() => _ScreenshotCameraWidgetState();
}

class _ScreenshotCameraWidgetState extends State<ScreenshotCameraWidget> {
  late CameraHelper cameraHelper;
  CameraController? controller;
  final ssCtrl = ScreenshotController();
  static List<CameraDescription> _cameras = [];
  bool isLoading = false;
  Uint8List? images;
  String pprUnit = "";

  late final AppLifecycleListener lifecycleListener;
  @override
  void initState() {
    super.initState();
    cameraHelper = CameraHelper(context: context);

    lifecycleListener = AppLifecycleListener(
      onResume: _initCamera,
      onPause: () => controller?.dispose(),
      onInactive: () => controller?.dispose(),
    );
    _initCamera();
    pprUnit =
        context.read<BancianBloc>().unitData.unit?.housingProject?.desc ?? "";
  }

  @override
  void dispose() {
    lifecycleListener.dispose();
    controller!.dispose();
    super.dispose();
  }

  Future<void> _initCamera() async {
    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }

    controller = await cameraHelper.initialize(
      controller: controller,
      cameras: _cameras,
      onRefreshed: () {
        if (!mounted) return;
        setState(() {});
      },
    );
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CameraScaffold(
      overlay: [
        if (widget.overlay != null) widget.overlay!,
      ],
      preview: Screenshot(
        controller: ssCtrl,
        child: LayoutBuilder(builder: (context, constraint) {
          return Stack(
            children: [
              cameraHelper.cameraWidget(
                  controller: controller, isFullScreen: true),
              Positioned(
                  bottom: constraint.maxHeight * .15,
                  left: constraint.maxWidth * .1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pprUnit,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const LiveDateTime(),
                    ],
                  ))
            ],
          );
        }),
      ),

      //   child: cameraHelper.cameraWidget(
      //       controller: controller, isFullScreen: true),
      // ),
      cameraButton: cameraHelper.cameraButton(
        onTap: () async {
          try {
            cameraHelper.showLoading();
            // await controller!.setFocusMode(FocusMode.locked);
            // await controller!.setExposureMode(ExposureMode.locked);
            controller!.pausePreview();
            final bytes = await ScreenshotHelper.capture(ssCtrl);
            controller!.resumePreview();
            widget.onTakePicture(bytes!);
            cameraHelper.closeLoading();
            if (controller == null) return;
          } catch (e) {
            debugPrint("Pause error: $e");
          }

          // await controller!.setFocusMode(FocusMode.auto);
          // await controller!.setExposureMode(ExposureMode.auto);
        },
      ),
    );
  }
}
