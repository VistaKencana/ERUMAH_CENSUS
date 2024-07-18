import 'dart:io';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:eperumahan_bancian/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DocScanner extends StatefulWidget {
  final void Function(Uint8List bytes) onPicture;
  const DocScanner({super.key, required this.onPicture});

  @override
  State<DocScanner> createState() => _DocScannerState();
}

class _DocScannerState extends State<DocScanner> {
  @override
  void initState() {
    super.initState();
    _openCamera();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _openCamera() async {
    List<String> pictures;
    try {
      pictures = await CunningDocumentScanner.getPictures() ?? [];
      final img = await convertUint8List(pictures.first);
      if (!mounted) return;
      widget.onPicture(img);
      Navigator.pop(context);
    } catch (exception) {
      // Handle exception here
    }
  }

  Future<Uint8List> convertUint8List(String imagePath) async {
    File imageFile = File(imagePath);
    Uint8List imageBytes = await imageFile.readAsBytes();
    return imageBytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Gambar Kad",
        ),
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const Text("Document Scanner"),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Exit"))
          ],
        )));
  }
}
