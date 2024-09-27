import 'dart:typed_data';

import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/card_display.dart';
import 'package:eperumahan_bancian/components/custom_form_field.dart';
import 'package:eperumahan_bancian/components/disability_checkbox.dart';
import 'package:eperumahan_bancian/components/file_display.dart';
import 'package:eperumahan_bancian/components/kad_pengenalan_tile.dart';
import 'package:eperumahan_bancian/components/section_container.dart';
import 'package:eperumahan_bancian/components/two_column_form.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/data/api/repositories/dropdown_repository.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_dropdown_sheet.dart';
import '../../../data/api/repositories/bloc/dropddown_bloc/dropdown_bloc.dart';

class PenghuniForm extends StatefulWidget {
  final bool? isNewForm;
  final List<Uint8List> imgs;
  const PenghuniForm({super.key, this.isNewForm, required this.imgs});

  @override
  State<PenghuniForm> createState() => _PenghuniFormState();
}

class _PenghuniFormState extends State<PenghuniForm> {
  bool _isNewForm() => (widget.isNewForm != null && widget.isNewForm == true);
  bool _isReadOnly() => _isNewForm() ? false : true;
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
    // Size size = MediaQuery.sizeOf(context);
    return BgImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: "",
          actions: _isNewForm()
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
                SectionContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _textField(
                          title: 'Nama Penuh',
                          initialValue: _isNewForm() ? "" : "Arif Aiman",
                          width: double.infinity,
                          readOnly: _isReadOnly()),
                      _gap(),
                      TwoColumnForm(
                        children: [
                          _textField(
                              title: 'Bilangan Isi Rumah', initialValue: "2"),
                          _textField(
                              title: 'No. Kad Pengenalan',
                              initialValue: _isNewForm() ? "" : "7056448140568",
                              readOnly: _isReadOnly()),
                          _textField(
                              title: 'Emel',
                              initialValue:
                                  _isNewForm() ? "" : "arifaiman@gmail.com"),
                          _textField(
                              title: 'Umur(Tahun)',
                              initialValue: _isNewForm() ? "" : "50",
                              readOnly: _isReadOnly()),
                          _textField(
                              title: 'No Telefon',
                              initialValue: _isNewForm() ? "" : "0186456762"),
                          _dropdownJantina(),
                          _dropdownBangsa(),
                          _dropdownJenisPekerjaan(),
                          _dropdownStatusPerkahwinan(),
                        ],
                      ),
                      _gap(),
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
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                SectionContainer(
                  child: Column(
                    children: [
                      _headerTitle(),
                      maklumatPendapatan(),
                    ],
                  ),
                )
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

  _dropdownJantina() {
    return BlocListener<DropdownBloc, DropdownState>(
      listener: (context, state) {
        if (_isNewForm()) return;
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
          initialValue: _isNewForm() ? "" : "Lelaki"),
    );
  }

  _dropdownBangsa() {
    return BlocListener<DropdownBloc, DropdownState>(
      listener: (context, state) {
        if (state is DropdownSuccess) {
          if (_isNewForm()) return;
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

  _dropdownJenisPekerjaan() {
    return BlocListener<DropdownBloc, DropdownState>(
      listener: (context, state) {
        if (state is DropdownSuccess) {
          if (_isNewForm()) return;
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

  _dropdownStatusPerkahwinan() {
    return BlocListener<DropdownBloc, DropdownState>(
      listener: (context, state) {
        if (state is DropdownSuccess) {
          if (_isNewForm()) return;
          if (state.type == DdType.maritalStatus) {
            CustomDropdownSheet(
              label: 'Status Perkahwinan',
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
          title: 'Status Perkahwinan',
          isDropdown: true,
          onTap: () {
            _dropdownBloc
                .add(const FetchDdFormData(type: DdType.maritalStatus));
          },
          initialValue: _isNewForm() ? "" : "Berkahwin dan Tiada Anak"),
    );
  }

  _headerTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 12, bottom: 6),
      child: Row(
        children: [
          Text(
            'Maklumat Pendapatan',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Spacer(),
        ],
      ),
    );
  }

  maklumatPendapatan() {
    return Column(
      children: [
        const SizedBox(height: 10),
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
    );
  }

  _gap({double height = 10}) => SizedBox(height: height);
}
