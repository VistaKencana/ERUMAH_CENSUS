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
        backgroundColor: Colors.white,
        shape: const Border(),
        title: const Text("Kad Pengenalan"),
        children: [
          const Text("Kad Pengenalan Depan"),
          _cameraContainer(),
          const Text("Kad Pengenalan Belakang"),
        ],
      ),
    );
  }

  _cameraContainer() {
    return Container(
      width: 300,
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
          children: [
            Icon(
              Icons.camera_alt,
              size: 40,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            Text(
              'Buka kamera & Ambil Gambar',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
