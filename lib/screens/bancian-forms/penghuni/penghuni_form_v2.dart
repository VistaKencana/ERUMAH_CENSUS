import 'dart:typed_data';

import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/card_display.dart';
import 'package:eperumahan_bancian/components/custom_form_field.dart';
import 'package:eperumahan_bancian/components/disability_checkbox.dart';
import 'package:eperumahan_bancian/components/kad_pengenalan_tile.dart';
import 'package:eperumahan_bancian/components/two_column_form.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_main_screen.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_appbar.dart';

class PenghuniFormV2 extends StatefulWidget {
  final bool? isEdit;
  const PenghuniFormV2({super.key, this.isEdit});

  @override
  State<PenghuniFormV2> createState() => _PenghuniFormV2State();
}

class _PenghuniFormV2State extends State<PenghuniFormV2> {
  _isEdit() => (widget.isEdit != null && widget.isEdit == true);
  _isReadOnly() => _isEdit() ? false : true;
  Uint8List? frontCard;
  Uint8List? backCard;
  Uint8List? okuCard;
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.sizeOf(context);
    return BgImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: "",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6.0, bottom: 18),
                  child: Text(
                    "Maklumat Penghuni",
                    style: appTextStyle(size: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                KadPengenalanTile(
                  onFrontCard: (bytes) {
                    setState(() => frontCard = bytes);
                  },
                  onBackCard: (bytes) {
                    setState(() => backCard = bytes);
                  },
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _textField(
                          title: 'Nama Penuh',
                          initialValue: "Arif Aiman",
                          width: double.infinity,
                          readOnly: _isReadOnly()),
                      _gap(),
                      TwoColumnForm(
                        children: [
                          _textField(
                              title: 'Bilangan Isi Rumah', initialValue: "2"),
                          _textField(
                              title: 'No. Kad Pengenalan',
                              initialValue: "7056448140568",
                              readOnly: _isReadOnly()),
                          _textField(
                              title: 'Emel',
                              initialValue: "arifaiman@gmail.com"),
                          _textField(
                              title: 'Umur(Tahun)',
                              initialValue: "50",
                              readOnly: _isReadOnly()),
                          _textField(
                              title: 'No Telefon', initialValue: "0186456762"),
                          _textField(
                              title: 'Jantina',
                              readOnly: _isReadOnly(),
                              initialValue: "Lelaki"),
                          _textField(
                              title: 'Bangsa',
                              readOnly: _isReadOnly(),
                              initialValue: "Melayu"),
                          _textField(
                              title: 'Jenis Pekerjaan',
                              initialValue: "Persendirian"),
                          _textField(
                              title: 'Status Perkahwinan',
                              initialValue: "Berkahwin"),
                          // _textField(title: 'Kecacatan (OKU)'),
                        ],
                      ),
                      _gap(),
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomBarButton(
            onTap: () => Navigator.pop(context), title: "Simpan"),
      ),
    );
  }

  _textField(
      {required String title,
      String? initialValue,
      bool readOnly = false,
      double? width}) {
    return SizedBox(
      width: width ?? MediaQuery.sizeOf(context).width * 0.4,
      child: CustomFormField(
        title: title,
        readOnly: readOnly,
        initialValue: initialValue,
      ),
    );
  }

  _gap({double height = 10}) => SizedBox(height: height);
}
