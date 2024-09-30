import 'dart:typed_data';

import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/card_display.dart';
import 'package:eperumahan_bancian/components/custom_dropdown_sheet.dart';
import 'package:eperumahan_bancian/components/custom_form_field.dart';
import 'package:eperumahan_bancian/components/kad_pengenalan_tile.dart';
import 'package:eperumahan_bancian/components/two_column_form.dart';
import 'package:eperumahan_bancian/data/api/repositories/dropdown_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/disability_checkbox.dart';
import '../../../data/api/repositories/bloc/dropddown_bloc/dropdown_bloc.dart';

class AnakModal extends StatefulWidget {
  final bool? isEdit;
  const AnakModal({super.key, this.isEdit});
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
  State<AnakModal> createState() => _AnakModalState();
}

class _AnakModalState extends State<AnakModal> {
  _isEdit() => (widget.isEdit != null && widget.isEdit == true);
  _isReadOnly() => _isEdit() ? false : true;
  late DropdownBloc _dropdownBloc;
  Uint8List? frontCard;
  Uint8List? backCard;
  Uint8List? okuCard;
  bool isOKU = false;
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
                                  title: 'Nama Anak',
                                  initialValue: "Nur Fatin",
                                  width: double.infinity,
                                  readOnly: _isReadOnly()),
                              _gap(height: 14),
                              TwoColumnForm(
                                children: [
                                  _dropdownHubungan(),
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
                                  _dropdownKesihatan(),
                                  _textField(
                                      title: 'No. Telefon',
                                      initialValue: "01645678642",
                                      readOnly: _isReadOnly()),
                                  _dropdownJantina(),
                                  _dropdownBangsa(),
                                ],
                              ),
                              _gap(height: 14),
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
                                  onPicture: (bytes) =>
                                      setState(() => okuCard = bytes),
                                ),
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
    String title = 'Anak';
    return prefix + title;
  }

  _gap({double height = 10}) => SizedBox(height: height);

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
            initialValue: _isEdit() ? "" : initialValue,
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
        initialValue: _isEdit() ? "" : initialValue,
      ),
    );
  }

  _dropdownHubungan() {
    return BlocListener<DropdownBloc, DropdownState>(
      listener: (context, state) {
        if (state is DropdownSuccess) {
          if (state.type == DdType.relationship) {
            CustomDropdownSheet(
              label: "Hubungan Dengan Penyewa",
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
          title: 'Hubungan Dengan Penyewa',
          isDropdown: true,
          enableDropdown: _isEdit(),
          onTap: () {
            _dropdownBloc.add(const FetchDdFormData(type: DdType.relationship));
          },
          initialValue: _isEdit() ? "" : "Anak"),
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
          initialValue: _isEdit() ? "" : "Sihat"),
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
          enableDropdown: _isEdit(),
          isDropdown: true,
          onTap: () {
            _dropdownBloc.add(const FetchDdFormData(type: DdType.gender));
          },
          initialValue: _isEdit() ? "" : "Perempuan"),
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
        enableDropdown: _isEdit(),
        initialValue: _isEdit() ? "" : "Melayu",
        isDropdown: true,
        onTap: () {
          _dropdownBloc.add(const FetchDdFormData(type: DdType.race));
        },
      ),
    );
  }
}
