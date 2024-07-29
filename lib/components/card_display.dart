import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:eperumahan_bancian/services/doc_scanner.dart';
import 'package:flutter/material.dart';

class CardDisplay extends StatefulWidget {
  final String title;
  final Uint8List? img;
  final IconData? icon;
  final void Function(Uint8List? img) onPicture;
  const CardDisplay(
      {super.key,
      required this.title,
      required this.onPicture,
      this.img,
      this.icon});

  @override
  State<CardDisplay> createState() => _CardDisplayState();
}

class _CardDisplayState extends State<CardDisplay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            final img = await DocScanner.openScanner();
            widget.onPicture(img);
          },
          child: DottedBorder(
            color: Colors.grey,
            padding: const EdgeInsets.all(4),
            dashPattern: const [8, 4],
            radius: const Radius.circular(14),
            borderType: BorderType.RRect,
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: MediaQuery.sizeOf(context).width * .43,
              height: MediaQuery.sizeOf(context).height * .15,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F6FB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: widget.img == null
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          Icon(
                            widget.icon ?? Icons.camera_alt_rounded,
                            size: 35,
                            color: Colors.black45,
                          ),
                          const SizedBox(height: 4),
                          const Center(
                            child: Text(
                              'Buka kamera & Ambil Gambar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Image.memory(
                      widget.img!,
                      fit: BoxFit.fill,
                    ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(widget.title),
      ],
    );
  }
}
