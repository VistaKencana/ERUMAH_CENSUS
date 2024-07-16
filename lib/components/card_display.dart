import 'dart:typed_data';

import 'package:eperumahan_bancian/services/doc_scanner.dart';
import 'package:flutter/material.dart';

class CardDisplay extends StatefulWidget {
  final String title;
  final Uint8List? img;
  final void Function(Uint8List) onPicture;
  const CardDisplay(
      {super.key, required this.title, required this.onPicture, this.img});

  @override
  State<CardDisplay> createState() => _CardDisplayState();
}

class _CardDisplayState extends State<CardDisplay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => DocScanner(onPicture: widget.onPicture)));
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            width: MediaQuery.sizeOf(context).width * .43,
            height: MediaQuery.sizeOf(context).height * .15,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border.all(
                color: Colors.grey,
                style: BorderStyle.solid,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: widget.img == null
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 10),
                        Center(
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
        const SizedBox(height: 10),
        Text(widget.title),
      ],
    );
  }
}
