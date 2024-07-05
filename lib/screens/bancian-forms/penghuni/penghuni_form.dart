import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/custom_underline_field.dart';
import 'package:eperumahan_bancian/components/kad_pengenalan_tile.dart';
import 'package:eperumahan_bancian/components/two_column_form.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_main_screen.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_appbar.dart';

class PenghuniForm extends StatefulWidget {
  final bool? isEdit;
  const PenghuniForm({super.key, this.isEdit});

  @override
  State<PenghuniForm> createState() => _PenghuniFormState();
}

class _PenghuniFormState extends State<PenghuniForm> {
  _isEdit() => (widget.isEdit != null && widget.isEdit == true);
  _isReadOnly() => _isEdit() ? false : true;
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      //  backgroundColor: Colors.white.withOpacity(0.5),
      appBar: CustomAppBar(
        title: "Maklumat Penghuni",
        actions: _isEdit()
            ? []
            : [
                PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const BancianMainScreen(
                                      isEdit: true,
                                    )));
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.report),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Lapor Penghuni")
                        ],
                      ),
                    ),
                  ],
                  offset: const Offset(0, 50),
                  color: Colors.white,
                  elevation: 2,
                ),
              ],
      ),

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
                        readOnly: _isReadOnly()),
                    _textField(title: 'Bilangan Isi Rumah'),
                    _textField(
                        title: 'No. Kad Pengenalan', readOnly: _isReadOnly()),
                    _textField(title: 'Emel'),
                    _textField(title: 'Umur(Tahun)', readOnly: _isReadOnly()),
                    _textField(title: 'No Telefon'),
                    _textField(title: 'Jantina', readOnly: _isReadOnly()),
                    _textField(title: 'Bangsa', readOnly: _isReadOnly()),
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
      bottomNavigationBar:
          BottomBarButton(onTap: () => Navigator.pop(context), title: "Simpan"),
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
