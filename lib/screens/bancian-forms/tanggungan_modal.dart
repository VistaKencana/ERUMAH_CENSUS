import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/kad_pengenalan_tile.dart';
import 'package:eperumahan_bancian/components/two_column_form.dart';
import 'package:flutter/material.dart';

import '../../components/custom_underline_field.dart';

class TanggunganModal extends StatefulWidget {
  const TanggunganModal({super.key});

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
                              horizontal: 6, vertical: 14),
                          child: TwoColumnForm(
                            children: [
                              _textField(
                                  title: 'Nama Tanggungan', readOnly: true),
                              _textField(
                                  title: 'Hubungan Dengan Penyewa',
                                  readOnly: true),
                              _textField(
                                  title: 'No. Kad Pengenalan', readOnly: true),
                              _textField(title: 'Emel'),
                              _textField(title: 'Umur(Tahun)', readOnly: true),
                              _textField(title: 'Tahap Kesihatan'),
                              _textField(title: 'No. Telefon', readOnly: true),
                              _textField(title: 'Jantina', readOnly: true),
                              _textField(title: 'Kecacatan (OKU)'),
                              _textField(title: 'Bangsa'),
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
}
