import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:eperumahan_bancian/services/doc_scanner.dart';
import 'package:flutter/material.dart';

class FileDisplay extends StatelessWidget {
  final bool isMandatory;
  final String title;
  final Uint8List? img;
  final IconData? icon;
  final void Function(Uint8List? img) onPicture;
  const FileDisplay(
      {super.key,
      this.isMandatory = false,
      required this.title,
      this.img,
      this.icon,
      required this.onPicture});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            if (isMandatory)
              const Text(
                "*",
                style: TextStyle(color: Colors.red),
              )
          ],
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () async {
            final img = await DocScanner.openScanner();
            onPicture(img);
          },
          child: DottedBorder(
              radius: const Radius.circular(12),
              padding: const EdgeInsets.all(4),
              dashPattern: const [8, 4],
              borderType: BorderType.RRect,
              child: Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * .18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFF7F6FB),
                ),
                child: img == null
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Icon(
                              icon ?? Icons.camera_alt_rounded,
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
                        img!,
                        fit: BoxFit.contain,
                      ),
              )),
        )
      ],
    );
  }
}
