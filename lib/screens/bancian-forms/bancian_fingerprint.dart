import 'package:eperumahan_bancian/components/blinking_text.dart';
import 'package:eperumahan_bancian/components/custom_appbar.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_constants.dart';
import 'package:eperumahan_bancian/services/mykad_sdk/my_kad_controller.dart';
import 'package:eperumahan_bancian/services/mykad_sdk/my_kad_widget.dart';
import 'package:flutter/material.dart';

class BancianFingerprint extends StatefulWidget {
  final void Function(bool) onVerifyFP;
  const BancianFingerprint({super.key, required this.onVerifyFP});

  @override
  State<BancianFingerprint> createState() => _BancianFingerprintState();
}

class _BancianFingerprintState extends State<BancianFingerprint>
    with WidgetsBindingObserver {
  final MyKadController myKadController = MyKadController();
  @override
  void initState() {
    super.initState();
    myKadController.init(verifyFP: true, context: context);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      myKadController.close();
    }
  }

  @override
  void dispose() {
    myKadController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "MyKad Reader",
        onPressedBack: () {
          showLoading(context);
          myKadController.close().then((val) {
            Navigator.pop(context);
            Navigator.pop(context);
          });
        },
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: Column(
            children: [
              MyKadWidget(
                controller: myKadController,
                onCardSuccess: (val) {},
                onVerifyFP: (val) {
                  if (!val) return;
                  Future.delayed(const Duration(milliseconds: 800), () {
                    widget.onVerifyFP(val);
                    Navigator.pop(context);
                  });
                },
                builder: (context, msg) {
                  final readerStatus = ReaderStatus.queryStatus(msg);

                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: constraint.maxHeight * .12),
                        readerStatus.isLoading
                            ? Padding(
                                padding: EdgeInsets.only(
                                    top: constraint.maxHeight * .1),
                                child: const CircularProgressIndicator(),
                              )
                            : FittedBox(
                                child: Image.asset(
                                  readerStatus.imgSrc,
                                  fit: BoxFit.contain,
                                  height: constraint.maxHeight * .3,
                                  width: constraint.maxWidth * .8,
                                ),
                              ),
                        SizedBox(height: constraint.maxHeight * .04),
                        readerStatus.isNotBlink
                            ? Text(
                                readerStatus.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w700),
                              )
                            : BlinkingText(
                                readerStatus.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w700),
                              ),
                        Visibility(
                            visible: readerStatus.showTryAgain,
                            child: ElevatedButton(
                                onPressed: myKadController.tryAgain,
                                child: const Text("Try Again")))
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        );
      }),
    );
  }

  Future<dynamic> showLoading(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (context) => PopScope(
        canPop: false,
        onPopInvoked: (val) async {},
        child: GestureDetector(
          onTap: () {},
          child: Material(
              color: Colors.black.withOpacity(0.6),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 100,
                    width: 100,
                    padding: const EdgeInsets.all(15),
                    color: Colors.white,
                    child: const CircularProgressIndicator(),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
