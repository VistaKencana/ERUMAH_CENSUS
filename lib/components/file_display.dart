import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';

import 'package:eperumahan_bancian/config/constants/app_colors.dart';

import 'package:eperumahan_bancian/services/doc_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FileDisplay extends StatelessWidget {
  final bool isMandatory;
  final String? title;
  final String? subtitle;
  final Uint8List? img;
  final IconData? icon;
  final void Function(Uint8List? img) onPicture;
  const FileDisplay(
      {super.key,
      this.isMandatory = false,
      this.title,
      this.subtitle,
      this.img,
      this.icon,
      required this.onPicture});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (title != null)
              Text(title!,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500)),
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
              if (img != null) {
                openEditScreen(context, img!);
              } else {
                final val = await DocScanner.openScanner();
                onPicture(val);
              }
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.dimmedPurple.color),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  (img != null)
                      ? Image.memory(
                          img!,
                          height: 80.h,
                          width: 80.h,
                          fit: BoxFit.fill,
                        )
                      : Container(
                          height: 80.h,
                          width: 80.h,
                          color: Colors.grey.withOpacity(.3),
                          child: Icon(
                            icon ?? Icons.camera_alt_rounded,
                            size: 20,
                            color: Colors.black45,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(subtitle ?? "Ambil gambar"),
                  )
                ],
              ),
            )
            // : dottedBorder(context),
            )
      ],
    );
  }

  DottedBorder dottedBorder(BuildContext context) {
    return DottedBorder(
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
        ));
  }

  openEditScreen(BuildContext context, Uint8List imageData) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              title: const Text(
                'Image Viewer',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    final img = await DocScanner.openScanner();
                    onPicture(img);
                    if (!context.mounted) return;
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            body: Center(
              child: InteractiveViewer(
                minScale: 1.0,
                maxScale: 10.0,
                child: AspectRatio(
                  aspectRatio: 10 / 10,
                  child: Image.memory(imageData),
                ),
              ),
            ),
          );
        });
  }
}
