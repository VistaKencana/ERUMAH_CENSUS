import 'package:eperumahan_bancian/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';

class DocScanner extends StatefulWidget {
  final void Function(Uint8List bytes) onPicture;
  const DocScanner({super.key, required this.onPicture});

  @override
  State<DocScanner> createState() => _DocScannerState();
}

class _DocScannerState extends State<DocScanner> {
  final _controller = DocumentScannerController();

  @override
  void dispose() {
    _controller.dispose();
    enforcePortraitMode();
    super.dispose();
  }

  void enforcePortraitMode() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Gambar Kad",
        foregroundColor: Colors.white,
      ),
      extendBodyBehindAppBar: true,
      body: DocumentScanner(
        controller: _controller,
        cropPhotoDocumentStyle: CropPhotoDocumentStyle(
          top: MediaQuery.of(context).padding.top,
        ),
        onSave: (Uint8List bytes) {
          // ? Bytes of the document/image already processed
          Navigator.pop(context);
          widget.onPicture(bytes);
        },
      ),
    );
  }
}
