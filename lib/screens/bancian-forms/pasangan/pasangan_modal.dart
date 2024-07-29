import 'dart:typed_data';

import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/card_display.dart';
import 'package:eperumahan_bancian/components/custom_form_field.dart';
import 'package:eperumahan_bancian/components/kad_pengenalan_tile.dart';
import 'package:eperumahan_bancian/components/two_column_form.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../components/disability_checkbox.dart';
import '../../../components/file_display.dart';

class PasanganModal extends StatefulWidget {
  final bool? isNewForm;
  const PasanganModal({super.key, this.isNewForm});

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
  _isNewForm() => (widget.isNewForm != null && widget.isNewForm == true);
  _isReadOnly() => _isNewForm() ? false : true;
  Uint8List? frontCard;
  Uint8List? backCard;
  Uint8List? okuCard;
  Uint8List? slipGajiImg;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.94,
      maxChildSize: 0.94,
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
              children: [_header(), _form()],
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

  _form() {
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
                  _textField(
                      initialValue: "Siti Nabila",
                      title: 'Nama Penuh',
                      width: double.infinity,
                      readOnly: _isReadOnly()),
                  _gap(height: 14),
                  TwoColumnForm(
                    children: [
                      _textField(
                          title: 'Emel', initialValue: "sitinabila@gmail.com"),
                      _textField(
                          title: 'No. Kad Pengenalan',
                          initialValue: "697870984456",
                          readOnly: _isReadOnly()),
                      _textField(
                          title: 'No Telefon', initialValue: "0198765654"),
                      _textField(
                          title: 'Umur(Tahun)',
                          initialValue: "50",
                          readOnly: _isReadOnly()),
                      _textField(
                          title: 'Tahap Kesihatan', initialValue: "Sihat"),
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
            const SizedBox(height: 10),
            const Divider(height: 0, indent: 20, endIndent: 20),
            _gap(height: 14),
            _formPenadapatan()
          ],
        ),
      ),
    );
  }

  _textField(
      {required String title,
      String? initialValue,
      bool readOnly = false,
      String? hintText,
      double? width}) {
    return SizedBox(
      width: width ?? MediaQuery.sizeOf(context).width * 0.4,
      child: CustomFormField(
        title: title,
        readOnly: readOnly,
        hintText: hintText,
        initialValue: _isNewForm() ? "" : initialValue,
      ),
    );
  }

  _formPenadapatan() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Maklumat Pendapatan",
            style: appTextStyle(size: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          Column(
            children: [
              CustomFormField(
                title: "Alamat Majikan",
                initialValue: _isNewForm()
                    ? ""
                    : "No. 1 Jalan 2 Taman Perindustrian, 50300 Kuala Lumpur",
                maxLines: 3,
                contentPadding: const EdgeInsets.all(8),
              ),
              const SizedBox(height: 12),
            ],
          ),
          TwoColumnForm(
            children: [
              _textField(
                  title: 'Gaji Pokok (RM)',
                  hintText: "0.00",
                  initialValue: "1800"),
              _textField(
                  title: 'Elaun (RM)', hintText: "0.00", initialValue: "0.00"),
              _textField(title: 'Lain-lain Pendapatan', initialValue: "Tiada"),
              _textField(title: 'Bantuan Kewangan', initialValue: "Tiada"),
            ],
          ),
          const SizedBox(height: 10),
          FileDisplay(
            title: "Slip Gaji / Penyata KWSP",
            isMandatory: true,
            img: slipGajiImg,
            onPicture: (bytes) => setState(() => slipGajiImg = bytes),
          )
        ],
      ),
    );
  }

  _gap({double height = 10}) => SizedBox(height: height);
}
