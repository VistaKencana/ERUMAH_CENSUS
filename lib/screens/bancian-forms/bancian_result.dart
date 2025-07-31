import 'package:eperumahan_bancian/components/custom_appbar.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/config/constants/app_images.dart';
import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:eperumahan_bancian/data/hive-manager/repository/qr_navigation_pref.dart';
import 'package:flutter/material.dart';

class BancianResult extends StatefulWidget {
  final bool isVerify;
  const BancianResult({super.key, required this.isVerify});

  @override
  State<BancianResult> createState() => _BancianResultState();
}

class _BancianResultState extends State<BancianResult> {
  final blueColor = const Color(0xFF0446F3);
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        _goToSearch();
      },
      child: LayoutBuilder(builder: (context, constraint) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "Rekod",
            onPressedBack: () => _goToSearch(),
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(
                // vertical: constraint.maxHeight * .15,
                horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  AppImages.successGreen.path,
                  height: constraint.maxHeight * .2,
                  // width: constraint.maxWidth * .4,
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(height: constraint.maxHeight * .04),
                      Text("Bancian Berjaya!",
                          textAlign: TextAlign.center,
                          style: appTextStyle(size: 28)),
                      SizedBox(height: 10),
                      Text(
                        "Bancian Telah Berjaya Direkodkan",
                        textAlign: TextAlign.center,
                        style: appTextStyle(size: 18),
                      ),
                      // _listileWidget(
                      //     icon: Icons.description,
                      //     title: "Lampiran",
                      //     isChecked: context
                      //         .read<BancianBloc>()
                      //         .isLampiranSuccess),
                      // _listileWidget(
                      //     icon: Icons.fingerprint,
                      //     title: "Cap jari",
                      //     isChecked: widget.isVerify),
                      SizedBox(height: constraint.maxHeight * .2),
                      SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder()),
                              onPressed: () => _goToSearch(),
                              child: const Text("Kembali Banci"))),
                      SizedBox(height: constraint.maxHeight * .06),
                    ],
                  ),
                ),
                // Positioned(
                //   top: -(constraint.maxHeight * .12),
                //   child: const CheckIcon(),
                // ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<void> _goToSearch() async {
    final isFromHome = await QrNavigationPref.isFromHome();
    if (!mounted) return;
    if (isFromHome) {
      Navigator.popUntil(context, ModalRoute.withName(RoutesName.home));
      return;
    }
    Navigator.popUntil(context, ModalRoute.withName(RoutesName.activitySearch));
  }

  // ListTile _listileWidget(
  //     {IconData? icon, required String title, required bool isChecked}) {
  //   return ListTile(
  //     leading: icon != null ? Icon(icon) : null,
  //     contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //     title: Text(title),
  //     trailing: isChecked
  //         ? const Icon(Icons.check_circle, color: Colors.green)
  //         : const Icon(Icons.error, color: Colors.amber),
  //   );
  // }
}
