import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/pendapatan_modal.dart';
import 'package:flutter/material.dart';

class PendapatanForm extends StatefulWidget {
  const PendapatanForm({super.key});

  @override
  State<PendapatanForm> createState() => _PendapatanFormState();
}

class _PendapatanFormState extends State<PendapatanForm> {
  @override
  Widget build(BuildContext context) {
    return BgImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _section(title: "Penghuni"),
                _pendapatanTile(
                    title: "Pendapatan Penghuni",
                    salary: "RM 1800 / sebulan",
                    address:
                        "No. 1 Jalan 2 Taman Perindustrian, 50300 Kuala Lumpur"),
                const SizedBox(height: 12),
                _section(title: "Pasangan", showBtn: true),
                _pendapatanTile(
                    title: "Pendapatan Pasangan",
                    salary: "RM 1800 / sebulan",
                    address:
                        "No. 1 Jalan 2 Taman Perindustrian, 50300 Kuala Lumpur"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _pendapatanTile(
      {required String title,
      required String address,
      required String salary}) {
    return GestureDetector(
      onTap: () => const PendapatanModal().show(context),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.only(bottom: 14, top: 4, left: 12, right: 12),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(6)),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(Icons.person),
                  ),
                  title: Text(
                    title,
                    style: appTextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on_outlined),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(address),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.paid_outlined),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(salary),
                    ),
                  ],
                )
              ],
            )),
            const Icon(Icons.chevron_right),
            const SizedBox(width: 6),
          ],
        ),
      ),
    );
  }

  _section({required String title, bool showBtn = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: appTextStyle(fontWeight: FontWeight.bold, size: 20),
            ),
          ),
          Visibility(
            visible: showBtn,
            child: GestureDetector(
              onTap: () {
                const PendapatanModal().show(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.primary.color,
                    borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.all(6),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
