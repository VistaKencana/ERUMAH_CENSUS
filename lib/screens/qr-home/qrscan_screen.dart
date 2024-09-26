import 'dart:io';
import 'package:eperumahan_bancian/components/custom_alertdialog.dart';
import 'package:eperumahan_bancian/components/qr_not_tally_dialog.dart';
import 'package:eperumahan_bancian/screens/activity/bancian_info_modal.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/qr/bancian_register_qr.dart';
import 'package:eperumahan_bancian/screens/qr-home/bloc/qr_bloc.dart';
import 'package:eperumahan_bancian/services/app_log.dart';
import 'package:eperumahan_bancian/services/flushbar/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanScreen extends StatefulWidget {
  final bool isFromHome;
  final String? unitNumber;
  const QrScanScreen({super.key, this.isFromHome = true, this.unitNumber});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  late QrBloc _qrBloc;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final log = const AppLog(classname: "QrScanScreen");
  Barcode? result;
  QRViewController? controller;

  @override
  void initState() {
    super.initState();
    _qrBloc = BlocProvider.of<QrBloc>(context, listen: false);
  }

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
      body: BlocListener<QrBloc, QrState>(
        listener: (context, state) {
          if (state is QrLoading) {
            EasyLoading.show();
          } else if (state is QrSuccess) {
            EasyLoading.dismiss();
            controller?.pauseCamera();
            BancianInfosModal.show(context)
                .then((val) => controller?.resumeCamera());
          } else if (state is QrNotFound) {
            controller?.resumeCamera();
            EasyLoading.dismiss().then((val) => _registerAlertDialog());
          } else if (state is QrError) {
            controller?.resumeCamera();
            CustomFlushbar.of(context).showFailed(msg: state.msg);
            EasyLoading.dismiss();
          } else if (state is QrNotTally) {
            controller?.resumeCamera();
            EasyLoading.dismiss()
                .then((val) => _notTallyAlertDialog(state.msg));
          }
        },
        child: LayoutBuilder(builder: (context, constaint) {
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
              Visibility(
                visible: widget.unitNumber != null,
                child: Positioned(
                    top: constaint.maxHeight * 0.1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Unit: ${widget.unitNumber}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        // _roundedButton(
                        //   title: "Daftar QR",
                        //   onTap: () async {
                        //     _registerAlertDialog();
                        //   },
                        // ),
                        // _roundedButton(
                        //   title: "Teruskan",
                        //   onTap: () async {
                        //     controller?.pauseCamera();
                        //     BancianInfosModal.show(context)
                        //         .then((val) => controller?.resumeCamera());
                        //   },
                        // )
                      ],
                    )),
              )
            ],
          );
        }),
      ),
    );
  }

  // _roundedButton({required String title, required void Function() onTap}) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
  //       decoration: const ShapeDecoration(
  //           shape: StadiumBorder(), color: Colors.black26),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             title,
  //             style: const TextStyle(color: Colors.white),
  //           ),
  //           const Icon(
  //             Icons.chevron_right,
  //             color: Colors.white,
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  _registerAlertDialog() {
    controller?.pauseCamera();
    CustomAlertDialog(
      title: "QR tidak berdaftar!",
      subtitle: "QR perlu di daftar sebelum digunakan.",
      colorBtnLabel: "Daftar QR",
      onColorBtn: () async {
        Navigator.pop(context);
        Future.delayed(const Duration(milliseconds: 150), () {
          controller?.pauseCamera();
          const BancianRegisterQr()
              .show(context)
              .then((val) => controller?.resumeCamera());
        });
      },
      dimmedBtnLabel: "Kembali",
      onDimmedBtn: () => Navigator.pop(context),
    ).show(context).then((val) => controller?.resumeCamera());
  }

  _notTallyAlertDialog(String msg) {
    controller?.pauseCamera();
    QrNotTallyDialog(
      title: "QR ralat!",
      subtitle: msg,
      colorBtnLabel: "Daftar QR",
      onColorBtn: () async {
        Navigator.pop(context);
        Future.delayed(const Duration(milliseconds: 150), () {
          controller?.pauseCamera();
          const BancianRegisterQr()
              .show(context)
              .then((val) => controller?.resumeCamera());
        });
      },
      dimmedBtnLabel: "Kembali",
      onDimmedBtn: () => Navigator.pop(context),
    ).show(context).then((val) => controller?.resumeCamera());
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
      String qrCode = result?.code ?? "";
      log.logDebug(tag: "_onQRViewCreated", msg: "dapat data:${result?.code}");
      _qrBloc.add(ScanQrcode(qrCode: qrCode, isFromHome: widget.isFromHome));
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log.logDebug(
        tag: "_onPermissionSet",
        msg: '${DateTime.now().toIso8601String()}_onPermissionSet $p');
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
