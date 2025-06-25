import 'package:eperumahan_bancian/components/validator.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/screens/login/bloc/auth_bloc.dart';
import 'package:eperumahan_bancian/screens/password/forget_password_screen.dart';
import 'package:eperumahan_bancian/services/flushbar/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/custom_textfield.dart';
import '../../config/constants/app_images.dart';
import '../../config/routes/routes_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userIdCtrl = TextEditingController(text: "CU001");
  final pwdCtrl = TextEditingController(text: "123456");
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginLoading) {
          EasyLoading.show();
        } else if (state is AuthLoginSuccess) {
          EasyLoading.dismiss().then((val) =>
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, RoutesName.home));
        } else if (state is AuthTimeoutSuccess) {
          // ignore: use_build_context_synchronously
          EasyLoading.dismiss().then((val) => Navigator.pop(context));
        } else if (state is AuthLoginError) {
          EasyLoading.dismiss();
          CustomFlushbar.of(context).showFailed(msg: state.msg);
        }
      },
      child: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.splash.path), fit: BoxFit.cover),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: LayoutBuilder(builder: (context, constraint) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: constraint.maxWidth * .2,
                        child: AspectRatio(
                          aspectRatio: 8 / 9,
                          child: Image.asset(
                            AppImages.dbklLogo.path,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: constraint.maxHeight * .04),
                      Text(
                        "PENGURUSAN PERUMAHAN",
                        style: appTextStyle(
                            size: 30.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "DEWAN BANDARAYA KUALA LUMPUR",
                        style: appTextStyle(
                            fontWeight: FontWeight.w400, color: Colors.white),
                      ),
                      SizedBox(height: constraint.maxHeight * .08),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                            onPressed: () async {
                              showLogin();
                            },
                            child: Text(
                              "Log Masuk",
                              style: appTextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )),
                      ),
                      SizedBox(height: constraint.maxHeight * .1),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  void showLogin() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.85,
          widthFactor: 1.0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 45,
                  child: AspectRatio(
                    aspectRatio: 8 / 9,
                    child: Image.asset(
                      AppImages.dbklLogo.path,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Log Masuk",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  title: "ID Staff:",
                  controller: userIdCtrl,
                  titleStyle: appTextStyle(fontWeight: FontWeight.w600),
                  hintText: "Tulis id pengguna disini",
                  validator: (value) =>
                      Validator.validateText(value, err: "Sila isi ID Staff"),
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: const ForgetPasswordScreen(),
                                type: PageTransitionType.rightToLeft));
                      },
                      style: TextButton.styleFrom(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        'Lupa Kata Laluan?',
                        textAlign: TextAlign.left,
                        style: appTextStyle(
                            size: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color(0XFF1488CC)),
                      )),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (!_formKey.currentState!.validate()) return;
                        context.read<AuthBloc>().add(
                              UserLogin(
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
        );
      },
    );
  }

  Widget loginForm() {
    return Column(
      children: [
        const SizedBox(height: 10),
        CustomTextField(
          title: "ID Pengguna:",
          controller: userIdCtrl,
          titleStyle: appTextStyle(fontWeight: FontWeight.w600),
          hintText: "Tulis id pengguna disini",
          validator: (value) =>
              Validator.validateText(value, err: "Sila isi ID Pengguna"),
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
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const ForgetPasswordScreen(),
                        type: PageTransitionType.rightToLeft));
              },
              style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.zero,
              ),
              child: Text(
                'Lupa Kata Laluan?',
                textAlign: TextAlign.left,
                style: appTextStyle(
                    size: 15,
                    fontWeight: FontWeight.w500,
                    color: const Color(0XFF1488CC)),
              )),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget testingSdk() {
    return const Column(
      children: [
        // ElevatedButton(
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (_) => const MyKadTest()));
        //     },
        //     child: const Text("Debug SDK"))
        // TextButton(
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           PageTransition(
        //               child: const RegisterScreen(),
        //               type: PageTransitionType.rightToLeft));
        //     },
        //     style: TextButton.styleFrom(
        //       alignment: Alignment.centerLeft,
        //       padding: EdgeInsets.zero,
        //     ),
        //     child: Text(
        //       'Daftar Akaun',
        //       textAlign: TextAlign.left,
        //       style: appTextStyle(
        //           size: 15,
        //           fontWeight: FontWeight.w500,
        //           color: const Color(0XFF1488CC)),
        //     )),
      ],
    );
  }
}
