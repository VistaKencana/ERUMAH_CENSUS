import 'package:eperumahan_bancian/components/bottombar_button.dart';
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
                        const KadPengenalanTile(),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          child: TwoColumnForm(
                            children: [
                              _textField(
                                  initialValue: _isEdit() ? "" : "Siti Nabila",
                                  title: 'Nama Penuh',
                                  readOnly: _isReadOnly()),
                              _textField(
                                  title: 'Emel',
                                  initialValue:
                                      _isEdit() ? "" : "sitinabila@gmail.com"),
                              _textField(
                                  title: 'No. Kad Pengenalan',
                                  initialValue: _isEdit() ? "" : "697870984456",
                                  readOnly: _isReadOnly()),
                              _textField(
                                  title: 'No Telefon',
                                  initialValue: _isEdit() ? "" : "0198765654"),
                              _textField(
                                  title: 'Umur(Tahun)',
                                  initialValue: _isEdit() ? "" : "50",
                                  readOnly: _isReadOnly()),
                              _textField(
                                  title: 'Tahap Kesihatan',
                                  initialValue: _isEdit() ? "" : "Sihat"),
                              _textField(
                                  title: 'Jantina',
                                  initialValue: _isEdit() ? "" : "Perempuan",
                                  readOnly: _isReadOnly()),
                              _textField(
                                  title: 'Bangsa',
                                  initialValue: _isEdit() ? "" : "Melayu",
                                  readOnly: _isReadOnly()),
                              _textField(
                                title: 'Hidup',
                                initialValue: _isEdit() ? "" : "Ya",
                              ),
                              _textField(
                                title: 'Jenis Pekerjaan',
                                initialValue: _isEdit() ? "" : "Suri RUmah",
                              ),
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
            'Maklumat Pasangan',
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
