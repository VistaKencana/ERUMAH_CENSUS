import 'package:eperumahan_bancian/components/custom_appbar.dart';
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

import '../../components/bg_image.dart';
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
          EasyLoading.dismiss()
              .then((val) => Navigator.pushNamed(context, RoutesName.home));
        } else if (state is AuthTimeoutSuccess) {
          EasyLoading.dismiss().then((val) => Navigator.pop(context));
        } else if (state is AuthLoginError) {
          EasyLoading.dismiss();
          CustomFlushbar.of(context).showFailed(msg: state.msg);
        }
      },
      child: Form(
        key: _formKey,
        child: BgImage(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const CustomAppBar(title: ""),
            body: SafeArea(
              child: LayoutBuilder(builder: (context, constraint) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: constraint.maxWidth * .08,
                      vertical: constraint.maxHeight * .04),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppImages.dbklLogo.path,
                        fit: BoxFit.contain,
                        height: constraint.maxHeight * .1,
                        width: constraint.maxWidth * .15,
                      ),
                      // Text(
                      //   "Selamat Datang",
                      //   style:
                      //       appTextStyle(size: 20, fontWeight: FontWeight.w600),
                      // ),

                      SizedBox(height: constraint.maxHeight * .1),
                      Text(
                        "Selamat Datang",
                        style: appTextStyle(
                            color: AppColors.primary.color,
                            size: 30.sp,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "DEWAN BANDARAYA KUALA LUMPUR",
                        style: appTextStyle(fontWeight: FontWeight.w600),
                      ),
                      // SizedBox(height: constraint.maxHeight * .03),
                      // AspectRatio(
                      //   aspectRatio: 16 / 1.5,
                      //   child: Image.asset(
                      //     AppImages.icLogMasuk.path,
                      //   ),
                      // ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        title: "ID Pengguna:",
                        controller: userIdCtrl,
                        titleStyle: appTextStyle(fontWeight: FontWeight.w600),
                        hintText: "Tulis id pengguna disini",
                        validator: (value) => Validator.validateText(value,
                            err: "Sila isi ID Pengguna"),
                        prefixIcon: Icons.person,
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
                        prefixIcon: Icons.key,
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
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (!_formKey.currentState!.validate()) return;
                              context.read<AuthBloc>().add(
                                    UserLogin(
                                        userCode: userIdCtrl.text,
                                        pwd: pwdCtrl.text),
                                  );
                            },
                            child: Text(
                              "Log Masuk",
                              style: appTextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )),
                      ),
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
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
