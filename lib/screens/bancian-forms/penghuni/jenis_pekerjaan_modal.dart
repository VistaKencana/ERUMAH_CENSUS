import 'package:flutter/material.dart';

class JenisPekerjaanModal extends StatefulWidget {
  const JenisPekerjaanModal({super.key});

  Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      isScrollControlled: true,
      builder: (_) => this,
    );
  }

  @override
  State<JenisPekerjaanModal> createState() => _JenisPekerjaanModalState();
}

class _JenisPekerjaanModalState extends State<JenisPekerjaanModal> {
  String currValue = "Swasta";
  List<String> statusFilter = [
    "Swasta",
    "Bekerja Sendiri",
    "Kakitangan Kerajaan",
    "Kakitangan DBKL",
  ];

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: ModalRoute.of(context)!.animation!,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12, top: 28, bottom: 18),
            child: Text(
              'Jenis pekerjaan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          ...List.generate(
            statusFilter.length,
            (index) => RadioListTile<String>(
                controlAffinity: ListTileControlAffinity.trailing,
                groupValue: currValue,
                value: statusFilter[index],
                title: Text(statusFilter[index]),
                onChanged: (val) {
                  setState(() {
                    currValue = val!;
                    Navigator.pop(context);
                  });
                }),
          )
        ],
      ),
    );
  }
}
