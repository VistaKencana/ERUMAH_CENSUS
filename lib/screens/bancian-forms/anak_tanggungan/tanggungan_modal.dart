import 'dart:typed_data';

import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/card_display.dart';
import 'package:eperumahan_bancian/components/custom_form_field.dart';
import 'package:eperumahan_bancian/components/kad_pengenalan_tile.dart';
import 'package:eperumahan_bancian/components/two_column_form.dart';
import 'package:flutter/material.dart';
import '../../../components/disability_checkbox.dart';

class TanggunganModal extends StatefulWidget {
  final bool isAnak;
  final bool? isEdit;
  const TanggunganModal({super.key, this.isEdit, required this.isAnak});
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
  State<TanggunganModal> createState() => _TanggunganModalState();
}

class _TanggunganModalState extends State<TanggunganModal> {
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
              children: [
                _header(),
                Expanded(
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
                        _gap(height: 22),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _textField(
                                  title: 'Nama Tanggungan',
                                  initialValue: "Nur Fatin",
                                  width: double.infinity,
                                  readOnly: _isReadOnly()),
                              _gap(height: 14),
                              TwoColumnForm(
                                children: [
                                  _textField(
                                    title: 'Hubungan Dengan Penyewa',
                                    initialValue: "Anak",
                                    isDropdown: true,
                                    readOnly: true,
                                    onTap: _isEdit() ? () {} : null,
                                  ),
                                  _textField(
                                      title: 'No. Kad Pengenalan',
                                      initialValue: "9512345145678",
                                      readOnly: _isReadOnly()),
                                  _textField(
                                      title: 'Emel',
                                      initialValue: "nurfatin@gmail.com"),
                                  _textField(
                                      title: 'Umur(Tahun)',
                                      initialValue: "26",
                                      readOnly: _isReadOnly()),
                                  _textField(
                                      title: 'Tahap Kesihatan',
                                      initialValue: "Sihat"),
                                  _textField(
                                      title: 'No. Telefon',
                                      initialValue: "01645678642",
                                      readOnly: _isReadOnly()),
                                  _textField(
                                      title: 'Jantina',
                                      initialValue: "Perempuan",
                                      readOnly: _isReadOnly()),
                                  _textField(
                                    title: 'Bangsa',
                                    initialValue: "Melayu",
                                  ),
                                ],
                              ),
                              _gap(height: 14),
                              DisabilityCheckbox(
                                  initVal: false, onCheck: (val) {}),
                              CardDisplay(
                                title: "",
                                img: okuCard,
                                onPicture: (bytes) =>
                                    setState(() => okuCard = bytes),
                              ),
                              const SizedBox(height: 10)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
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
      padding: const EdgeInsets.only(left: 12, top: 28),
      child: Row(
        children: [
          Text(
            _getHeaderTitle(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const Spacer(),
          GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close)),
          const SizedBox(width: 15)
        ],
      ),
    );
  }

  String _getHeaderTitle() {
    String prefix = _isEdit() ? "Tambah " : "Maklumat ";
    String title = widget.isAnak ? 'Anak' : 'Tanggungan';
    return prefix + title;
  }

  _gap({double height = 10}) => SizedBox(height: height);
  // _textField(
  //     {required String title, String? initialValue, bool readOnly = false,double? width}) {
  //   return SizedBox(
  //     width: MediaQuery.sizeOf(context).width * 0.4,
  //     child: CustomUnderlineField(
  //       title: title,
  //       showEditIcon: !readOnly,
  //       readOnly: readOnly,
  //       initialValue: initialValue,
  //     ),
  //   );
  // }
  _textField(
      {required String title,
      String? initialValue,
      bool readOnly = false,
      bool isDropdown = false,
      void Function()? onTap,
      double? width}) {
    return SizedBox(
      width: width ?? MediaQuery.sizeOf(context).width * 0.4,
      child: CustomFormField(
        title: title,
        readOnly: readOnly,
        fillColor: isDropdown && _isEdit() ? Colors.white : null,
        onTap: onTap,
        initialValue: _isEdit() ? "" : initialValue,
        suffixIcon: isDropdown ? Icons.arrow_drop_down_rounded : null,
      ),
    );
  }
}
