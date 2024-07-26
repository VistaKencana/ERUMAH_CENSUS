import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/qr/bancian_qrscan.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../config/constants/app_colors.dart';
import '../../data/hive-manager/repository/qr_navigation_pref.dart';

class BancianInfosModal extends StatefulWidget {
  const BancianInfosModal({super.key});

  Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      isScrollControlled: true,
      builder: (_) => this,
    );
  }

  @override
  State<BancianInfosModal> createState() => _BancianInfosModalState();
}

class _BancianInfosModalState extends State<BancianInfosModal> {
  String currValue = "Bancian Biasa";
  List<String> statusFilter = [
    "Bancian Biasa",
    "Tiada Penghuni",
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.7,
      builder: (context, sc) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12, top: 28, bottom: 10),
                  child: Text(
                    'Info Unit Bancian',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 5),
                  child: Text(
                    'REKOD BANCIAN',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey[600]),
                  ),
                ),
                LayoutBuilder(builder: (context, constraint) {
                  final cWidth = constraint.maxWidth;
                  return Stack(
                    children: [
                      Positioned(
                        left: cWidth * 0.05,
                        top: 22,
                        bottom: 20,
                        child: VerticalDivider(
                          width: 10,
                          color: AppColors.darkGrey.color,
                        ),
                      ),
                      Column(
                        children: [
                          _newInfoTile(lawatan: 1),
                          _newInfoTile(lawatan: 2),
                          _newInfoTile(lawatan: 3, isComplete: false),
                        ],
                      ),
                    ],
                  );
                })
              ],
            ),
          ),
          bottomNavigationBar: BottomBarButton(
              onTap: () {
                QrNavigationPref.setFromHome(val: false).then(
                  (val) => Navigator.push(
                      context,
                      PageTransition(
                          child: const BancianQrscan(),
                          type: PageTransitionType.rightToLeft)),
                );
              },
              title: "Teruskan Bancian"),
        ),
      ),
    );
  }

  _newInfoTile({required int lawatan, bool isComplete = true}) {
    return ExpansionTile(
      shape: const Border(),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,
      childrenPadding: const EdgeInsets.only(left: 80, bottom: 10, top: 10),
      leading: Container(
        decoration: BoxDecoration(
          color: isComplete ? AppColors.primary.color : AppColors.midGrey.color,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 4),
        child: Text(
          "$lawatan",
          textAlign: TextAlign.center,
          style: appTextStyle(color: isComplete ? Colors.white : Colors.black),
        ),
        // child: const Icon(Icons.receipt),
      ),
      // contentPadding: EdgeInsets.zero,
      // isThreeLine: true,
      dense: true,
      title: Text("LAWATAN $lawatan"),
      subtitle: Text(!isComplete ? "Status: -" : "Status: Tidak Lengkap"),
      trailing: isComplete
          ? null
          : Chip(
              color: WidgetStatePropertyAll(
                  isComplete ? Colors.green : Colors.grey),
              label: Text(
                isComplete ? "SELESAI" : "BELUM DIBANCI",
                style: appTextStyle(
                    size: 10, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              shape: const StadiumBorder(),
              side: BorderSide.none,
            ),
      children: const [
        Text("Catatan:"),
        Text("Tiada penghuni dirumah"),
      ],
    );
  }
}
