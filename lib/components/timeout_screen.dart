import 'package:eperumahan_bancian/components/custom_alertdialog.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/config/constants/app_images.dart';
import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:eperumahan_bancian/data/hive-manager/repository/login_pref.dart';
import 'package:eperumahan_bancian/screens/login/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_textfield.dart';
import 'validator.dart';

class TimeoutScreen extends StatefulWidget {
  const TimeoutScreen({super.key});

  @override
  State<TimeoutScreen> createState() => _TimeoutScreenState();
}

class _TimeoutScreenState extends State<TimeoutScreen> {
  final userIdCtrl = TextEditingController();
  final pwdCtrl = TextEditingController(text: "123456");
  final _formKey = GlobalKey<FormState>();

  void _alertDialog() {
    CustomAlertDialog(
      title: 'Hentikan bancian?',
      subtitle: "Jika anda tekan 'Okay' anda akan kembali ke Log Masuk",
      colorBtnLabel: 'Okay',
      barrierDismissible: true,
      onColorBtn: () =>
          Navigator.popUntil(context, ModalRoute.withName(RoutesName.login)),
      dimmedBtnLabel: "Kembali",
      onDimmedBtn: () {
        Navigator.pop(context);
      },
    ).show(context);
  }

  @override
  void initState() {
    super.initState();
    userIdCtrl.text = LoginPreference().getUserId() ?? "CU001";
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _alertDialog();
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                onPressed: () {
                  _alertDialog();
                },
                icon: const Icon(Icons.close)),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text(
                  "Session Timeout",
                  style: appTextStyle(fontWeight: FontWeight.w600, size: 22),
                ),
                const SizedBox(height: 20),
                Center(
                  child: AspectRatio(
                      aspectRatio: 36 / 9,
                      child: Image.asset(AppImages.noConnection.path)),
                ),
                const SizedBox(height: 20),
                Text(
                  "Sila log semula untuk teruskan bancian anda",
                  textAlign: TextAlign.center,
                  style: appTextStyle(fontWeight: FontWeight.w600, size: 20),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: "ID Pengguna:",
                  controller: userIdCtrl,
                  titleStyle: appTextStyle(fontWeight: FontWeight.w600),
                  hintText: "Tulis id pengguna disini",
                  validator: (value) => Validator.validateText(value,
                      err: "Sila isi ID Pengguna"),
                  readOnly: true,
                  enabled: false,
                  addBorder: false,
                  style: const TextStyle(color: Colors.grey),
                  prefixWidget: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      AppImages.icId.path,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  title: "Kata Laluan:",
                  controller: pwdCtrl,
                  hintText: "Tulis kata laluan disini",
                  obscureText: true,
                  validator: (value) => Validator.validatePassword(value,
                      length: 6, err: "Sila isi kata laluan"),
                  titleStyle: appTextStyle(fontWeight: FontWeight.w600),
                  prefixWidget: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      AppImages.icLock.path,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (!_formKey.currentState!.validate()) return;
                        context.read<AuthBloc>().add(
                              UserLoginTimeout(
                                  userCode: userIdCtrl.text, pwd: pwdCtrl.text),
                            );
                      },
                      child: Text(
                        "Log Masuk",
                        style: appTextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
