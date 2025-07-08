import 'dart:typed_data';

import 'package:flutter/material.dart';

class BancianImagePreview extends StatefulWidget {
  final Uint8List image;
  final String title;
  final void Function()? onDelete;
  final void Function()? onEdit;
  final bool canDelete;
  final bool canEdit;
  const BancianImagePreview(
      {super.key,
      required this.image,
      required this.title,
      this.canDelete = true,
      this.onDelete,
      this.onEdit,
      this.canEdit = false});

  @override
  State<BancianImagePreview> createState() => _BancianImagePreviewState();

  Future<T?> show<T>(BuildContext context) {
    return showDialog<T>(
      context: context,
      builder: (_) => this,
    );
  }
}

class _BancianImagePreviewState extends State<BancianImagePreview> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
        color: Colors.black,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text(
              widget.title,
              style: const TextStyle(fontSize: 18),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _iconButton(
                iconData: Icons.close_rounded,
                onTap: () => Navigator.pop(context),
                title: "Kembali",
              ),
            ),
            actions: [
              Visibility(
                visible: widget.canDelete,
                child: _iconButton(
                  isFilled: true,
                  iconData: Icons.delete,
                  onTap: () {
                    if (widget.onDelete == null) return;
                    widget.onDelete!();
                  },
                  title: "Buang",
                ),
              ),
              SizedBox(width: widget.canEdit ? 30 : 0),
              Visibility(
                visible: widget.canEdit,
                child: _iconButton(
                  isFilled: true,
                  iconData: Icons.edit,
                  onTap: () {
                    if (widget.onEdit == null) return;
                    widget.onEdit!();
                  },
                  title: "Ubah",
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ScaleTransition(
                  scale: CurvedAnimation(
                    parent: ModalRoute.of(context)!.animation!,
                    curve: Curves.easeOut,
                    reverseCurve: Curves.easeIn,
                  ),
                  child: InteractiveViewer(
                    minScale: 1.0,
                    maxScale: 10.0,
                    child: Image.memory(
                      widget.image,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: SizedBox(height: 60),
        ),
      ),
    );
  }

  Column _iconButton(
      {required String title,
      bool isFilled = false,
      required IconData iconData,
      required void Function() onTap}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: isFilled ? Colors.white : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white)),
            child: Icon(
              iconData,
              color: isFilled ? Colors.black : Colors.white,
              size: 18,
            ),
          ),
        ),
        // const SizedBox(height: 3),
        // Text(
        //   title,
        //   style: const TextStyle(color: Colors.white),
        // )
      ],
    );
  }
}
