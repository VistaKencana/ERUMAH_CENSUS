import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/pasangan_modal.dart';
import 'package:flutter/material.dart';

import 'tanggungan_modal.dart';

class TanggunganForm extends StatefulWidget {
  const TanggunganForm({super.key});

  @override
  State<TanggunganForm> createState() => _TanggunganFormState();
}

class _TanggunganFormState extends State<TanggunganForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  const PasanganModal().show(context);
                },
                contentPadding: const EdgeInsets.all(12),
                leading: Container(
                  decoration: BoxDecoration(
                      color: AppColors.primary.color,
                      shape: BoxShape.circle,
                      border: Border.all()),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                title: const Text("Tambah tanggungan"),
              ),
              const Divider(height: 0),
              _anakTile(name: "Liyana Aina", index: 1),
              _anakTile(name: "Nur Fatin", index: 2)
            ],
          ),
        ),
      ),
    );
  }

  _anakTile({required String name, required int index}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListTile(
          onTap: () {
            const TanggunganModal().show(context);
          },
          contentPadding: const EdgeInsets.all(12),
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text("Tanggungan $index"),
          subtitle: Text(name),
        ),
        const Divider(
          height: 0,
          indent: 30,
          color: Colors.black12,
          endIndent: 10,
        ),
      ],
    );
  }
}
