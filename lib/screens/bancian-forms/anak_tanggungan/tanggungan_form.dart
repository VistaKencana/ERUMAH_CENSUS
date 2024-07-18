import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'tanggungan_modal.dart';

class TanggunganForm extends StatefulWidget {
  const TanggunganForm({super.key});

  @override
  State<TanggunganForm> createState() => _TanggunganFormState();
}

class _TanggunganFormState extends State<TanggunganForm> {
  List<String> tabName = ["Anak", "Tanggungan"];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabName.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Maklumat Anak & Tanggungan"),
          bottom: TabBar(
              tabs: List.generate(
                  tabName.length,
                  (index) => Tab(
                        text: tabName[index],
                      ))),
        ),
        body: TabBarView(children: [
          _anakTabForm(),
          _tanggunganTabForm(),
        ]),
        bottomNavigationBar: BottomBarButton(
            onTap: () => Navigator.pop(context), title: "Simpan"),
      ),
    );
  }

  Widget _anakTabForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                const TanggunganModal(
                  isEdit: true,
                  isAnak: true,
                ).show(context);
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
              title: const Text("Tambah anak"),
            ),
            const Divider(height: 0),
            _customTile(title: "Anak 1", name: "Liyana Aina"),
            _customTile(title: "Anak 2", name: "Nur Fatin")
          ],
        ),
      ),
    );
  }

  Widget _tanggunganTabForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                const TanggunganModal(
                  isEdit: true,
                  isAnak: false,
                ).show(context);
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
            _customTile(
                title: "Tanggungan 1", name: "Liyana Aina", isAnak: false),
            _customTile(title: "Tanggungan 2", name: "Nur Fatin", isAnak: false)
          ],
        ),
      ),
    );
  }

  _customTile(
      {required String title, required String name, bool isAnak = true}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListTile(
          onTap: () {
            TanggunganModal(isAnak: isAnak).show(context);
          },
          contentPadding: const EdgeInsets.all(12),
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(title),
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
