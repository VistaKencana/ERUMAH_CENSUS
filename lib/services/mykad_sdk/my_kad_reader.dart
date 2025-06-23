// ignore_for_file: constant_identifier_names

library;

export 'model/my_kad_model.dart';
export 'model/my_kid_model.dart';
export 'model/sdk_response_model.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer' as dev;
import 'model/sdk_response_model.dart';

enum CardReaderStatus {
  READER_INSERTED,
  CARD_INSERTED,
  CARD_SUCCESS,
  CARD_INSERTED_ERROR,
  CARD_REMOVE,
  READER_REMOVED,
  VERIFY_FP,
  FP_FAILED_VERIFY,
  FP_SCANNER_ERROR,
  FP_SUCCESS_VERIFY,
}

class MyKadReader {
  static const platform = MethodChannel('com.myKad/fingerprint');

  static void sdkListener({
    bool isDebug = false,
    required BuildContext context,
    required void Function() onIdle,
    required void Function() onReadCard,
    required void Function(SdkResponseModel data) onSuccessCard,
    required void Function() onErrorCard,
    required void Function() onVerifyFP,
    required void Function() onSuccessFP,
    required void Function() onErrorFP,
  }) {
    platform.setMethodCallHandler((call) async {
      final String data = call.arguments;
      final state = CardReaderStatus.values.byName(call.method);
      dev.log("TEST: ${call.method}");
      if (state == CardReaderStatus.READER_INSERTED) {
        dev.log("${state.name}: $data");
        onIdle();
      } else if (state == CardReaderStatus.CARD_INSERTED) {
        dev.log("${state.name}: $data");
        Fluttertoast.showToast(msg: "CARD INSERTED");
        onReadCard();
      } else if (state == CardReaderStatus.CARD_SUCCESS) {
        final sdkresponse = SdkResponseModel.fromJson(jsonDecode(data));
        onSuccessCard(sdkresponse);
        Fluttertoast.showToast(msg: "CARD SUCCESS");
        // final json = jsonDecode(sdkresponse.data!);
        // if (sdkresponse.isDataMykad()) {
        //   final model = MyKadModel.fromJson(json);
        //   dev.log("Nama: ${model.name}");
        // } else {
        //   final model = MyKidModel.fromJson(json);
        //   dev.log("Nama: ${model.name}");
        // }
      } else if (state == CardReaderStatus.CARD_INSERTED_ERROR) {
        dev.log("${state.name}: $data");
        if (isDebug) debugErrorDialog(data, context);
        onErrorCard();
        Fluttertoast.showToast(msg: "CARD INSERTED ERROR $data");
      } else if (state == CardReaderStatus.CARD_REMOVE) {
        dev.log("${state.name}: $data");
        onIdle();
        Fluttertoast.showToast(msg: "CARD REMOVE");
      } else if (state == CardReaderStatus.VERIFY_FP) {
        onVerifyFP();
        Fluttertoast.showToast(msg: "VERIFY_FP $data");
      } else if (state == CardReaderStatus.FP_FAILED_VERIFY ||
          state == CardReaderStatus.FP_SCANNER_ERROR) {
        dev.log("${state.name}: $data");
        onErrorFP();
        Fluttertoast.showToast(msg: "FP_FAILED_VERIFY $data");
      } else if (state == CardReaderStatus.FP_SUCCESS_VERIFY) {
        onSuccessFP();
        Fluttertoast.showToast(msg: "FP_SUCCESS_VERIFY $data");
      } else {
        dev.log(data);
      }
    });
  }

  static Future<void> callSDK({bool usingFP = false, String? license}) async {
    try {
      String trialLicense =
          "eyJ2ZXJzaW9uIjoxLCJwYXlsb2FkIjoiNlVDaG5rVHZoZkt6b1FvZUVoWmIzUnEvaWVqak5ydUM5VmdmZ2VjdVFTejc5TXRtQ1VGS1pHZWJ2OXVmZnQ2MnJ3L1R4eWNVd0d1UTJVMXNwYW13WWxCSGQwVG9yS0I3dHE2UlVaQU5RMGo0d2NuMVhNSXBNaW1kNXc5WGlLWGtjU0FRT3RCdEZJMFdkek1KTm9xZlRKaVVNbjJlU3d0Yy9sUFdHYlY1cHN0UWhGM1l4bWxWZlRPWXQ1MWpZSE5NIiwic2lnbmF0dXJlIjoiTUVVQ0lRQ3R6UmRMc2tWcUdDYTBJVTdYdjBjNDIyRFV2U25rOXVwalk4QVorUi9kRWdJZ1IwSVRWOVVzV29yUTZOMGxOOHp3bTZ6anM2c2lwSXVnejBUL0kxdzdaSms9IiwiY2hhbGxhbmdlX2NvZGUiOiJuRGFsTFhsYzlLIn0=";
      if (license == null || license.isEmpty) {
        dev.log(" SDK: Using trial license ");
      }
      var args = {
        "usingFP": usingFP,
        "license":
            (license == null || license.isEmpty) ? trialLicense : license,
      };
      await platform.invokeMethod('myKadSDK', args);
    } on PlatformException catch (e) {
      dev.log("Failed to call SDK: '${e.message}'.");
    }
  }

  static Future<void> turnOnFP() async {
    try {
      final isConnected =
          await platform.invokeMethod<bool>('turnOnFP') ?? false;
      Fluttertoast.showToast(msg: "FP Turned on: $isConnected");
    } on PlatformException catch (e) {
      dev.log("Failed to turn on: '${e.message}'.");
    }
  }

  static Future<void> turnOffFP() async {
    try {
      final isDisconnected = await platform.invokeMethod('turnOffFP');
      Fluttertoast.showToast(msg: "FP turned off: $isDisconnected");
    } on PlatformException catch (e) {
      dev.log("Failed to turn off: '${e.message}'.");
    }
  }

  static Future<void> connectFPScanner() async {
    try {
      final isDisconnected = await platform.invokeMethod('connectScanner');
      Fluttertoast.showToast(msg: "Scanner connected: $isDisconnected");
    } on PlatformException catch (e) {
      dev.log("Failed to connect: '${e.message}'.");
    }
  }

  static Future<void> readFingerprint() async {
    try {
      await platform.invokeMethod('readFingerprint');
    } on PlatformException catch (e) {
      dev.log("Failed to read fingerprint: '${e.message}'.");
    }
  }

  static Future<void> disconnectFPScanner() async {
    try {
      final isDisconnected = await platform.invokeMethod('disconnectScanner');
      Fluttertoast.showToast(msg: "Scanner disconnected: $isDisconnected");
    } on PlatformException catch (e) {
      dev.log("Failed to disconnect: '${e.message}'.");
    }
  }

  static Future<void> getFPDeviceList({BuildContext? context}) async {
    try {
      final data =
          await platform.invokeMethod<String>('getFPDeviceList') ?? "-";
      if (context == null || !context.mounted) return;
      debugErrorDialog(data, context);
    } on PlatformException catch (e) {
      dev.log("Failed to get device list: '${e.message}'.");
    }
  }

  static Future debugErrorDialog(String data, BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Text(data),
            ));
  }

  static Future<void> disposeListener() async {
    try {
      await platform.invokeMethod('dispose');
    } on PlatformException catch (e) {
      dev.log("Failed to dispose: '${e.message}'.");
    }
  }
}
