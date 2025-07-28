import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BancianInfoTile extends StatelessWidget {
  final String lawatan;
  final String status;
  final bool isComplete;
  final String date;
  final String remarks;
  const BancianInfoTile(
      {super.key,
      required this.lawatan,
      required this.date,
      this.isComplete = true,
      required this.remarks,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: ExpansionTile(
          initiallyExpanded: true,
          tilePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          backgroundColor: Colors.grey.shade200,
          collapsedBackgroundColor: Colors.grey.shade200,
          shape: Border(),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          expandedAlignment: Alignment.centerLeft,
          childrenPadding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
          title: Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    "LAWATAN $lawatan",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(!isComplete ? "Status: -" : "$status • $date"),
          ),
          trailing: isComplete
              ? null
              : Chip(
                  color: WidgetStatePropertyAll(getStatusColor(status: status)),
                  label: Text(
                    status.toUpperCase(),
                    style: appTextStyle(
                        size: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  shape: const StadiumBorder(),
                  side: BorderSide.none,
                ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.attachment_outlined),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Catatan:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(remarks),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Color getStatusColor({required String status}) {
    final map = {
      "selesai": Colors.greenAccent,
      "tidak lengkap": Colors.amber,
      "dalam proses": Colors.blueAccent
    };

    return map[status.toLowerCase()] ?? Colors.grey;
  }
}
