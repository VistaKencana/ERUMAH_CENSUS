import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'model/reader_response.dart';
import 'my_kad_reader.dart';

class MyKadController {
  // Private constructor
  MyKadController._privateConstructor();

  // Singleton instance
  static final MyKadController _instance =
      MyKadController._privateConstructor();

  // Factory constructor to return the singleton instance
  factory MyKadController() {
    return _instance;
  }

  StreamController<ReaderResponse>? controller;
  MyKadModel? _myKadModel;
  MyKidModel? _myKidModel;

  // Get the stream
  Stream<ReaderResponse>? get stream => controller?.stream;
  MyKadModel? get getMyKad => _myKadModel;
  MyKidModel? get getMyKid => _myKidModel;

  // Initialize the StreamController & MyKadReader
  void init({required bool verifyFP, required BuildContext context}) async {
    if (controller == null) {
      controller = StreamController<ReaderResponse>.broadcast();
      await MyKadReader.callSDK();

      /* --- Start M11 settings ---*/
      if (!context.mounted) return;
      await initFP(context);
      /* --- End M11 settings   ---*/

      if (!context.mounted) return;
      MyKadReader.sdkListener(
        context: context,
        onIdle: () {
          //Please insert card
          setMessage(msg: "Please insert card");
        },
        onReadCard: () {
          //Loading ...
          setMyKadData(null);
          setMessage(msg: "Loading read card...");
        },
        onSuccessCard: (data) async {
          setMyKadData(data);
          //Success read card
          setMessage(msg: "Read card successful", data: data);
          if (verifyFP) {
            await MyKadReader.turnOnFP();
            await addDelay(milisec: 2500);
            setMessage(msg: "Initialize Fingerprint Hardware...");
            await MyKadReader.getFPDeviceList();
            await addDelay(milisec: 2000);
            await connectAndScanFP();
          }
        },
        onErrorCard: () {
          //Remove card and try again
          setMessage(msg: "Remove card and try again");
        },
        onVerifyFP: () {
          //Verifying Fingerprint
          setMessage(msg: "Please place your fingerprint at the scanner");
        },
        onSuccessFP: () {
          //Success verify fingerprint
          setMessage(msg: "User verification successful");
        },
        onErrorFP: () async {
          //Please try again
          setMessage(msg: "Error: Please try again");
        },
      );
    }
  }

  Future addDelay({int milisec = 1500}) =>
      Future.delayed(Duration(milliseconds: milisec));

  void addData(ReaderResponse data) => controller?.sink.add(data);

  Future connectAndScanFP() async {
    await MyKadReader.disconnectFPScanner();
    await addDelay();
    await MyKadReader.connectFPScanner();
    await addDelay();
    await MyKadReader.readFingerprint();
  }

  Future initFP(BuildContext context) async {
    showLoading(context);
    setMessage(msg: "Initialize Fingerprint Hardware...");
    await MyKadReader.turnOnFP();
    await addDelay(milisec: 2500);
    await MyKadReader.disconnectFPScanner();
    await addDelay();
    await MyKadReader.connectFPScanner();
    if (!context.mounted) return;
    closeLoading(context);
  }

  Future tryAgain() async {
    setMessage(msg: "Initialize Fingerprint Hardware...");
    await MyKadReader.disconnectFPScanner();
    await addDelay();
    await MyKadReader.connectFPScanner();
    await addDelay();
    await MyKadReader.readFingerprint();
  }

  void setMessage({SdkResponseModel? data, required String msg}) {
    var resp =
        ReaderResponse(data: data?.toJson().toString() ?? "", message: msg);
    addData(resp);
  }

  void setMyKadData(SdkResponseModel? data) {
    if (data == null) {
      _myKadModel = null;
      _myKidModel = null;
      return;
    }
    final json = jsonDecode(data.data!);
    if (data.isDataMykad()) {
      _myKadModel = MyKadModel.fromJson(json);
    } else {
      _myKidModel = MyKidModel.fromJson(json);
    }
  }

  // Close the StreamController
  Future<void> close() async {
    controller?.close();
    controller = null;
    setMyKadData(null);
    await MyKadReader.disconnectFPScanner();
    await addDelay();
    await MyKadReader.turnOffFP();
    await addDelay();
    await MyKadReader.disposeListener();
  }

  void closeLoading(BuildContext context) => Navigator.pop(context);

  Future<dynamic> showLoading(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (context) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {},
        child: GestureDetector(
          onTap: () {},
          child: Material(
              color: Colors.black.withValues(alpha: 0.6),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 100,
                    width: 100,
                    padding: const EdgeInsets.all(15),
                    color: Colors.white,
                    child: const CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
