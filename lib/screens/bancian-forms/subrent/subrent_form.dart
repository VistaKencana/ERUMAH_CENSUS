import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/card_display.dart';
import 'package:eperumahan_bancian/components/custom_alertdialog.dart';
import 'package:eperumahan_bancian/components/custom_appbar.dart';
import 'package:eperumahan_bancian/components/custom_dropdown_sheet.dart';
import 'package:eperumahan_bancian/components/custom_form_field.dart';
import 'package:eperumahan_bancian/components/disability_checkbox.dart';
import 'package:eperumahan_bancian/components/kad_pengenalan_tile.dart';
import 'package:eperumahan_bancian/components/section_container.dart';
import 'package:eperumahan_bancian/components/two_column_form.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/data/api/repositories/dropdown_repository.dart';
import 'package:eperumahan_bancian/data/api/repositories/provider/dropdown_provider.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/models/subrent_input_model.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/subrent/provider/subrent_provider.dart';
import 'package:eperumahan_bancian/services/flushbar/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubrentForm extends StatefulWidget {
  final bool isExistData;
  const SubrentForm({super.key, required this.isExistData});

  @override
  State<SubrentForm> createState() => _SubrentFormState();
}

class _SubrentFormState extends State<SubrentForm> {
  final nameCtrl = TextEditingController();
  final icNoCtrl = TextEditingController();
  final noTelCtrl = TextEditingController();
  final emelCtrl = TextEditingController();
  final bangsaCtrl = TextEditingController();
  final jantinaCtrl = TextEditingController();
  final kesihatanCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  SubrentInputModel? subrentData;
  late SubrentProvider subrentProvider;
  _isNewForm() => !widget.isExistData;
  _isReadOnly() => widget.isExistData;
  @override
  void initState() {
    super.initState();
    subrentProvider = context.read<SubrentProvider>();
    initVal();
  }

  initVal() {
    if (!_isNewForm()) {
      subrentData = subrentProvider.selectedSubrent;
      // _penghuniBloc.notsubrentData.copyWith(isChangeOnImage: false);
    } else {
      subrentData = SubrentInputModel();
    }
    nameCtrl.text = setDataValue(subrentData?.name);
    icNoCtrl.text = setDataValue(subrentData?.icNo);
    emelCtrl.text = setDataValue(subrentData?.email);
    noTelCtrl.text = setDataValue(subrentData?.phoneNo);
    jantinaCtrl.text = setDataValue(subrentData?.genderDesc);
    bangsaCtrl.text = setDataValue(subrentData?.raceDesc);
    kesihatanCtrl.text = setDataValue(subrentData?.healthLevelDesc);
  }

  String setDataValue(String? val, {String? defaultVal}) {
    return val ?? (defaultVal ?? "");
    // return _isNewForm() ? "" : val ?? (defaultVal ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _exitWarning();
      },
      child: Form(
        key: formKey,
        child: BgImage(
            child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar(
            title: "",
            onPressedBack: () {
              _exitWarning();
            },
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0, bottom: 18),
                    child: Text(
                      "Maklumat Subrent",
                      style:
                          appTextStyle(size: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  KadPengenalanTile(
                    frontCard: subrentData?.uploadIcFront,
                    onFrontCard: (bytes) {
                      setState(() => subrentData = subrentData!.copyWith(
                          uploadIcFront: bytes, isChangeOnImage: true));
                    },
                    backCard: subrentData?.uploadIcBack,
                    onBackCard: (bytes) {
                      setState(() => subrentData = subrentData!.copyWith(
                          uploadIcBack: bytes, isChangeOnImage: true));
                    },
                  ),
                  SectionContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _textField(
                            title: 'Nama Penuh',
                            controller: nameCtrl,
                            isMandatory: _isNewForm(),
                            // initialValue:
                            //     _isNewForm() ? "" : ownerData?.name ?? "",
                            width: double.infinity,
                            readOnly: _isReadOnly()),
                        _gap(),
                        TwoColumnForm(
                          children: [
                            _textField(
                                title: 'No. Kad Pengenalan',
                                controller: icNoCtrl,
                                isMandatory: _isNewForm(),
                                keyboardType: TextInputType.number,
                                readOnly: _isReadOnly()),
                            _textField(
                              title: 'No Telefon',
                              controller: noTelCtrl,
                              keyboardType: TextInputType.phone,
                              isMandatory: _isNewForm(),
                            ),
                            _textField(
                              title: 'Emel',
                              controller: emelCtrl,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            _dropdownBangsa(),
                            _dropdownJantina(),
                            _dropdownKesihatan(),
                          ],
                        ),
                        _gap(),
                        DisabilityCheckbox(
                            initVal: (subrentData?.isOku == "1"),
                            onCheck: (val) {
                              setState(() {
                                subrentData = subrentData!
                                    .copyWith(isOku: val ? "1" : "0");
                              });
                            }),
                        Visibility(
                          visible: (subrentData?.isOku == "1"),
                          child: CardDisplay(
                            title: "",
                            img: subrentData?.uploadOkuCard,
                            onPicture: (bytes) {
                              setState(() {
                                subrentData = subrentData!.copyWith(
                                    uploadOkuCard: bytes,
                                    isChangeOnImage: true);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomBarButton(
            title: "Simpan Subrent",
            onTap: () {
              subrentData = subrentData!.copyWith(
                name: nameCtrl.text,
                icNo: icNoCtrl.text,
                email: emelCtrl.text,
                phoneNo: noTelCtrl.text,
              );

              if (formKey.currentState!.validate() == false) {
                //Trigger if form is not validate
                CustomFlushbar.of(context)
                    .showWarning(msg: "Sila isi maklumat diperlukan");
                return;
              }
              if (_isNewForm()) {
                subrentProvider.submitSubrent(data: subrentData!);
              } else {
                subrentProvider.updateSubrent(data: subrentData!).then((val) {
                  subrentData = subrentProvider.selectedSubrent;
                });
              }
            },
          ),
        )),
      ),
    );
  }

  _textField(
      {required String title,
      bool isMandatory = false,
      bool readOnly = false,
      bool enableDropdown = true,
      TextEditingController? controller,
      String? hintText,
      void Function(String)? onChanged,
      double? width,
      TextInputType keyboardType = TextInputType.text,
      void Function()? onTap,
      bool isDropdown = false}) {
    if (isDropdown) {
      return SizedBox(
          width: width ?? MediaQuery.sizeOf(context).width * 0.4,
          child: CustomFormField(
            title: title,
            onChanged: onChanged,
            controller: controller,
            onTap: () {
              if (onTap == null || !enableDropdown) return;
              onTap();
            },
            isMandatory: isMandatory,
            validator: isMandatory
                ? (value) {
                    if (value == null || value.isEmpty) return '';
                    return null;
                  }
                : null,
            readOnly: true,
            fillColor: Colors.white,
            hintText: hintText,
            // initialValue: _isNewForm() ? "" : initialValue,
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
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        hintText: hintText,
        onChanged: onChanged, isMandatory: isMandatory,
        validator: isMandatory
            ? (value) {
                if (value == null || value.isEmpty) return '';
                return null;
              }
            : null,
        // initialValue: _isNewForm() ? "" : initialValue,
      ),
    );
  }

  _dropdownBangsa() {
    return _textField(
      title: 'Bangsa',
      controller: bangsaCtrl,
      readOnly: _isReadOnly(),
      isMandatory: _isNewForm(),
      enableDropdown: _isNewForm(),
      isDropdown: true,
      onTap: () {
        final ddR = context.read<DropdownProvider>();
        ddR.fetchDropdownData(DdType.race).then((val) {
          CustomDropdownSheet(
            label: "Pilih Bangsa",
            items: ddR.raceList,
            onFindGroupValue: (data) {
              //Query data
              final searchData = (subrentData?.raceCode != null &&
                      (subrentData?.raceCode?.isNotEmpty ?? false))
                  ? (subrentData?.raceCode?.toLowerCase() ?? "*_*")
                  : "*_*";
              //Search
              final result = data.where((val) {
                var a = val.code?.toLowerCase().contains(searchData) ?? false;
                return a;
              }).firstOrNull;
              //return searched data
              return result;
            },
            getTitle: (data) => data.desc ?? "-",
            onChange: (val) {
              if (val == null) return;
              subrentData =
                  subrentData!.copyWith(raceCode: val.code, raceDesc: val.desc);
              bangsaCtrl.text = val.desc ?? "";
            },
            // ignore: use_build_context_synchronously
          ).show(context);
        });
      },
    );
  }

  _dropdownJantina() {
    return _textField(
      title: 'Jantina',
      isMandatory: _isNewForm(),
      controller: jantinaCtrl,
      readOnly: _isReadOnly(),
      enableDropdown: _isNewForm(),
      isDropdown: true,
      onTap: () {
        final ddR = context.read<DropdownProvider>();
        ddR.fetchDropdownData(DdType.gender).then((val) {
          CustomDropdownSheet(
            label: "Pilih Jantina",
            items: ddR.genderList,
            onFindGroupValue: (data) {
              final searchData = (subrentData?.genderCode != null &&
                      (subrentData?.genderCode?.isNotEmpty ?? false))
                  ? (subrentData?.genderCode?.toLowerCase() ?? "*_*")
                  : "*_*";
              final result = data.where((val) {
                var a = val.code?.toLowerCase().contains(searchData) ?? false;
                return a;
              }).firstOrNull;

              return result;
            },
            getTitle: (data) => data.desc ?? "-",
            onChange: (val) {
              if (val == null) return;
              subrentData = subrentData!
                  .copyWith(genderCode: val.code, genderDesc: val.desc);
              jantinaCtrl.text = val.desc ?? "";
            },
            // ignore: use_build_context_synchronously
          ).show(context);
        });
      },
    );
  }

  _dropdownKesihatan() {
    return _textField(
        title: 'Tahap Kesihatan',
        isMandatory: _isNewForm(),
        isDropdown: true,
        onTap: () {
          final ddR = context.read<DropdownProvider>();
          ddR.fetchDropdownData(DdType.healthLevel).then((val) {
            CustomDropdownSheet(
              label: "Pilih Tahap Kesihatan",
              items: ddR.healthLevelList,
              onFindGroupValue: (data) {
                final searchData = (subrentData?.healthLevelCode != null &&
                        (subrentData?.healthLevelCode?.isNotEmpty ?? false))
                    ? (subrentData?.healthLevelCode?.toLowerCase() ?? "*_*")
                    : "*_*";
                final result = data.where((val) {
                  var a = val.code?.toLowerCase().contains(searchData) ?? false;
                  return a;
                }).firstOrNull;
                return result;
              },
              getTitle: (data) => data.desc ?? "-",
              onChange: (val) {
                if (val == null) return;
                subrentData = subrentData!.copyWith(
                    healthLevelCode: val.code, healthLevelDesc: val.desc);
                kesihatanCtrl.text = val.desc ?? "";
              },
              // ignore: use_build_context_synchronously
            ).show(context);
          });
        },
        controller: kesihatanCtrl);
  }

  _gap({double height = 10}) => SizedBox(height: height);
  _exitWarning() {
    CustomAlertDialog(
      title: "Berhenti banci penghuni?",
      subtitle: "Adakah anda akan berhenti membuat bancian untuk penghuni?",
      colorBtnLabel: "Ya",
      onColorBtn: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
      dimmedBtnLabel: "Kembali",
      onDimmedBtn: () => Navigator.pop(context),
    ).show(context);
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    icNoCtrl.dispose();
    emelCtrl.dispose();
    noTelCtrl.dispose();
    jantinaCtrl.dispose();
    bangsaCtrl.dispose();
    super.dispose();
  }
}
