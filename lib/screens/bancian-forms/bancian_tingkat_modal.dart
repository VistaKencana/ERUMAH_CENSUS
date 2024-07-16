import 'package:flutter/material.dart';

class BancianTingkatModal extends StatefulWidget {
  const BancianTingkatModal({super.key});

  Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      isScrollControlled: true,
      builder: (_) => this,
    );
  }

  @override
  State<BancianTingkatModal> createState() => _BancianTingkatModalState();
}

class _BancianTingkatModalState extends State<BancianTingkatModal> {
  String currValue = "20";

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: .5,
      maxChildSize: .7,
      initialChildSize: .6,
      builder: (context, sc) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 12, top: 28, bottom: 18),
              child: Text(
                'Status kompaun',
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
                      value: "${index + 1}",
                      title: Text("${index + 1}"),
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
