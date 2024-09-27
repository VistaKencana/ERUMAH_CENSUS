import 'dart:typed_data';

import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/card_display.dart';
import 'package:eperumahan_bancian/components/custom_dropdown_sheet.dart';
import 'package:eperumahan_bancian/components/custom_form_field.dart';
import 'package:eperumahan_bancian/components/kad_pengenalan_tile.dart';
import 'package:eperumahan_bancian/components/switch_modal.dart';
import 'package:eperumahan_bancian/components/two_column_form.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/data/api/repositories/bloc/dropddown_bloc/dropdown_bloc.dart';
import 'package:eperumahan_bancian/data/api/repositories/dropdown_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  bool isOKU = false;
  late DropdownBloc _dropdownBloc;
  @override
  void initState() {
    super.initState();
    _dropdownBloc = BlocProvider.of<DropdownBloc>(context, listen: false);
  }

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
                      _dropdownKesihatan(),
                      _dropdownJantina(),
                      _dropdownBangsa(),
                      _textField(
                          title: 'Hidup',
                          initialValue: "Ya",
                          isDropdown: true,
                          onTap: () {
                            SwitchModal(
                                    label: "Pilih status",
                                    getTitle: (data) => data.desc!,
                                    onChange: (val) {})
                                .show(context);
                          }),
                      _dropdownJenisPekerjaan(),
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
                    DisabilityCheckbox(
                        initVal: isOKU,
                        onCheck: (val) {
                          setState(() => isOKU = val);
                        }),
                    Visibility(
                      visible: isOKU,
                      child: CardDisplay(
                        title: "",
                        img: okuCard,
                        onPicture: (bytes) => setState(() => okuCard = bytes),
                      ),
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

  // _textField(
  //     {required String title,
  //     String? initialValue,
  //     bool readOnly = false,
  //     String? hintText,
  //     double? width}) {
  //   return SizedBox(
  //     width: width ?? MediaQuery.sizeOf(context).width * 0.4,
  //     child: CustomFormField(
  //       title: title,
  //       readOnly: readOnly,
  //       hintText: hintText,
  //       initialValue: _isNewForm() ? "" : initialValue,
  //     ),
  //   );
  // }
  _textField(
      {required String title,
      String? initialValue,
      bool readOnly = false,
      bool enableDropdown = true,
      String? hintText,
      double? width,
      void Function()? onTap,
      bool isDropdown = false}) {
    if (isDropdown) {
      return SizedBox(
          width: width ?? MediaQuery.sizeOf(context).width * 0.4,
          child: CustomFormField(
            title: title,
            onTap: () {
              if (onTap == null || !enableDropdown) return;
              onTap();
            },
            readOnly: true,
            fillColor: Colors.white,
            hintText: hintText,
            initialValue: _isNewForm() ? "" : initialValue,
            suffixWidget: isDropdown
                ? Icon(
                    Icons.arrow_drop_down,
                    color: readOnly ? Colors.grey : Colors.black,
                  )
                : null,
          ));
    }
    return SizedBox(
      width: width ?? MediaQuery.sizeOf(context).width * 0.4,
      child: CustomFormField(
        title: title,
        onTap: onTap,
        readOnly: readOnly,
        hintText: hintText,
        initialValue: _isNewForm() ? "" : initialValue,
      ),
    );
  }

  _dropdownBangsa() {
    return BlocListener<DropdownBloc, DropdownState>(
      listener: (context, state) {
        if (state is DropdownSuccess) {
          if (state.type == DdType.race) {
            CustomDropdownSheet(
              label: "Pilih Bangsa",
              items: state.data,
              // onFindGroupValue: (data) {
              //   return data.where((val) {
              //     var a = val?.desc
              //             ?.toLowerCase()
              //             .contains("selesai") ??
              //         false;
              //     return a;
              //   }).firstOrNull;
              // },
              getTitle: (data) => data?.desc ?? "-",
              onChange: (val) {},
            ).show(context);
          }
        }
      },
      child: _textField(
        title: 'Bangsa',
        readOnly: _isReadOnly(),
        enableDropdown: _isNewForm(),
        initialValue: _isNewForm() ? "" : "Melayu",
        isDropdown: true,
        onTap: () {
          _dropdownBloc.add(const FetchDdFormData(type: DdType.race));
        },
      ),
    );
  }

  _dropdownJantina() {
    return BlocListener<DropdownBloc, DropdownState>(
      listener: (context, state) {
        if (state is DropdownSuccess) {
          if (state.type == DdType.gender) {
            CustomDropdownSheet(
              label: "Pilih Jantina",
              items: state.data,
              // onFindGroupValue: (data) {
              //   return data.where((val) {
              //     var a = val?.desc
              //             ?.toLowerCase()
              //             .contains("selesai") ??
              //         false;
              //     return a;
              //   }).firstOrNull;
              // },
              getTitle: (data) => data?.desc ?? "-",
              onChange: (val) {},
            ).show(context);
          }
        }
      },
      child: _textField(
          title: 'Jantina',
          readOnly: _isReadOnly(),
          enableDropdown: _isNewForm(),
          isDropdown: true,
          onTap: () {
            _dropdownBloc.add(const FetchDdFormData(type: DdType.gender));
          },
          initialValue: _isNewForm() ? "" : "Perempuan"),
    );
  }

  _dropdownKesihatan() {
    return BlocListener<DropdownBloc, DropdownState>(
      listener: (context, state) {
        if (state is DropdownSuccess) {
          if (state.type == DdType.healthLevel) {
            CustomDropdownSheet(
              label: "Pilih Tahap Kesihatan",
              items: state.data,
              // onFindGroupValue: (data) {
              //   return data.where((val) {
              //     var a = val?.desc
              //             ?.toLowerCase()
              //             .contains("selesai") ??
              //         false;
              //     return a;
              //   }).firstOrNull;
              // },
              getTitle: (data) => data?.desc ?? "-",
              onChange: (val) {},
            ).show(context);
          }
        }
      },
      child: _textField(
          title: 'Tahap Kesihatan',
          isDropdown: true,
          onTap: () {
            _dropdownBloc.add(const FetchDdFormData(type: DdType.healthLevel));
          },
          initialValue: _isNewForm() ? "" : "Sihat"),
    );
  }

  _dropdownJenisPekerjaan() {
    return BlocListener<DropdownBloc, DropdownState>(
      listener: (context, state) {
        if (state is DropdownSuccess) {
          if (state.type == DdType.occupationType) {
            CustomDropdownSheet(
              label: "Pilih Jenis Pekerjaan",
              items: state.data,
              // onFindGroupValue: (data) {
              //   return data.where((val) {
              //     var a = val?.desc
              //             ?.toLowerCase()
              //             .contains("selesai") ??
              //         false;
              //     return a;
              //   }).firstOrNull;
              // },
              getTitle: (data) => data?.desc ?? "-",
              onChange: (val) {},
            ).show(context);
          }
        }
      },
      child: _textField(
          title: 'Jenis Pekerjaan',
          isDropdown: true,
          onTap: () {
            _dropdownBloc
                .add(const FetchDdFormData(type: DdType.occupationType));
          },
          initialValue: _isNewForm() ? "" : "Swasta"),
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
