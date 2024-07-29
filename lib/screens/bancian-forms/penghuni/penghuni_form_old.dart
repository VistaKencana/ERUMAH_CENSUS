import 'dart:typed_data';

import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/custom_underline_field.dart';
import 'package:eperumahan_bancian/components/disability_checkbox.dart';
import 'package:eperumahan_bancian/components/kad_pengenalan_tile.dart';
import 'package:eperumahan_bancian/components/two_column_form.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_main_screen.dart';
import 'package:flutter/material.dart';

import '../../../components/card_display.dart';
import '../../../components/custom_appbar.dart';

class PenghuniFormOld extends StatefulWidget {
  final bool? isEdit;
  final List<Uint8List> imgs;
  const PenghuniFormOld({super.key, this.isEdit, required this.imgs});

  @override
  State<PenghuniFormOld> createState() => _PenghuniFormOldState();
}

class _PenghuniFormOldState extends State<PenghuniFormOld> {
  _isEdit() => (widget.isEdit != null && widget.isEdit == true);
  _isReadOnly() => _isEdit() ? false : true;
  Uint8List? frontCard;
  Uint8List? backCard;
  Uint8List? okuCard;
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
                                builder: (_) => BancianMainScreen(
                                      isNewForm: true,
                                      imgs: widget.imgs,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KadPengenalanTile(
                onFrontCard: (bytes) {
                  setState(() => frontCard = bytes);
                },
                onBackCard: (bytes) {
                  setState(() => backCard = bytes);
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
                child: TwoColumnForm(
                  children: [
                    _textField(
                        title: 'Nama Penuh',
                        initialValue: "Arif Aiman",
                        readOnly: _isReadOnly()),
                    _textField(title: 'Bilangan Isi Rumah', initialValue: "2"),
                    _textField(
                        title: 'No. Kad Pengenalan',
                        initialValue: "7056448140568",
                        readOnly: _isReadOnly()),
                    _textField(
                        title: 'Emel', initialValue: "arifaiman@gmail.com"),
                    _textField(
                        title: 'Umur(Tahun)',
                        initialValue: "50",
                        readOnly: _isReadOnly()),
                    _textField(title: 'No Telefon', initialValue: "0186456762"),
                    _textField(
                        title: 'Jantina',
                        readOnly: _isReadOnly(),
                        initialValue: "Lelaki"),
                    _textField(
                        title: 'Bangsa',
                        readOnly: _isReadOnly(),
                        initialValue: "Melayu"),
                    _textField(
                        title: 'Jenis Pekerjaan', initialValue: "Persendirian"),
                    _textField(
                        title: 'Status Perkahwinan', initialValue: "Berkahwin"),
                    // _textField(title: 'Kecacatan (OKU)'),
                  ],
                ),
              ),
              DisabilityCheckbox(initVal: false, onCheck: (val) {}),
              CardDisplay(
                title: "",
                img: okuCard,
                onPicture: (bytes) => setState(() => okuCard = bytes),
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
