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
import 'package:eperumahan_bancian/screens/bancian-forms/models/owner_input_model.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/penghuni/bloc/penghuni_bloc.dart';
import 'package:eperumahan_bancian/services/flushbar/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../components/custom_alertdialog.dart';
import '../../../components/custom_appbar.dart';
import '../../../components/custom_dropdown_sheet.dart';
// import '../../../data/api/repositories/bloc/dropddown_bloc/dropdown_bloc.dart';
import '../../../data/api/repositories/provider/dropdown_provider.dart';

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
  // late DropdownBloc _dropdownBloc;
  late PenghuniBloc _penghuniBloc;
  OwnerInputModel? ownerData;
  final nameCtrl = TextEditingController();
  final bilIsiRumahCtrl = TextEditingController();
  final icNoCtrl = TextEditingController();
  final emelCtrl = TextEditingController();
  final umurCtrl = TextEditingController();
  final noTelCtrl = TextEditingController();
  final jantinaCtrl = TextEditingController();
  final bangsaCtrl = TextEditingController();
  final jenisKerjaCtrl = TextEditingController();
  final statusKahwinCtrl = TextEditingController();
  final kesihatanCtrl = TextEditingController();
  final namaMajikanCtrl = TextEditingController();
  final majikanAddressCtrl = TextEditingController();
  final gajiPokokCtrl = TextEditingController();
  final elaunCtrl = TextEditingController();
  final lainPendapatanCtrl = TextEditingController();
  final bantuanCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // _dropdownBloc = BlocProvider.of<DropdownBloc>(context, listen: false);
    _penghuniBloc = BlocProvider.of<PenghuniBloc>(context, listen: false);

    initVal();
  }

  initVal() {
    if (_isNewForm()) {
      ownerData = _penghuniBloc.notOwnerData.copyWith(isChangeOnImage: false);
    } else {
      ownerData = _penghuniBloc.existData.copyWith(isChangeOnImage: false);
    }
    nameCtrl.text = setDataValue(ownerData?.name);
    bilIsiRumahCtrl.text =
        setDataValue(ownerData?.totalHousehold, defaultVal: "0");
    icNoCtrl.text = setDataValue(ownerData?.icNo);
    emelCtrl.text = setDataValue(ownerData?.email);
    umurCtrl.text = setDataValue(ownerData?.age);
    noTelCtrl.text = setDataValue(ownerData?.phoneNo);
    jantinaCtrl.text = setDataValue(ownerData?.genderDesc);
    bangsaCtrl.text = setDataValue(ownerData?.raceDesc);
    jenisKerjaCtrl.text = setDataValue(ownerData?.occupationTypeDesc);
    statusKahwinCtrl.text = setDataValue(ownerData?.maritalStatusDesc);
    namaMajikanCtrl.text = setDataValue(ownerData?.companyName);
    majikanAddressCtrl.text = setDataValue(ownerData?.workAddress);
    gajiPokokCtrl.text = setDataValue(ownerData?.workSalary);
    elaunCtrl.text = setDataValue(ownerData?.workAllowance);
    lainPendapatanCtrl.text = setDataValue(ownerData?.workOtherIncome);
    bantuanCtrl.text = setDataValue(ownerData?.welfareAid);
    kesihatanCtrl.text = setDataValue(ownerData?.healthLevelDesc);
  }

  String setDataValue(String? val, {String? defaultVal}) {
    return val ?? (defaultVal ?? "");
    // return _isNewForm() ? "" : val ?? (defaultVal ?? "");
  }

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
  Widget build(BuildContext context) {
    // Size size = MediaQuery.sizeOf(context);
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
                                      builder: (_) => const BancianMainScreen(
                                            isNewForm: true,
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
            body: BlocListener<PenghuniBloc, PenghuniState>(
              listener: (context, state) {
                if (state is PenghuniLoading) {
                  EasyLoading.show();
                } else if (state is PenghuniSuccess) {
                  EasyLoading.dismiss();
                  setState(() =>
                      ownerData = ownerData!.copyWith(isChangeOnImage: false));
                  CustomFlushbar.of(context)
                      .showSuccess(msg: "Berjaya menmyimpan data");
                } else if (state is PenghuniNoChanges) {
                  CustomFlushbar.of(context).showInfo(msg: state.msg);
                } else if (state is PenghuniError) {
                  EasyLoading.dismiss();
                  CustomFlushbar.of(context).showFailed(msg: state.msg);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0, bottom: 18),
                        child: Text(
                          "Maklumat Penghuni",
                          style: appTextStyle(
                              size: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      KadPengenalanTile(
                        frontCard: ownerData?.uploadIcFront,
                        onFrontCard: (bytes) {
                          setState(() => ownerData = ownerData!.copyWith(
                              uploadIcFront: bytes, isChangeOnImage: true));
                        },
                        backCard: ownerData?.uploadIcBack,
                        onBackCard: (bytes) {
                          setState(() => ownerData = ownerData!.copyWith(
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
                                    title: 'Bilangan Isi Rumah',
                                    keyboardType: TextInputType.number,
                                    controller: bilIsiRumahCtrl),
                                _textField(
                                    title: 'No. Kad Pengenalan',
                                    controller: icNoCtrl,
                                    isMandatory: _isNewForm(),
                                    keyboardType: TextInputType.number,
                                    readOnly: _isReadOnly()),
                                _textField(
                                  title: 'Emel',
                                  controller: emelCtrl,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                _textField(
                                    title: 'Umur(Tahun)',
                                    controller: umurCtrl,
                                    readOnly: _isReadOnly()),
                                _textField(
                                  title: 'No Telefon',
                                  controller: noTelCtrl,
                                  keyboardType: TextInputType.phone,
                                  isMandatory: _isNewForm(),
                                ),
                                _dropdownJantina(),
                                _dropdownBangsa(),
                                _dropdownJenisPekerjaan(),
                                _dropdownStatusPerkahwinan(),
                                _dropdownKesihatan(),
                              ],
                            ),
                            _gap(),
                            DisabilityCheckbox(
                                initVal: (ownerData?.isOku == "1"),
                                onCheck: (val) {
                                  setState(() {
                                    ownerData = ownerData!
                                        .copyWith(isOku: val ? "1" : "0");
                                  });
                                }),
                            Visibility(
                              visible: (ownerData?.isOku == "1"),
                              child: CardDisplay(
                                title: "",
                                img: ownerData?.uploadOkuCard,
                                onPicture: (bytes) => setState(() {
                                  ownerData = ownerData!.copyWith(
                                      uploadOkuCard: bytes,
                                      isChangeOnImage: true);
                                }),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      SectionContainer(
                        child: Column(
                          children: [
                            _headerTitle('Sijil Perkahwinan'),
                            FileDisplay(
                              img: ownerData!.uploadMarriageCert,
                              onPicture: (bytes) => setState(() => setState(
                                  () => ownerData = ownerData!
                                      .copyWith(uploadMarriageCert: bytes))),
                            )
                          ],
                        ),
                      ),
                      SectionContainer(
                        child: Column(
                          children: [
                            _headerTitle('Maklumat Pendapatan'),
                            maklumatPendapatan(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomBarButton(
                onTap: () {
                  setState(() {
                    ownerData = ownerData!.copyWith(
                      name: nameCtrl.text,
                      totalHousehold: bilIsiRumahCtrl.text,
                      icNo: icNoCtrl.text,
                      email: emelCtrl.text,
                      phoneNo: noTelCtrl.text,
                      companyName: namaMajikanCtrl.text,
                      workAddress: majikanAddressCtrl.text,
                      workSalary: gajiPokokCtrl.text,
                      workAllowance: elaunCtrl.text,
                      workOtherIncome: lainPendapatanCtrl.text,
                      welfareAid: bantuanCtrl.text,
                    );
                  });
                  if (_isNewForm()) {
                    _penghuniBloc.add(SaveBukanPenghuniData(data: ownerData!));
                  } else {
                    _penghuniBloc.add(SavePenghuniData(data: ownerData!));
                  }
                },
                title: "Simpan"),
          ),
        ),
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
              title: "Nama Majikan",
              controller: namaMajikanCtrl,
              contentPadding: const EdgeInsets.all(8),
            ),
            const SizedBox(height: 12),
            CustomFormField(
              title: "Alamat Majikan",
              controller: majikanAddressCtrl,
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
                controller: gajiPokokCtrl),
            _textField(
              title: 'Elaun (RM)',
              hintText: "0.00",
              controller: elaunCtrl,
            ),
            _textField(
                title: 'Lain-lain Pendapatan', controller: lainPendapatanCtrl),
            _textField(
              title: 'Bantuan Kewangan',
              controller: bantuanCtrl,
            ),
          ],
        ),
        const SizedBox(height: 10),
        FileDisplay(
          title: "Slip Gaji / Penyata KWSP",
          isMandatory: true,
          img: ownerData!.uploadIncome,
          onPicture: (bytes) => setState(() => setState(
              () => ownerData = ownerData!.copyWith(uploadIncome: bytes))),
        )
      ],
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
              final searchData = (ownerData?.genderCode != null &&
                      (ownerData?.genderCode?.isNotEmpty ?? false))
                  ? (ownerData?.genderCode?.toLowerCase() ?? "*_*")
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
              ownerData = ownerData!
                  .copyWith(genderCode: val.code, genderDesc: val.desc);
              jantinaCtrl.text = val.desc ?? "";
            },
            // ignore: use_build_context_synchronously
          ).show(context);
        });
      },
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
              final searchData = (ownerData?.raceCode != null &&
                      (ownerData?.raceCode?.isNotEmpty ?? false))
                  ? (ownerData?.raceCode?.toLowerCase() ?? "*_*")
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
              ownerData =
                  ownerData!.copyWith(raceCode: val.code, raceDesc: val.desc);
              bangsaCtrl.text = val.desc ?? "";
            },
            // ignore: use_build_context_synchronously
          ).show(context);
        });
      },
    );
  }

  _dropdownJenisPekerjaan() {
    return _textField(
      title: 'Jenis Pekerjaan',
      controller: jenisKerjaCtrl,
      isDropdown: true,
      isMandatory: _isNewForm(),
      onTap: () {
        final ddR = context.read<DropdownProvider>();
        ddR.fetchDropdownData(DdType.occupationType).then((val) {
          CustomDropdownSheet(
            label: "Pilih Jenis Pekerjaan",
            items: ddR.occupationTypeList,
            onFindGroupValue: (data) {
              final searchData = (ownerData?.occupationTypeCode != null &&
                      (ownerData?.occupationTypeCode?.isNotEmpty ?? false))
                  ? (ownerData?.occupationTypeCode?.toLowerCase() ?? "*_*")
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
              ownerData = ownerData!.copyWith(
                  occupationTypeCode: val.code, occupationTypeDesc: val.desc);
              jenisKerjaCtrl.text = val.desc ?? "";
            },
            // ignore: use_build_context_synchronously
          ).show(context);
        });
      },
    );
  }

  _dropdownStatusPerkahwinan() {
    return _textField(
      title: 'Status Perkahwinan',
      controller: statusKahwinCtrl,
      isMandatory: _isNewForm(),
      isDropdown: true,
      onTap: () {
        final ddR = context.read<DropdownProvider>();
        ddR.fetchDropdownData(DdType.maritalStatus).then((val) {
          CustomDropdownSheet(
            label: 'Status Perkahwinan',
            items: ddR.maritalStatusList,
            onFindGroupValue: (data) {
              final searchData = (ownerData?.maritalStatusCode != null &&
                      (ownerData?.maritalStatusCode?.isNotEmpty ?? false))
                  ? (ownerData?.maritalStatusCode?.toLowerCase() ?? "*_*")
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
              ownerData = ownerData!.copyWith(
                  maritalStatusCode: val.code, maritalStatusDesc: val.desc);
              statusKahwinCtrl.text = val.desc ?? "";
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
                final searchData = (ownerData?.healthLevelCode != null &&
                        (ownerData?.healthLevelCode?.isNotEmpty ?? false))
                    ? (ownerData?.healthLevelCode?.toLowerCase() ?? "*_*")
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
                ownerData = ownerData!.copyWith(
                    healthLevelCode: val.code, healthLevelDesc: val.desc);
                kesihatanCtrl.text = val.desc ?? "";
              },
              // ignore: use_build_context_synchronously
            ).show(context);
          });
        },
        controller: kesihatanCtrl);
  }

  _headerTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  _gap({double height = 10}) => SizedBox(height: height);

  @override
  void dispose() {
    nameCtrl.dispose();
    bilIsiRumahCtrl.dispose();
    icNoCtrl.dispose();
    emelCtrl.dispose();
    umurCtrl.dispose();
    noTelCtrl.dispose();
    jantinaCtrl.dispose();
    bangsaCtrl.dispose();
    jenisKerjaCtrl.dispose();
    statusKahwinCtrl.dispose();
    super.dispose();
  }
}
