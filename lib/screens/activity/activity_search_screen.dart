import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/components/custom_appbar.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_qrscan.dart';
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
                  child: ListView.separated(
                    itemCount: 10,
                    itemBuilder: (context, index) => _newInfoTile(),
                    separatorBuilder: (context, index) =>
                        const Divider(height: 0),
                    // children: List.generate(
                    //     10,
                    //     (index) => ),
                  ),
                )),
                // ...List.generate(
                //     info.length,
                //     (index) => _infoTile(
                //         title: info[index].title, val: info[index].value)),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: List.generate(
                //       carianFilter.length,
                //       (index) => SizedBox(
                //             width: (size.width / carianFilter.length) - 16,
                //             child: CustomTextField(
                //               title: carianFilter[index],
                //               hintText: "Tulis ${carianFilter[index]}",
                //             ),
                //           )),
                // ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: ElevatedButton(
                //     onPressed: () {},
                //     child: const Text("Carian"),
                //   ),
                // ),
                // SizedBox(
                //   width: double.infinity,
                //   child: FittedBox(
                //     child: DataTableWidget(
                //       columns: const ["Bil.", "No Unit", "Status", "Tindakan"],
                //       rowLength: 7,
                //       rowGenerator: (index) {
                //         return DataTableWidget.dataRow(
                //           bil: "${index + 1}.",
                //           unit: "0$index-0$index-0$index",
                //           bilstatus: "Belum Selesai",
                //           onPressed: () => _go(const BancianMainScreen()),
                //         );
                //       },
                //     ),
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    ));
  }

  // _infoTile({required String title, required String val}) {
  //   return ListTile(
  //     contentPadding: EdgeInsets.zero,
  //     dense: true,
  //     title: Text(
  //       title,
  //       style: const TextStyle(fontSize: 14),
  //     ),
  //     trailing: Text(
  //       val,
  //       style: const TextStyle(fontSize: 14),
  //     ),
  //   );
  // }

  _newInfoTile() {
    return ListTile(
      onTap: () => _go(const BancianQrscan()),
      // onTap: () => _go(const BancianMainScreen()),
      minLeadingWidth: 0,
      leading: Container(
        decoration: BoxDecoration(
          color: AppColors.lightGrey.color,
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
      subtitle: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("01-01-01"),
          Text("Kota Damansara • Lawatan 4"),
        ],
      ),
      trailing: Chip(
        color: const WidgetStatePropertyAll(Colors.green),
        label: Text(
          "SELESAI",
          style: appTextStyle(
              size: 10, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        shape: const StadiumBorder(),
        side: BorderSide.none,
      ),
    );
  }

  _go(Widget screen) => Navigator.push(context,
      PageTransition(child: screen, type: PageTransitionType.rightToLeft));
}
