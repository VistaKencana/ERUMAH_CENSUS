import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/kad_pengenalan_tile.dart';
import 'package:eperumahan_bancian/components/two_column_form.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_underline_field.dart';
import '../../../components/disability_checkbox.dart';

class TanggunganModal extends StatefulWidget {
  final bool? isEdit;
  const TanggunganModal({super.key, this.isEdit});
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
                      children: [
                        const KadPengenalanTile(),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          child: TwoColumnForm(
                            children: [
                              _textField(
                                  title: 'Nama Tanggungan',
                                  initialValue: "Nur Fatin",
                                  readOnly: _isReadOnly()),
                              _textField(
                                  title: 'Hubungan Dengan Penyewa',
                                  initialValue: "Anak",
                                  readOnly: _isReadOnly()),
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
                              _textField(title: 'Bangsa'),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DisabilityCheckbox(
                                    initVal: false, onCheck: (val) {}),
                                _kadOKU(),
                              ],
                            )),
                        const SizedBox(height: 10)
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
      padding: const EdgeInsets.only(left: 12, top: 28, bottom: 18),
      child: Row(
        children: [
          const Text(
            'Maklumat Tanggungan',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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

  _kadOKU() {
    return Container(
      width: MediaQuery.sizeOf(context).width * .43,
      // width: 250,
      height: 130,
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
    );
  }
}
