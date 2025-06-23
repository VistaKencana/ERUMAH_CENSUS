import 'dart:convert';

import 'package:eperumahan_bancian/services/app_info.dart';
import 'package:eperumahan_bancian/services/mykad_sdk/my_kad_reader.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:fluttertoast/fluttertoast.dart';

class MyKadTest extends StatefulWidget {
  const MyKadTest({super.key});

  @override
  State<MyKadTest> createState() => _MyKadTestState();
}

class _MyKadTestState extends State<MyKadTest> {
  Future addDelay({int milisec = 1500}) =>
      Future.delayed(Duration(milliseconds: milisec));
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2), // Adjust duration as needed
      ),
    );
  }

  bool isInitialize = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyKad Debugger"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _button(
                onPressed: () async {
                  debugPrint("Packahe name: ${AppInfo().packageName}");
                  if (isInitialize) {
                    showSnackBar(context, "Please dispose");
                    return;
                  }
                  await MyKadReader.callSDK(
                      license:
                          "eyJjaGFsbGFuZ2VfY29kZSI6ImZ4UURyR2RHaDQiLCJwYXlsb2FkIjoiT1Q2TU82Njk0aE9ZelJBWjliM3FVRDlzR1dZVkJUemdLbUdPS0I3SHBsM3dCZ21JM29CZWtDWUt1cklrQURMemFKR1dzR05YT3RDcjVpYURkakRRekViWE9nK3pOU3hrSVhERkdwKy9Jb2NNdG1rK0FKSnZZbStiSlRGZ09NZEhUSkZsL3hRakcvYXNwYlhDUk1LZTJOeTRrcEd3T2kxQlNPTks0MkFFaG53PSIsInNpZ25hdHVyZSI6Ik1FUUNJR3JYcSsxN3k1ZzQwdGJqUkYrM0xGMGRBWnk5dFZZYkI0SmZOOUNHdVpHd0FpQlJPdno5L0s1TkxFMDdPakQ1eXZrRjNyOUVYVFFvM3g0Q0JXRyt2Wm5lbGc9PSIsInZlcnNpb24iOjF9");
                  setState(() => isInitialize = true);
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
                      setMessage(msg: "Read card successful");
                      // if (verifyFP) {
                      //   await MyKadReader.turnOnFP();
                      //   await addDelay(milisec: 2500);
                      //   setMessage(msg: "Initialize Fingerprint Hardware...");
                      //   await MyKadReader.getFPDeviceList();
                      //   await addDelay(milisec: 2000);
                      //   await connectAndScanFP();
                      // }
                    },
                    onErrorCard: () {
                      //Remove card and try again
                      setMessage(msg: "Remove card and try again");
                    },
                    onVerifyFP: () {
                      //Verifying Fingerprint
                      setMessage(
                          msg: "Please place your fingerprint at the scanner");
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
                },
                title: "Initiate SDK"),
            _button(
                onPressed: () async {
                  if (!isInitialize) {
                    showSnackBar(context, "Please Initialize");
                    return;
                  }
                  await MyKadReader.disconnectFPScanner();
                  await addDelay();
                  await MyKadReader.turnOffFP();
                  await addDelay();
                  await MyKadReader.disposeListener();
                  setState(() => isInitialize = false);
                },
                title: "Dispose SDK"),
            _button(
                onPressed: () {
                  close();
                },
                title: "Restart SDK")
          ],
        ),
      ),
    );
  }

  _button({required void Function()? onPressed, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ElevatedButton(onPressed: onPressed, child: Text(title)),
    );
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

  setMessage({required String msg}) {
    dev.log(msg);
    Fluttertoast.showToast(msg: msg);
  }

  void setMyKadData(SdkResponseModel? data) {
    if (data == null) {
      return;
    }
    final json = jsonDecode(data.data!);
    String icNO = "";
    if (data.isDataMykad()) {
      icNO = MyKadModel.fromJson(json).icNo ?? "";
    } else {
      icNO = MyKidModel.fromJson(json).icNo ?? "";
    }
    setMessage(msg: icNO);
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

  // Close the StreamController
  Future<void> close() async {
    setMyKadData(null);
    await MyKadReader.disconnectFPScanner();
    await addDelay();
    await MyKadReader.turnOffFP();
    await addDelay();
    await MyKadReader.disposeListener();
  }
}
