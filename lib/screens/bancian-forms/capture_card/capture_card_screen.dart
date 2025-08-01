import 'dart:typed_data';

import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/config/constants/app_images.dart';
import 'package:eperumahan_bancian/services/flushbar/custom_flushbar.dart';
import 'package:flutter/material.dart';

import '../../../components/card_display.dart';

class CaptureCardScreen extends StatefulWidget {
  final void Function(Uint8List frontCard, Uint8List backCard) onNext;
  const CaptureCardScreen({super.key, required this.onNext});

  @override
  State<CaptureCardScreen> createState() => _CaptureCardScreenState();
}

class _CaptureCardScreenState extends State<CaptureCardScreen> {
  final pCtrl = PageController(initialPage: 1);
  Uint8List? frontCard, backCard;
  @override
  void dispose() {
    pCtrl.dispose();
    super.dispose();
  }

  void _animateToNextPage() {
    pCtrl.animateToPage(
      1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pCtrl,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _landingCapture(),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text("Imbas MyKad"),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * .08),
                CardDisplay(
                  title: "K.P Depan",
                  width: MediaQuery.sizeOf(context).width * .8,
                  height: MediaQuery.sizeOf(context).height * .2,
                  img: frontCard,
                  onPicture: (bytes) {
                    if (bytes == null) return;
                    setState(() => frontCard = bytes);
                    // widget.onFrontCard(bytes);
                  },
                ),
                const SizedBox(height: 25),
                CardDisplay(
                  title: "K.P Belakang",
                  width: MediaQuery.sizeOf(context).width * .8,
                  height: MediaQuery.sizeOf(context).height * .2,
                  img: backCard,
                  onPicture: (bytes) {
                    if (bytes == null) return;
                    setState(() => backCard = bytes);
                    // widget.onBackCard(bytes);
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomBarButton(
              onTap: () {
                if (frontCard == null || backCard == null) {
                  CustomFlushbar.of(context)
                      .showWarning(msg: "Sila ambil kedua-dua gambar kad");
                  return;
                }
                widget.onNext(frontCard!, backCard!);
              },
              title: "Selesai"),
        )
      ],
    );
  }

  Widget _landingCapture() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Imbas MyKad"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * .08),
            Center(
              child: AspectRatio(
                  aspectRatio: 12 / 9,
                  child: Image.asset(AppImages.captureCard.path)),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * .06),
            const Text(
              "Pengesahan MyKad",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            const Text("Sila ambil gambar mykad"),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: _animateToNextPage,
                    child: const Text("Teruskan")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
