import 'package:eperumahan_bancian/components/custom_underline_field.dart';
import 'package:eperumahan_bancian/components/kad_pengenalan_tile.dart';
import 'package:eperumahan_bancian/components/two_column_form.dart';
import 'package:flutter/material.dart';

class PenghuniForm extends StatefulWidget {
  const PenghuniForm({super.key});

  @override
  State<PenghuniForm> createState() => _PenghuniFormState();
}

class _PenghuniFormState extends State<PenghuniForm> {
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
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                const KadPengenalanTile(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
                  child: TwoColumnForm(
                    children: [
                      _textField(
                          initialValue: "",
                          title: 'Nama Penuh',
                          readOnly: true),
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
