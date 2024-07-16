import 'package:eperumahan_bancian/components/custom_textfield.dart';
import 'package:flutter/material.dart';

class BancianStatusField extends StatelessWidget {
  final String? initialVal;
  const BancianStatusField({super.key, this.initialVal});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      readOnly: true,
      initialValue: initialVal,
      onTap: () {
        const BancianStatusModal().show(context);
      },
      suffixIcon: Icons.arrow_drop_down,
    );
  }
}

class BancianStatusModal extends StatefulWidget {
  const BancianStatusModal({super.key});

  Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      isScrollControlled: true,
      builder: (_) => this,
    );
  }

  @override
  State<BancianStatusModal> createState() => _BancianStatusModalState();
}

class _BancianStatusModalState extends State<BancianStatusModal> {
  String currValue = "Bancian Berjaya";
  List<String> statusFilter = [
    "Bancian Berjaya",
    "Bancian Gagal (Tiada Penghuni)",
    "Bancian Gagal (Lain-lain)",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12, top: 28, bottom: 18),
          child: Text(
            'Status Bancian',
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
    );
  }
}
