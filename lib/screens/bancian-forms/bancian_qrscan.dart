import 'package:eperumahan_bancian/screens/bancian-forms/bancian_form_screen.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_proof_camera.dart';
import 'package:eperumahan_bancian/services/qr_code_scanner_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class BancianQrscan extends StatefulWidget {
  const BancianQrscan({super.key});

  @override
  State<BancianQrscan> createState() => _BancianQrscanState();
}

class _BancianQrscanState extends State<BancianQrscan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("QR Bancian"),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: QrCodeScannerWidget(
        onScan: (data) {
          _goReplace(const BancianFormScreen());
        },
        onNext: () {
          _goReplace(const BancianProofCamera());
        },
      ),
    );
  }

  _goReplace(Widget screen) => Navigator.pushReplacement(context,
      PageTransition(child: screen, type: PageTransitionType.rightToLeft));
}
