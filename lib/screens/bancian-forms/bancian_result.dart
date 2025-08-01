import 'package:eperumahan_bancian/components/check_icon.dart';
import 'package:eperumahan_bancian/components/custom_appbar.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
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
                horizontal: constraint.maxWidth * .06, vertical: 20),
            child: Column(
              children: [
                SizedBox(height: constraint.maxHeight * .09),
                CheckIcon(color: Colors.green),
                SizedBox(height: constraint.maxHeight * .02),
                Text("Berjaya!", style: appTextStyle(size: 25)),

                Text(
                  "Bancian Telah Berjaya Dilakukan",
                  textAlign: TextAlign.center,
                  style: appTextStyle(size: 18),
                ),
                SizedBox(height: constraint.maxHeight * .02), Spacer(),
                // _listileWidget(
                //     icon: Icons.description,
                //     title: "Lampiran",
                //     isChecked:
                //         context.read<BancianBloc>().isLampiranSuccess),
                // _listileWidget(
                //     icon: Icons.fingerprint,
                //     title: "Cap jari",
                //     isChecked: widget.isVerify),
                // SizedBox(height: constraint.maxHeight * .04),

                SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () => _goToSearch(),
                        child: const Text("Teruskan Bancian"))),
                SizedBox(height: constraint.maxHeight * .02),
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

  ListTile listileWidget(
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
