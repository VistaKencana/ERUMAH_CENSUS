import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../components/custom_textfield.dart';
import '../../config/constants/app_images.dart';
import '../../config/routes/routes_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Selamat Datang",
                style: appTextStyle(size: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15),
              Image.asset(
                AppImages.dbklLogo.path,
                width: 181,
                height: 231,
              ),
              const SizedBox(height: 25),
              Text(
                "E-PERUMAHAN",
                style: appTextStyle(size: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 2),
              Text(
                "DEWAN BANDARAYA KUALA LUMPUR",
                style: appTextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 35),
              Image.asset(
                AppImages.icLogMasuk.path,
                width: 172,
                height: 48,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                title: "ID Pengguna:",
                titleStyle: appTextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                title: "Kata Laluan:",
                obscureText: true,
                titleStyle: appTextStyle(fontWeight: FontWeight.w600),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Lupa Kata Laluan?',
                    textAlign: TextAlign.left,
                    style: appTextStyle(
                        size: 15,
                        fontWeight: FontWeight.w500,
                        color: const Color(0XFF1488CC)),
                  )),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                    onPressed: () async {
                      EasyLoading.show();
                      Future.delayed(
                          const Duration(seconds: 1),
                          () => EasyLoading.dismiss().then((val) =>
                              Navigator.pushNamed(context, RoutesName.home)));
                    },
                    child: Text(
                      "Log Masuk",
                      style: appTextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    )),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
