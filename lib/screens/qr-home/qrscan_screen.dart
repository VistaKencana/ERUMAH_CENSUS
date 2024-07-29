import 'dart:io';
import 'package:eperumahan_bancian/components/custom_alertdialog.dart';
import 'package:eperumahan_bancian/screens/activity/bancian_info_modal.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/qr/bancian_register_qr.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer' as dev;

class QrScanScreen extends StatefulWidget {
  final bool isFromHome;
  const QrScanScreen({super.key, this.isFromHome = true});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: !widget.isFromHome,
        title: const Text("QR Bancian"),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: LayoutBuilder(builder: (context, constaint) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: <Widget>[
                Expanded(
                  child: _buildQrView(context),
                ),
              ],
            ),
            Positioned(
                bottom: constaint.maxHeight * 0.2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _roundedButton(
                      title: "Daftar QR",
                      onTap: () async {
                        controller?.pauseCamera();
                        CustomAlertDialog(
                          title: "QR tidak berdaftar!",
                          subtitle: "QR perlu di daftar sebelum digunakan.",
                          colorBtnLabel: "Daftar QR",
                          onColorBtn: () async {
                            Navigator.pop(context);
                            Future.delayed(const Duration(milliseconds: 150),
                                () {
                              controller?.pauseCamera();
                              const BancianRegisterQr()
                                  .show(context)
                                  .then((val) => controller?.resumeCamera());
                            });
                          },
                          dimmedBtnLabel: "Kembali",
                          onDimmedBtn: () => Navigator.pop(context),
                        )
                            .show(context)
                            .then((val) => controller?.resumeCamera());
                      },
                    ),
                    _roundedButton(
                      title: "Teruskan",
                      onTap: () async {
                        controller?.pauseCamera();
                        BancianInfosModal.show(context)
                            .then((val) => controller?.resumeCamera());
                      },
                    )
                  ],
                ))
          ],
        );
      }),
    );
  }

  _roundedButton({required String title, required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: const ShapeDecoration(
            shape: StadiumBorder(), color: Colors.black26),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      await controller.pauseCamera();
      dev.log("dapat data:${result?.code}");
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    dev.log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
