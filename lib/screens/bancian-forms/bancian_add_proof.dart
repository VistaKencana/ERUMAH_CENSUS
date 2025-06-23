import 'dart:typed_data';

import 'package:eperumahan_bancian/services/camera_service/screenshot_camera_widget.dart';
import 'package:flutter/material.dart';

class BancianAddProof extends StatefulWidget {
  final Function(Uint8List) onTakePicture;
  const BancianAddProof({super.key, required this.onTakePicture});

  @override
  State<BancianAddProof> createState() => _BancianAddProofState();
}

class _BancianAddProofState extends State<BancianAddProof> {
  double initSize = 0.26;
  double maxSize = 0.26;
  double minSize = 0.1;
  int maxImage = 3;
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
        onTakePicture: (Uint8List uintImg) {
          widget.onTakePicture(uintImg);
          Navigator.pop(context);
        },
      ),
    );
  }
}
