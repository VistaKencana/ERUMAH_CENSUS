import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageBottomSheet extends StatefulWidget {
  final double initSize;
  final double maxSize;
  final double minSize;
  final int maxImage;
  final List<Uint8List> images;
  final DraggableScrollableController controller;
  final void Function(List<Uint8List> images) onNext;
  final void Function(Uint8List image, int index)? onTapImage;

  const ImageBottomSheet({
    super.key,
    required this.controller,
    this.initSize = 0.26,
    this.maxSize = 0.26,
    this.minSize = 0.08,
    this.maxImage = 3,
    required this.images,
    required this.onNext,
    this.onTapImage,
  });

  @override
  State<ImageBottomSheet> createState() => _ImageBottomSheetState();
}

class _ImageBottomSheetState extends State<ImageBottomSheet> {
  List<Uint8List> imgs = [];
  @override
  void initState() {
    super.initState();
    imgs = widget.images;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return DraggableScrollableSheet(
      expand: false,
      controller: widget.controller,
      initialChildSize: widget.initSize,
      maxChildSize: widget.maxSize,
      minChildSize: widget.minSize,
      builder: (context, sc) {
        return Container(
          color: Colors.white,
          child: ListView(
            controller: sc,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    height: 6,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0))),
                  ),
                ],
              ),
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
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusGeometry.circular(60))),
                        onPressed: imgs.length < (widget.maxImage - 1)
                            ? null
                            : () {
                                widget.onNext(imgs);
                              },
                        child: const Text(
                          "Seterusnya",
                          style: TextStyle(fontSize: 13),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(right: 12),
                  children: List.generate(imageLength(), (index) {
                    if (canAddImage(index)) {
                      return GestureDetector(
                        onTap: () => widget.controller.jumpTo(widget.minSize),
                        child: Container(
                          width: size.width * .26,
                          height: size.height * .12,
                          margin: const EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black12, width: 2),
                              color: Colors.grey.withValues(alpha: .2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                color: Colors.black54,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${imgs.length}/${widget.maxImage}",
                                style: TextStyle(color: Colors.black54),
                              )
                            ],
                          )),
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        if (widget.onTapImage != null) {
                          widget.onTapImage!(imgs[index], index);
                        }
                      },
                      child: Container(
                          width: size.width * .26,
                          height: size.height * .12,
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
          ),
        );
      },
    );
  }

  int imageLength() {
    if (imgs.isEmpty) {
      return 1;
    }
    int len = imgs.length;
    if (len >= widget.maxImage) {
      return len;
    }
    return len + 1;
  }

  bool canAddImage(int index) {
    return ((imageLength() == 1 || index == imageLength() - 1) &&
        imgs.length < widget.maxImage);
  }
}
