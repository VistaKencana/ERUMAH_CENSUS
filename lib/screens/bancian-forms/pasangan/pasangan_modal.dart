import 'dart:typed_data';

import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/card_display.dart';
import 'package:eperumahan_bancian/components/custom_form_field.dart';
import 'package:eperumahan_bancian/components/kad_pengenalan_tile.dart';
import 'package:eperumahan_bancian/components/two_column_form.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_underline_field.dart';
import '../../../components/disability_checkbox.dart';

class PasanganModal extends StatefulWidget {
  final bool? isEdit;
  const PasanganModal({super.key, this.isEdit});

  Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      isScrollControlled: true,
      builder: (_) => this,
    );
  }

  @override
  State<PasanganModal> createState() => _PasanganModalState();
}

class _PasanganModalState extends State<PasanganModal> {
  _isEdit() => (widget.isEdit != null && widget.isEdit == true);
  _isReadOnly() => _isEdit() ? false : true;
  Uint8List? frontCard;
  Uint8List? backCard;
  Uint8List? okuCard;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      builder: (context, sc) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadiusDirectional.vertical(top: Radius.circular(16)),
          ),
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [_header(), formV2()],
            ),
            bottomNavigationBar: BottomBarButton(
                onTap: () => Navigator.pop(context), title: "Simpan"),
          ),
        );
      },
    );
  }

  _header() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 28, bottom: 18),
      child: Row(
        children: [
          const Text(
            'Maklumat Pasangan',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const Spacer(),
          GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close)),
          const SizedBox(width: 15),
        ],
      ),
    );
  }

  formV1() {
    return Expanded(
      child: SingleChildScrollView(
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: TwoColumnForm(
                children: [
                  _textField(
                      initialValue: "Siti Nabila",
                      title: 'Nama Penuh',
                      readOnly: _isReadOnly()),
                  _textField(
                      title: 'Emel', initialValue: "sitinabila@gmail.com"),
                  _textField(
                      title: 'No. Kad Pengenalan',
                      initialValue: "697870984456",
                      readOnly: _isReadOnly()),
                  _textField(title: 'No Telefon', initialValue: "0198765654"),
                  _textField(
                      title: 'Umur(Tahun)',
                      initialValue: "50",
                      readOnly: _isReadOnly()),
                  _textField(title: 'Tahap Kesihatan', initialValue: "Sihat"),
                  _textField(
                      title: 'Jantina',
                      initialValue: "Perempuan",
                      readOnly: _isReadOnly()),
                  _textField(
                      title: 'Bangsa',
                      initialValue: "Melayu",
                      readOnly: _isReadOnly()),
                  _textField(
                    title: 'Hidup',
                    initialValue: "Ya",
                  ),
                  _textField(
                    title: 'Jenis Pekerjaan',
                    initialValue: "Suri RUmah",
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DisabilityCheckbox(initVal: false, onCheck: (val) {}),
                    CardDisplay(
                      title: "",
                      img: okuCard,
                      onPicture: (bytes) => setState(() => okuCard = bytes),
                    ),
                  ],
                )),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  formV2() {
    return Expanded(
      child: SingleChildScrollView(
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
            const Divider(height: 0, indent: 20, endIndent: 20),
            _gap(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: Column(
                children: [
                  _textFieldV2(
                      initialValue: "Siti Nabila",
                      title: 'Nama Penuh',
                      width: double.infinity,
                      readOnly: _isReadOnly()),
                  _gap(height: 14),
                  TwoColumnForm(
                    children: [
                      _textFieldV2(
                          title: 'Emel', initialValue: "sitinabila@gmail.com"),
                      _textFieldV2(
                          title: 'No. Kad Pengenalan',
                          initialValue: "697870984456",
                          readOnly: _isReadOnly()),
                      _textFieldV2(
                          title: 'No Telefon', initialValue: "0198765654"),
                      _textFieldV2(
                          title: 'Umur(Tahun)',
                          initialValue: "50",
                          readOnly: _isReadOnly()),
                      _textFieldV2(
                          title: 'Tahap Kesihatan', initialValue: "Sihat"),
                      _textFieldV2(
                          title: 'Jantina',
                          initialValue: "Perempuan",
                          readOnly: _isReadOnly()),
                      _textFieldV2(
                          title: 'Bangsa',
                          initialValue: "Melayu",
                          readOnly: _isReadOnly()),
                      _textFieldV2(
                        title: 'Hidup',
                        initialValue: "Ya",
                      ),
                      _textFieldV2(
                        title: 'Jenis Pekerjaan',
                        initialValue: "Suri Rumah",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DisabilityCheckbox(initVal: false, onCheck: (val) {}),
                    CardDisplay(
                      title: "",
                      img: okuCard,
                      onPicture: (bytes) => setState(() => okuCard = bytes),
                    ),
                  ],
                )),
            const SizedBox(height: 10)
          ],
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
        initialValue: _isEdit() ? "" : initialValue,
      ),
    );
  }

  _textFieldV2(
      {required String title,
      String? initialValue,
      bool readOnly = false,
      double? width}) {
    return SizedBox(
      width: width ?? MediaQuery.sizeOf(context).width * 0.4,
      child: CustomFormField(
        title: title,
        readOnly: readOnly,
        initialValue: _isEdit() ? "" : initialValue,
      ),
    );
  }

  _gap({double height = 10}) => SizedBox(height: height);
}
