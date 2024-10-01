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
  final majikanAddressCtrl = TextEditingController();
  final gajiPokokCtrl = TextEditingController();
  final elaunCtrl = TextEditingController();
  final lainPendapatanCtrl = TextEditingController();
  final bantuanCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dropdownBloc = BlocProvider.of<DropdownBloc>(context, listen: false);
    _penghuniBloc = BlocProvider.of<PenghuniBloc>(context, listen: false);
    ownerData = _penghuniBloc.existData!.copyWith();
    initVal();
  }

  initVal() {
    nameCtrl.text = setDataValue(ownerData?.name);
    bilIsiRumahCtrl.text =
        setDataValue(ownerData?.totalHousehold, defaultVal: "0");
    icNoCtrl.text = setDataValue(ownerData?.icNo);
    emelCtrl.text = setDataValue(ownerData?.email);
    umurCtrl.text = setDataValue("", defaultVal: "50");
    noTelCtrl.text = setDataValue(ownerData?.phoneNo);
    jantinaCtrl.text = setDataValue(ownerData?.genderDesc);
    bangsaCtrl.text = setDataValue(ownerData?.raceDesc);
    jenisKerjaCtrl.text = setDataValue(ownerData?.occupationTypeDesc);
    statusKahwinCtrl.text = setDataValue(ownerData?.maritalStatusDesc);
    majikanAddressCtrl.text = setDataValue(ownerData?.workAddress);
    gajiPokokCtrl.text = setDataValue(ownerData?.workSalary);
    elaunCtrl.text = setDataValue(ownerData?.workAllowance);
    lainPendapatanCtrl.text = setDataValue(ownerData?.workOtherIncome);
    bantuanCtrl.text = setDataValue(ownerData?.welfareAid);
  }

  String setDataValue(String? val, {String? defaultVal}) {
    return _isNewForm() ? "" : val ?? (defaultVal ?? "");
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
        body: BlocListener<PenghuniBloc, PenghuniState>(
          listener: (context, state) {
            if (state is PenghuniLoading) {
              EasyLoading.show();
            } else if (state is PenghuniSuccess) {
              EasyLoading.dismiss();
              CustomFlushbar.of(context)
                  .showSuccess(msg: "Berjaya menmyimpan data");
            } else if (state is PenghuniError) {
              EasyLoading.dismiss();
              CustomFlushbar.of(context).showFailed(msg: state.msg);
            }
          },
          child: Padding(
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
                      style:
                          appTextStyle(size: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  KadPengenalanTile(
                    frontCard: ownerData?.uploadIcFront,
                    onFrontCard: (bytes) {
                      setState(() => ownerData =
                          ownerData!.copyWith(uploadIcFront: bytes));
                    },
                    backCard: ownerData?.uploadIcBack,
                    onBackCard: (bytes) {
                      setState(() =>
                          ownerData = ownerData!.copyWith(uploadIcBack: bytes));
                    },
                  ),
                  SectionContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _textField(
                            title: 'Nama Penuh',
                            controller: nameCtrl,
                            // initialValue:
                            //     _isNewForm() ? "" : ownerData?.name ?? "",
                            width: double.infinity,
                            readOnly: _isReadOnly()),
                        _gap(),
                        TwoColumnForm(
                          children: [
                            _textField(
                                title: 'Bilangan Isi Rumah',
                                controller: bilIsiRumahCtrl),
                            _textField(
                                title: 'No. Kad Pengenalan',
                                controller: icNoCtrl,
                                readOnly: _isReadOnly()),
                            _textField(title: 'Emel', controller: emelCtrl),
                            _textField(
                                title: 'Umur(Tahun)',
                                controller: umurCtrl,
                                readOnly: _isReadOnly()),
                            _textField(
                                title: 'No Telefon', controller: noTelCtrl),
                            _dropdownJantina(),
                            _dropdownBangsa(),
                            _dropdownJenisPekerjaan(),
                            _dropdownStatusPerkahwinan(),
                          ],
                        ),
                        _gap(),
                        DisabilityCheckbox(
                            initVal: (ownerData?.isOku == "1"),
                            onCheck: (val) {
                              setState(() {
                                ownerData =
                                    ownerData!.copyWith(isOku: val ? "1" : "0");
                              });
                            }),
                        Visibility(
                          visible: (ownerData?.isOku == "1"),
                          child: CardDisplay(
                            title: "",
                            img: ownerData?.uploadOkuCard,
                            onPicture: (bytes) => setState(() {
                              ownerData =
                                  ownerData!.copyWith(uploadOkuCard: bytes);
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
                        _headerTitle(),
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
                    workAddress: majikanAddressCtrl.text,
                    workSalary: gajiPokokCtrl.text,
                    workAllowance: elaunCtrl.text,
                    workOtherIncome: lainPendapatanCtrl.text,
                    welfareAid: bantuanCtrl.text);
              });
              _penghuniBloc.add(SavePenghuniData(data: ownerData!));
              // Navigator.pop(context);
            },
            title: "Simpan"),
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
      String? initialValue,
      bool readOnly = false,
      bool enableDropdown = true,
      TextEditingController? controller,
      String? hintText,
      void Function(String)? onChanged,
      double? width,
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
        controller: controller,
        readOnly: readOnly,
        hintText: hintText,
        onChanged: onChanged,
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
              onFindGroupValue: (data) {
                return data.where((val) {
                  var a = val?.code?.toLowerCase().contains(
                          ownerData?.genderCode.toLowerCase() ?? "") ??
                      false;
                  return a;
                }).firstOrNull;
              },
              getTitle: (data) => data?.desc ?? "-",
              onChange: (val) {
                if (val == null) return;
                ownerData = ownerData!
                    .copyWith(genderCode: val.code, genderDesc: val.desc);
                jantinaCtrl.text = val.desc ?? "";
              },
            ).show(context);
          }
        }
      },
      child: _textField(
        title: 'Jantina',
        controller: jantinaCtrl,
        readOnly: _isReadOnly(),
        enableDropdown: _isNewForm(),
        isDropdown: true,
        onTap: () {
          _dropdownBloc.add(const FetchDdFormData(type: DdType.gender));
        },
      ),
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
              onFindGroupValue: (data) {
                return data.where((val) {
                  var a = val?.code
                          ?.toLowerCase()
                          .contains(ownerData?.raceCode.toLowerCase() ?? "") ??
                      false;
                  return a;
                }).firstOrNull;
              },
              getTitle: (data) => data?.desc ?? "-",
              onChange: (val) {
                if (val == null) return;
                ownerData =
                    ownerData!.copyWith(raceCode: val.code, raceDesc: val.desc);
                bangsaCtrl.text = val.desc ?? "";
              },
            ).show(context);
          }
        }
      },
      child: _textField(
        title: 'Bangsa',
        controller: bangsaCtrl,
        readOnly: _isReadOnly(),
        enableDropdown: _isNewForm(),
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
              onFindGroupValue: (data) {
                return data.where((val) {
                  var a = val?.code?.toLowerCase().contains(
                          ownerData?.occupationTypeCode.toLowerCase() ?? "") ??
                      false;
                  return a;
                }).firstOrNull;
              },
              getTitle: (data) => data?.desc ?? "-",
              onChange: (val) {
                if (val == null) return;
                ownerData = ownerData!.copyWith(
                    occupationTypeCode: val.code, occupationTypeDesc: val.desc);
                jenisKerjaCtrl.text = val.desc ?? "";
              },
            ).show(context);
          }
        }
      },
      child: _textField(
        title: 'Jenis Pekerjaan',
        controller: jenisKerjaCtrl,
        isDropdown: true,
        onTap: () {
          _dropdownBloc.add(const FetchDdFormData(type: DdType.occupationType));
        },
      ),
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
              onFindGroupValue: (data) {
                return data.where((val) {
                  var a = val?.code?.toLowerCase().contains(
                          ownerData?.maritalStatusCode.toLowerCase() ?? "") ??
                      false;
                  return a;
                }).firstOrNull;
              },
              getTitle: (data) => data?.desc ?? "-",
              onChange: (val) {
                if (val == null) return;
                ownerData = ownerData!.copyWith(
                    maritalStatusCode: val.code, maritalStatusDesc: val.desc);
                statusKahwinCtrl.text = val.desc ?? "";
              },
            ).show(context);
          }
        }
      },
      child: _textField(
        title: 'Status Perkahwinan',
        controller: statusKahwinCtrl,
        isDropdown: true,
        onTap: () {
          _dropdownBloc.add(const FetchDdFormData(type: DdType.maritalStatus));
        },
      ),
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
