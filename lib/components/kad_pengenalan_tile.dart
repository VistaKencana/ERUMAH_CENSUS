import 'package:flutter/material.dart';

class KadPengenalanTile extends StatelessWidget {
  const KadPengenalanTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: ExpansionTile(
        initiallyExpanded: true,
        backgroundColor: Colors.white,
        shape: const Border(),
        title: const Row(
          children: [
            Text("Kad Pengenalan"),
            SizedBox(width: 4),
            Text(
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
                  _cameraContainer(context, title: "Kad Pengenalan Belakang"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _cameraContainer(BuildContext context, {required String title}) {
    return Column(
      children: [
        Container(
          // width: MediaQuery.sizeOf(context).width * .4,
          width: 250,
          height: 150,
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
