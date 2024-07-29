import 'dart:typed_data';

import 'package:eperumahan_bancian/screens/bancian-forms/bancian_image_preview.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_main_screen.dart';
import 'package:eperumahan_bancian/services/camera_service/camera_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class BancianProofCamera extends StatefulWidget {
  const BancianProofCamera({super.key});

  @override
  State<BancianProofCamera> createState() => _BancianProofCameraState();
}

class _BancianProofCameraState extends State<BancianProofCamera> {
  double initSize = 0.26;
  double maxSize = 0.26;
  double minSize = 0.08;
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
      body: CameraWidget(
        onTakePicture: (Uint8List uintImg) {
          _controller.jumpTo(maxSize);
          if (imgs.length >= maxImage) return;
          setState(() => imgs.add(uintImg));
        },
      ),
      bottomSheet: DraggableScrollableSheet(
        expand: false,
        controller: _controller,
        initialChildSize: initSize,
        maxChildSize: maxSize,
        minChildSize: minSize,
        builder: (context, sc) {
          return ListView(
            controller: sc,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 12, right: 12, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Gambar",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                        onPressed: imgs.length < (maxImage - 1)
                            ? null
                            : () {
                                _goReplace(BancianMainScreen(imgs: imgs));
                              },
                        child: const Text("Seterusnya")),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(imageLength(), (index) {
                    if (canAddImage(index)) {
                      return GestureDetector(
                        onTap: () => _controller.jumpTo(minSize),
                        child: Container(
                          width: 120,
                          height: 100,
                          margin: const EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Icon(Icons.camera_alt),
                          ),
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
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
                      child: Container(
                          width: 120,
                          height: 100,
                          margin: const EdgeInsets.only(left: 12),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.memory(
                            imgs[index],
                            fit: BoxFit.fill,
                          )),
                    );
                  }),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  _goReplace(Widget screen) => Navigator.pushReplacement(context,
      PageTransition(child: screen, type: PageTransitionType.rightToLeft));

  int imageLength() {
    if (imgs.isNotEmpty) {
      int len = imgs.length;
      if (len >= maxImage) {
        return len;
      }
      return len + 1;
    }
    return 1;
  }

  bool canAddImage(int index) {
    return ((imageLength() == 1 || index == imageLength() - 1) &&
        imgs.length < maxImage);
  }
}
