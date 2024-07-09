import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/components/custom_appbar.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/screens/activity/bancian_info_modal.dart';
import 'package:flutter/material.dart';
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
      appBar: CustomAppBar(
        title: "Carian",
        centerTitle: false,
        foregroundColor: AppColors.primary.color,
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Info Kawasan Bancian",
                  style: appTextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.dimmedPurple.color),
                ),
                Text(
                  info[1].value,
                  style: appTextStyle(fontWeight: FontWeight.bold, size: 25),
                ),
                Text(
                  "${info[0].value} • ${info[2].title} ${info[2].value} • ${info[3].title} ${info[3].value}",
                  style: appTextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                      "${info[4].title} ${info[4].value}",
                      style: appTextStyle(fontWeight: FontWeight.bold),
                    )),
                    Expanded(
                        child: Text(
                      "${info[5].title} ${info[5].value}",
                      style: appTextStyle(fontWeight: FontWeight.bold),
                    )),
                  ],
                )
              ],
            ),
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

  _newInfoTile({required int lawatan, bool isComplete = true}) {
    return ListTile(
      onTap: () => const BancianInfosModal().show(context),
      // onTap: () => _go(const BancianQrscan()),
      // onTap: () => _go(const BancianMainScreen()),
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

  // _go(Widget screen) => Navigator.push(context,
  //     PageTransition(child: screen, type: PageTransitionType.rightToLeft));
}
