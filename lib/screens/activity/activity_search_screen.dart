import 'package:eperumahan_bancian/components/activity_appbar.dart';
import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/data/hive-manager/repository/qr_navigation_pref.dart';
import 'package:eperumahan_bancian/screens/qr-home/qrscan_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'model/bancian_info.dart';

class ActivitySearchScreen extends StatefulWidget {
  const ActivitySearchScreen({super.key});

  @override
  State<ActivitySearchScreen> createState() => _ActivitySearchScreenState();
}

class _ActivitySearchScreenState extends State<ActivitySearchScreen> {
  final info = BancianInfo.getExampleData();
  final carianFilter = ["Status", "Blok", "Tingkat", "Unit"];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BgImage(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: ActivityAppbar(
        title: info[1].value,
        centerTitle: false,
        foregroundColor: AppColors.primary.color,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 20),
            child: Text(
              "Info Kawasan Bancian",
              style: appTextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Row(
            children: [
              _infoContainer(val: info[4].value, title: info[4].title),
              _infoContainer(val: info[5].value, title: info[5].title),
            ],
          ),
          Container(
            height: size.height * 0.55,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 14),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Senarai unit bancian",
                        style:
                            appTextStyle(fontWeight: FontWeight.bold, size: 25),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.lightGrey.color,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(Icons.search),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Scrollbar(
                      child: ListView(
                    children: [
                      _newInfoTile(lawatan: 1, isComplete: false),
                      _newInfoTile(lawatan: 2, isComplete: true),
                      _newInfoTile(lawatan: 3, isComplete: true),
                      _newInfoTile(lawatan: 1, isComplete: false),
                      _newInfoTile(lawatan: 2, isComplete: true),
                      _newInfoTile(lawatan: 2, isComplete: true),
                    ],
                  )),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  _infoContainer({required String val, required String title}) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .44,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            val,
            style: appTextStyle(size: 22, fontWeight: FontWeight.bold),
          ),
          Text(title),
        ],
      ),
    );
  }

  _newInfoTile({required int lawatan, bool isComplete = true}) {
    return ListTile(
      onTap: () {
        QrNavigationPref.setFromHome(val: false)
            .then((val) => _goTo(const QrScanScreen(isFromHome: false)));
      },
      // onTap: () => const BancianInfosModal().show(context),
      minLeadingWidth: 0,
      leading: Container(
        decoration: BoxDecoration(
          color: AppColors.midGrey.color,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 4),
        child: const Icon(Icons.location_on),
      ),
      contentPadding: EdgeInsets.zero,
      isThreeLine: true,
      dense: true,
      title: const Text("NOMBOR UNIT"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("01-01-01"),
          Text("Kota Damansara • Lawatan $lawatan"),
        ],
      ),
      trailing: Chip(
        color: WidgetStatePropertyAll(isComplete ? Colors.green : Colors.amber),
        label: Text(
          isComplete ? "SELESAI" : "BELUM DIBANCI",
          style: appTextStyle(
              size: 10, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        shape: const StadiumBorder(),
        side: BorderSide.none,
      ),
    );
  }

  _goTo(Widget screen) => Navigator.push(context,
      PageTransition(child: screen, type: PageTransitionType.rightToLeft));
}
