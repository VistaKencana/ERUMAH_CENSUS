import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/components/custom_appbar.dart';
import 'package:eperumahan_bancian/components/custom_textfield.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/custom_data_table.dart';
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
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sila Pilih Kawasan Bancian",
                  style:
                      TextStyle(fontSize: 20, color: AppColors.primary.color),
                ),
                ...List.generate(
                    info.length,
                    (index) => _infoTile(
                        title: info[index].title, val: info[index].value)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      carianFilter.length,
                      (index) => SizedBox(
                            width: (size.width / carianFilter.length) - 16,
                            child: CustomTextField(
                              title: carianFilter[index],
                              hintText: "Tulis ${carianFilter[index]}",
                            ),
                          )),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Carian"),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: FittedBox(
                    child: DataTableWidget(
                      columns: const ["Bil.", "No Unit", "Status", "Tindakan"],
                      rowLength: 7,
                      rowGenerator: (index) {
                        return DataTableWidget.dataRow(
                          bil: "${index + 1}.",
                          unit: "0$index-0$index-0$index",
                          bilstatus: "Belum Selesai",
                          onPressed: () => _go(const BancianMainScreen()),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  _infoTile({required String title, required String val}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      title: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
      trailing: Text(
        val,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  _go(Widget screen) => Navigator.push(context,
      PageTransition(child: screen, type: PageTransitionType.rightToLeft));
}
