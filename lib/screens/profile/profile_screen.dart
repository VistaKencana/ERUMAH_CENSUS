import 'package:eperumahan_bancian/components/transition_appbar.dart';
import 'package:eperumahan_bancian/screens/profile/profile_change_pwd_screen.dart';
import 'package:eperumahan_bancian/screens/profile/profile_update_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/custom_alertdialog.dart';
import '../../config/routes/routes_name.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(headerSliverBuilder: (context, innerScroll) {
        return [
          SliverOverlapAbsorber(
            //To avoid extra scrolling Absorber & Injector
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: TransitionAppBar(
              onEdit: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const ProfileUpdateScreen(),
                        type: PageTransitionType.rightToLeft));
              },
              delegate: TemparoryDelegate(),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200),
                child: const Icon(
                  Icons.person,
                ),
              ),
              name: "Ahmad Hazim",
            ),
          ),
        ];
      }, body: Builder(builder: (context) {
        return CustomScrollView(slivers: [
          SliverOverlapInjector(
            //To avoid extra scrolling Absorber & Injector
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tetapan",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  _profileTile(
                    icon: Icons.power_settings_new,
                    title: "Log Keluar",
                    onTap: () {
                      _showLogoutAlert();
                    },
                  ),
                ],
              ),
            ),
          ]))
        ]);
      })),
    );
  }

  _profileTile(
      {required String title,
      required IconData icon,
      required void Function() onTap}) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      leading: Icon(icon),
      tileColor: Colors.grey.shade200,
      trailing: const Icon(Icons.chevron_right),
      contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  _showLogoutAlert() async {
    return await CustomAlertDialog(
      position: AlertBtnPosition.leftRignt,
      title: "Logout",
      subtitle: "You will be logout from this app",
      colorBtnLabel: "Logout",
      dimmedBtnLabel: "Cancel",
      onDimmedBtn: () => Navigator.pop(context),
      onColorBtn: () =>
          Navigator.popUntil(context, ModalRoute.withName(RoutesName.login)),
    ).show(context);
  }
}
