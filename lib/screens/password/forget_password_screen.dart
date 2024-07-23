import 'package:eperumahan_bancian/components/custom_appbar.dart';
import 'package:eperumahan_bancian/components/custom_textfield.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/services/flushbar/custom_flushbar.dart';
import 'package:flutter/material.dart';

import '../../components/bg_image.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  String title = "Tukar Kata Laluan";
  String subtitle =
      "Masukkan e-mel yang dikaitkan dengan akaun anda dan kami akan menghantar e-mel kepada anda dengan arahan untuk menetapkan semula kata laluan anda";
  @override
  Widget build(BuildContext context) {
    return BgImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(title: "Lupa Kata Laluan"),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: appTextStyle(fontWeight: FontWeight.bold, size: 24),
              ),
              const SizedBox(height: 4),
              Text(subtitle),
              const SizedBox(height: 18),
              const CustomTextField(title: "Alamat Emel"),
              const SizedBox(height: 14),
              SizedBox(
                  height: 50,
                  width: double.maxFinite,
                  child: ElevatedButton(
                      onPressed: () {
                        CustomFlushbar.of(context)
                            .showSuccess(msg: "Emel telah berjaya dihantar");
                      },
                      child: const Text("Hantar ")))
            ],
          ),
        ),
      ),
    );
  }
}
