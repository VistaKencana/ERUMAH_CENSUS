import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return ListTile(
      isThreeLine: true,
      dense: true,
      contentPadding: EdgeInsets.all(12),
      leading: FaIcon(FontAwesomeIcons.cloudArrowUp),
      title: Text(
        "LAWATAN $lawatan",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(!isComplete ? "Status: -" : "$status • $date"),
        SizedBox(height: 12),
        Row(
          children: [
            FaIcon(FontAwesomeIcons.solidSquareCaretRight, size: 14),
            SizedBox(width: 6),
            Text(remarks),
          ],
        ),
      ]),
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
