import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

class KadPengenalanTile extends StatelessWidget {
  const KadPengenalanTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Card(
        color: Colors.white,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: ExpansionTile(
            initiallyExpanded: true,
            backgroundColor: Colors.white,
            shape: const Border(),
            title: Row(
              children: [
                Text(
                  "Kad Pengenalan",
                  style: appTextStyle(size: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
                const Text(
                  "*",
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _cameraContainer(context, title: "Kad Pengenalan Depan"),
                      const SizedBox(width: 10),
                      _cameraContainer(context,
                          title: "Kad Pengenalan Belakang"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _cameraContainer(BuildContext context, {required String title}) {
    return Column(
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width * .43,
          // width: 250,
          height: 130,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border.all(
              color: Colors.grey,
              style: BorderStyle.solid,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt,
                  size: 40,
                  color: Colors.grey,
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Buka kamera & Ambil Gambar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(title),
      ],
    );
  }
}
