import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/components/custom_appbar.dart';
import 'package:eperumahan_bancian/components/custom_textfield.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/services/flushbar/custom_flushbar.dart';
import 'package:flutter/material.dart';

class ProfileChangePwdScreen extends StatefulWidget {
  const ProfileChangePwdScreen({super.key});

  @override
  State<ProfileChangePwdScreen> createState() => _ProfileChangePwdScreenState();
}

class _ProfileChangePwdScreenState extends State<ProfileChangePwdScreen> {
  String title = "Ubah Kata Laluan";
  String subtitle = "Masukkan kata laluan yang dikaitkan dengan akaun anda";
  @override
  Widget build(BuildContext context) {
    return BgImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(title: "Ubah Kata Laluan"),
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
              const CustomTextField(title: "Kata laluan Lama"),
              const SizedBox(height: 14),
              const CustomTextField(title: "Kata laluan Baharu"),
              const SizedBox(height: 14),
              SizedBox(
                  height: 50,
                  width: double.maxFinite,
                  child: ElevatedButton(
                      onPressed: () {
                        CustomFlushbar.of(context)
                            .showSuccess(msg: "Kata laluan berjaya diubah");
                      },
                      child: const Text("Ubah Kata Laluan")))
            ],
          ),
        ),
      ),
    );
  }
}
