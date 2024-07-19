import 'package:flutter/material.dart';

class KawasanModal extends StatefulWidget {
  const KawasanModal({super.key});

  Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      isScrollControlled: true,
      builder: (_) => this,
    );
  }

  @override
  State<KawasanModal> createState() => _KawasanModalState();
}

class _KawasanModalState extends State<KawasanModal> {
  String currValue = "PPR Sri Selangor 1";

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: .6,
      maxChildSize: .8,
      initialChildSize: .8,
      builder: (context, sc) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 12, top: 28, bottom: 18),
              child: Text(
                'Pilih Kawasan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              controller: sc,
              child: Column(
                children: List.generate(
                  20,
                  (index) => RadioListTile<String>(
                      controlAffinity: ListTileControlAffinity.trailing,
                      groupValue: currValue,
                      value: "PPR Sri Selangor ${index + 1}",
                      title: Text("PPR Sri Selangor ${index + 1}"),
                      onChanged: (val) {
                        setState(() {
                          currValue = val!;
                          Navigator.pop(context);
                        });
                      }),
                ),
              ),
            ))
          ],
        );
      },
    );
  }
}
