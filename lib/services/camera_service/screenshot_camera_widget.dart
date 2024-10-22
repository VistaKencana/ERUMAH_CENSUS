import 'package:camera/camera.dart';
import 'package:eperumahan_bancian/components/live_date_time.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bloc/bancian_bloc.dart';
import 'package:eperumahan_bancian/services/app_log.dart';
import 'package:eperumahan_bancian/services/camera_service/camera_overlay.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
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
  CameraController? controller;
  bool isLoading = false;
  Uint8List? images;
  final ssCtrl = ScreenshotController();
  String pprUnit = "";
  @override
  void initState() {
    super.initState();
    _getCameraDesc();
    pprUnit =
        context.read<BancianBloc>().unitData.unit?.housingProject?.desc ?? "";
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  _getCameraDesc() async {
    final cameraDesc = await availableCameras();
    controller = CameraController(cameraDesc[0], ResolutionPreset.veryHigh);

    _cameraPermissionCheck(controller: controller!);
  }

  _cameraPermissionCheck({required CameraController controller}) {
    _checkCameraPermission().then((isGranted) {
      if (!isGranted) {
        Future.delayed(const Duration(seconds: 0)).then((_) {
          showModalBottomSheet(
              isDismissible: false,
              enableDrag: false,
              // ignore: use_build_context_synchronously
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor: Colors.white,
              builder: (builder) {
                return PopScope(
                  canPop: false,
                  onPopInvokedWithResult: (didPop, result) {},
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.3),
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.camera_alt)),
                          const SizedBox(height: 15),
                          const Text(
                            'Permission to use\nCamera',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          SizedBox(
                              height: 45,
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await onPressedAllow(context, controller);
                                  },
                                  child: const Text("Allow"))),
                          const SizedBox(height: 6),
                          SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Later',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
      } else {
        initiateCamera(controller);
      }
    });
  }

  Future<void> onPressedAllow(
      BuildContext context, CameraController controller) async {
    await initiateCamera(controller).then((value) async => {
          if (await Permission.camera.status.isGranted)
            {
              if (context.mounted) {Navigator.pop(context)}
            }
        });
  }

  cameraWidget(context) {
    if (!(controller?.value.isInitialized ?? false)) {
      return Container();
    }
    var camera = controller!.value;

    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * camera.aspectRatio;
    if (scale < 1) scale = 1 / scale;

    return Screenshot(
      controller: ssCtrl,
      child: LayoutBuilder(builder: (context, constraint) {
        return Stack(
          children: [
            Transform.scale(
              scale: scale,
              child: Center(
                child: CameraPreview(controller!),
              ),
            ),
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
    );
  }

  Future<void> initiateCamera(CameraController controller) {
    return controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
            break;
        }
      }
    });
  }

  Future<bool> _checkCameraPermission() async {
    bool cameraGranted = false;
    var status = await Permission.camera.status;
    if (status.isGranted) {
      setState(() {
        cameraGranted = true;
      });
    }
    return cameraGranted;
  }

  void closeLoading() => Navigator.pop(context);

  Future<dynamic> showLoading(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (context) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {},
        child: GestureDetector(
          onTap: () {},
          child: Material(
              color: Colors.black.withOpacity(0.6),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 100,
                    width: 100,
                    padding: const EdgeInsets.all(15),
                    color: Colors.white,
                    child: const CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        cameraWidget(context),
        if (widget.overlay != null) widget.overlay!,
        Padding(
          padding: const EdgeInsets.only(bottom: 90),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () async {
                  showLoading(context);
                  await controller!.setFocusMode(FocusMode.locked);
                  await controller!.setExposureMode(ExposureMode.locked);
                  controller!.pausePreview();

                  ssCtrl
                      .capture(delay: const Duration(milliseconds: 10))
                      .then((capturedImage) async {
                    controller!.resumePreview();
                    widget.onTakePicture(capturedImage!);
                    closeLoading();
                  }).catchError((onError) {
                    const AppLog(classname: "screenshot camera")
                        .logError(tag: "capture imge", msg: onError);
                  });

                  if (controller == null) return;
                  await controller!.setFocusMode(FocusMode.auto);
                  await controller!.setExposureMode(ExposureMode.auto);
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      shape: BoxShape.circle),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                  ),
                ),
              )),
        ),
      ],
    );
  }

  Future<dynamic> showCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text("Captured widget screenshot"),
        ),
        body: Center(child: Image.memory(capturedImage)),
      ),
    );
  }
}
