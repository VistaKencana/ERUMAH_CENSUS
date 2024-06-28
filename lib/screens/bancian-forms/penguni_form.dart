import 'package:eperumahan_bancian/components/custom_underline_field.dart';
import 'package:eperumahan_bancian/components/kad_pengenalan_tile.dart';
import 'package:flutter/material.dart';

class PenguniForm extends StatefulWidget {
  const PenguniForm({super.key});

  @override
  State<PenguniForm> createState() => _PenguniFormState();
}

class _PenguniFormState extends State<PenguniForm> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.sizeOf(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 2), blurRadius: 10, color: Colors.black12)
          ],
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(10))),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.5),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const KadPengenalanTile(),
                GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of items per row
                    childAspectRatio: 16 / 8, // Aspect ratio of each item
                    mainAxisSpacing: 10.0, // Spacing between rows
                    crossAxisSpacing: 10.0, // Spacing between columns
                  ),
                  children: [
                    _textField(
                        initialValue: "", title: 'Nama Penuh', readOnly: true),
                    _textField(title: 'Bilangan Isi Rumah'),
                    _textField(title: 'No. Kad Pengenalan', readOnly: true),
                    _textField(title: 'Emel'),
                    _textField(title: 'Umur(Tahun)', readOnly: true),
                    _textField(title: 'No Telefon'),
                    _textField(title: 'Jantina', readOnly: true),
                    _textField(title: 'Bangsa', readOnly: true),
                    _textField(title: 'Kecacatan (OKU)'),
                    _textField(title: 'Jenis Pekerjaan'),
                    _textField(title: 'Status Perkahwinan'),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _textField(
      {required String title, String? initialValue, bool readOnly = false}) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.4,
      child: CustomUnderlineField(
        title: title,
        showEditIcon: !readOnly,
        readOnly: readOnly,
        initialValue: initialValue,
      ),
    );
  }
}
