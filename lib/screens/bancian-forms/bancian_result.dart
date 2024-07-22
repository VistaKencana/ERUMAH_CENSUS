import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/components/check_icon.dart';
import 'package:eperumahan_bancian/components/custom_appbar.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:eperumahan_bancian/data/hive-manager/repository/qr_navigation_pref.dart';
import 'package:flutter/material.dart';

class BancianResult extends StatefulWidget {
  const BancianResult({super.key});

  @override
  State<BancianResult> createState() => _BancianResultState();
}

class _BancianResultState extends State<BancianResult> {
  final blueColor = const Color(0xFF0446F3);
  @override
  Widget build(BuildContext context) {
    return BgImage(
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return;
          _goToSearch();
        },
        child: SafeArea(
          child: LayoutBuilder(builder: (context, constraint) {
            return Scaffold(
              appBar: CustomAppBar(
                title: "Rekod",
                onPressedBack: () => _goToSearch(),
              ),
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    vertical: constraint.maxHeight * .15,
                    horizontal: constraint.maxWidth * .06),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          SizedBox(height: constraint.maxHeight * .11),
                          Text("Berjaya!",
                              style: appTextStyle(color: blueColor, size: 25)),
                          Text(
                            "Bancian Telah Berjaya Dilakukan",
                            textAlign: TextAlign.center,
                            style: appTextStyle(size: 18),
                          ),
                          SizedBox(height: constraint.maxHeight * .02),
                          _listileWidget(
                              icon: Icons.description,
                              title: "Lampiran",
                              isChecked: true),
                          _listileWidget(
                              icon: Icons.fingerprint,
                              title: "Cap jari",
                              isChecked: false),
                          SizedBox(height: constraint.maxHeight * .04),
                          SizedBox(
                              height: 48,
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () => _goToSearch(),
                                  child: const Text("Kembali "))),
                          SizedBox(height: constraint.maxHeight * .02),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -(constraint.maxHeight * .12),
                      child: const CheckIcon(),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  _goToSearch() async {
    final isFromHome = await QrNavigationPref.isFromHome();
    if (!mounted) return;
    if (isFromHome) {
      Navigator.popUntil(context, ModalRoute.withName(RoutesName.home));
      return;
    }
    Navigator.popUntil(context, ModalRoute.withName(RoutesName.activitySearch));
  }

  _listileWidget(
      {IconData? icon, required String title, required bool isChecked}) {
    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      title: Text(title),
      trailing: isChecked
          ? const Icon(Icons.check_circle, color: Colors.green)
          : const Icon(Icons.error, color: Colors.amber),
    );
  }
}
