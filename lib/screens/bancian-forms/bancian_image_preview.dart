import 'dart:typed_data';

import 'package:flutter/material.dart';

class BancianImagePreview extends StatefulWidget {
  final Uint8List image;
  final String title;
  final void Function() onDelete;
  const BancianImagePreview(
      {super.key,
      required this.image,
      required this.title,
      required this.onDelete});

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
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 22),
                ),
                GestureDetector(
                  onTap: widget.onDelete,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            AspectRatio(
              aspectRatio: 10 / 10,
              child: Image.memory(widget.image),
            )
          ],
        ),
      ),
    );
  }
}
