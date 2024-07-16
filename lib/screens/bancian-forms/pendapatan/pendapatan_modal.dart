import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/custom_form_field.dart';
import 'package:eperumahan_bancian/components/two_column_form.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_underline_field.dart';

class PendapatanModal extends StatefulWidget {
  final bool? isEdit;
  const PendapatanModal({super.key, this.isEdit});

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
  State<PendapatanModal> createState() => _PendapatanModalState();
}

class _PendapatanModalState extends State<PendapatanModal> {
  _isEdit() => (widget.isEdit != null && widget.isEdit == true);
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      maxChildSize: 0.8,
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
            'Maklumat Pendapatan',
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

  formV1() {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Column(
              children: [
                const CustomUnderlineField(
                  title: "Nama",
                  initialValue: "Arif Aiman",
                ),
                const SizedBox(height: 16),
                CustomUnderlineField(
                  title: "Alamat Majikan",
                  initialValue: _isEdit()
                      ? ""
                      : "No. 1 Jalan 2 Taman Perindustrian, 50300 Kuala Lumpur",
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 14),
              child: TwoColumnForm(
                children: [
                  _textField(title: 'Gaji Pokok (RM)', initialValue: "1800"),
                  _textField(title: 'Elaun (RM)', initialValue: "0.00"),
                  _textField(
                      title: 'Lain-lain Pendapatan', initialValue: "Tiada"),
                  _textField(title: 'Bantuan Kewangan', initialValue: "Tiada"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  formV2() {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Column(
              children: [
                const CustomFormField(
                  title: "Nama",
                  initialValue: "Arif Aiman",
                ),
                const SizedBox(height: 16),
                CustomFormField(
                  title: "Alamat Majikan",
                  initialValue: _isEdit()
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
                _textFieldV2(
                    title: 'Gaji Pokok (RM)',
                    hintText: "0.00",
                    initialValue: "1800"),
                _textFieldV2(
                    title: 'Elaun (RM)',
                    hintText: "0.00",
                    initialValue: "0.00"),
                _textFieldV2(
                    title: 'Lain-lain Pendapatan', initialValue: "Tiada"),
                _textFieldV2(title: 'Bantuan Kewangan', initialValue: "Tiada"),
              ],
            ),
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
      String? hintText,
      double? width}) {
    return SizedBox(
      width: width ?? MediaQuery.sizeOf(context).width * 0.4,
      child: CustomFormField(
        title: title,
        readOnly: readOnly,
        hintText: hintText,
        initialValue: _isEdit() ? "" : initialValue,
      ),
    );
  }
}
