import 'dart:typed_data';

import 'package:eperumahan_bancian/screens/bancian-forms/bancian_image_preview.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_main_screen.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bloc/bancian_bloc.dart';
import 'package:eperumahan_bancian/services/camera_service/screenshot_camera_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/image_bottom_sheet.dart';

class BancianProofCamera extends StatefulWidget {
  const BancianProofCamera({super.key});

  @override
  State<BancianProofCamera> createState() => _BancianProofCameraState();
}

class _BancianProofCameraState extends State<BancianProofCamera> {
  double initSize = 0.26;
  double maxSize = 0.26;
  double minSize = 0.1;
  int maxImage = 3;
  final DraggableScrollableController _controller =
      DraggableScrollableController();
  List<Uint8List> imgs = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Gambar Unit"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
      ),
      body: ScreenshotCameraWidget(
        onTakePicture: (Uint8List uintImg) async {
          _controller.jumpTo(maxSize);
          if (imgs.length >= maxImage) return;
          setState(() => imgs.add(uintImg));
        },
      ),
      bottomSheet: ImageBottomSheet(
        images: imgs,
        initSize: initSize,
        maxSize: maxSize,
        minSize: minSize,
        maxImage: maxImage,
        controller: _controller,
        onNext: (images) {
          context.read<BancianBloc>().setImages(imgs: images);
          _goReplace(const BancianMainScreen());
        },
        onTapImage: (image, index) {
          BancianImagePreview(
            canDelete: true,
            title: "Gambar ${index + 1}",
            image: imgs[index],
            onDelete: () {
              setState(() => imgs.removeAt(index));
              Navigator.pop(context);
            },
          ).show(context);
        },
      ),
    );
  }

  _goReplace(Widget screen) => Navigator.pushReplacement(context,
      PageTransition(child: screen, type: PageTransitionType.rightToLeft));
}
