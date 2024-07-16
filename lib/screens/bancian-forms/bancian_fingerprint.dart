import 'package:eperumahan_bancian/components/blinking_text.dart';
import 'package:eperumahan_bancian/components/custom_appbar.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_constants.dart';
import 'package:flutter/material.dart';

import '../../config/constants/app_colors.dart';

class BancianFingerprint extends StatefulWidget {
  const BancianFingerprint({super.key});

  @override
  State<BancianFingerprint> createState() => _BancianFingerprintState();
}

class _BancianFingerprintState extends State<BancianFingerprint> {
  ReaderStatus cardStatus = ReaderStatus.insert;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "MyKad Reader",
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: constraint.maxWidth * .1,
                vertical: constraint.maxHeight * .04),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: constraint.maxHeight * .12),
                  cardStatus.isLoading
                      ? Padding(
                          padding:
                              EdgeInsets.only(top: constraint.maxHeight * .1),
                          child: const CircularProgressIndicator(),
                        )
                      : FittedBox(
                          child: Image.asset(
                            cardStatus.imgSrc,
                            fit: BoxFit.contain,
                            height: constraint.maxHeight * .3,
                            width: constraint.maxWidth * .8,
                          ),
                        ),
                  SizedBox(height: constraint.maxHeight * .04),
                  cardStatus.isNotBlink
                      ? Text(
                          cardStatus.title,
                          textAlign: TextAlign.center,
                          style: appTextStyle(
                              size: 24, fontWeight: FontWeight.w700),
                        )
                      : BlinkingText(
                          cardStatus.title,
                          textAlign: TextAlign.center,
                          style: appTextStyle(
                              size: 24, fontWeight: FontWeight.w700),
                        ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
