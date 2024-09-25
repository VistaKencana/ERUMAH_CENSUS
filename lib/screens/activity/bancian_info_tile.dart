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
          lawatan,
          textAlign: TextAlign.center,
          style: appTextStyle(color: isComplete ? Colors.white : Colors.black),
        ),
      ),
      title: Text("LAWATAN $lawatan"),
      subtitle: Text(!isComplete ? "Status: -" : "$status • $date"),
      trailing: isComplete
          ? null
          : Chip(
              color: WidgetStatePropertyAll(getStatusColor(status: status)),
              label: Text(
                status.toUpperCase(),
                style: appTextStyle(
                    size: 10, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              shape: const StadiumBorder(),
              side: BorderSide.none,
            ),
      children: [
        const Text("Catatan:"),
        Text(remarks),
      ],
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
