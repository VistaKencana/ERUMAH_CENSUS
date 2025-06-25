import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/data/hive-manager/repository/login_pref.dart';
import 'package:eperumahan_bancian/screens/login/bloc/auth_bloc.dart';
import 'package:eperumahan_bancian/screens/profile/profile_change_pwd_screen.dart';
import 'package:eperumahan_bancian/screens/profile/profile_update_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/custom_alertdialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              color: AppColors.primary.color,
              height: constraint.maxHeight * .24,
              width: double.infinity,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.pop(context);
                    //     },
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //         color: AppColors.midGrey.color,
                    //         shape: BoxShape.circle,
                    //       ),
                    //       padding: const EdgeInsets.all(10),
                    //       child: const Icon(
                    //         Icons.close,
                    //         size: 20,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Text(
                      "Selamat datang",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: Colors.white),
                    ),
                    Text(
                      LoginPreference().getUsername() ?? "-",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28.sp,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(18),
              width: double.infinity,
              color: Colors.grey.shade200,
              child: Text(
                "Tetapan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                ),
              ),
            ),
            _profileTile(
              icon: Icons.person_outline,
              title: "Maklumat Akaun",
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const ProfileUpdateScreen(),
                        type: PageTransitionType.bottomToTop));
              },
            ),
            _profileTile(
              icon: Icons.lock_outline_rounded,
              title: "Ubah Kata Laluan",
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const ProfileChangePwdScreen(),
                        type: PageTransitionType.rightToLeft));
              },
            ),
            SizedBox(height: constraint.maxHeight * .3),
            TextButton(
                onPressed: () {
                  _showLogoutAlert();
                },
                child: Text('Log keluar',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp,
                    )))
          ],
        ),
      ));
    });
  }

  ListTile _profileTile(
      {required String title,
      required IconData icon,
      required void Function() onTap}) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      leading: Icon(icon),
      // tileColor: Colors.grey.shade200,
      trailing: const Icon(Icons.chevron_right),
      contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Future _showLogoutAlert() async {
    return await CustomAlertDialog(
      position: AlertBtnPosition.leftRignt,
      title: "Logout",
      subtitle: "You will be logout from this app",
      colorBtnLabel: "Logout",
      dimmedBtnLabel: "Cancel",
      onDimmedBtn: () => Navigator.pop(context),
      onColorBtn: () => context.read<AuthBloc>().add(UserLogout()),
    ).show(context);
  }
}
