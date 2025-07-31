import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/card_display.dart';
import 'package:eperumahan_bancian/components/custom_alertdialog.dart';
import 'package:eperumahan_bancian/components/custom_dropdown_sheet.dart';
import 'package:eperumahan_bancian/components/custom_form_field.dart';
import 'package:eperumahan_bancian/components/kad_pengenalan_tile.dart';
import 'package:eperumahan_bancian/components/switch_modal.dart';
import 'package:eperumahan_bancian/components/two_column_form.dart';
import 'package:eperumahan_bancian/components/validator.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/data/api/repositories/dropdown_repository.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/models/spouse_input_model.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/pasangan/bloc/pasangan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../components/disability_checkbox.dart';
import '../../../components/file_display.dart';
import '../../../data/api/repositories/provider/dropdown_provider.dart';
import '../../../services/flushbar/custom_flushbar.dart';

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
  bool _isNewForm() => (widget.isNewForm != null && widget.isNewForm == true);
  bool _isReadOnly() => _isNewForm() ? false : true;

  bool isOKU = false;
  late PasanganBloc _pasanganBloc;
  SpouseInputModel? spouseData;
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
  final namaMajikanCtrl = TextEditingController();
  final majikanAddressCtrl = TextEditingController();
  final gajiPokokCtrl = TextEditingController();
  final elaunCtrl = TextEditingController();
  final lainPendapatanCtrl = TextEditingController();
  final bantuanCtrl = TextEditingController();
  final kesihatanCtrl = TextEditingController();
  final isAliveCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // _dropdownBloc = BlocProvider.of<DropdownBloc>(context, listen: false);
    _pasanganBloc = BlocProvider.of<PasanganBloc>(context, listen: false);
    initVal();
  }

  void initVal() {
    // if (_isNewForm()) {
    //   _pasanganBloc.addNewPasangan();
    // }
    spouseData = _pasanganBloc.selectedSpouse!.copyWith(isChangeOnImage: false);
    nameCtrl.text = setDataValue(spouseData?.name);
    bilIsiRumahCtrl.text =
        setDataValue(spouseData?.totalHousehold, defaultVal: "0");
    icNoCtrl.text = setDataValue(spouseData?.icNo);
    emelCtrl.text = setDataValue(spouseData?.email);
    umurCtrl.text = setDataValue(spouseData?.age);
    noTelCtrl.text = setDataValue(spouseData?.phoneNo);
    jantinaCtrl.text = setDataValue(spouseData?.genderDesc);
    bangsaCtrl.text = setDataValue(spouseData?.raceDesc);
    jenisKerjaCtrl.text = setDataValue(spouseData?.occupationTypeDesc);
    statusKahwinCtrl.text = setDataValue(spouseData?.maritalStatusDesc);
    namaMajikanCtrl.text = setDataValue(spouseData?.companyName);
    majikanAddressCtrl.text = setDataValue(spouseData?.workAddress);
    gajiPokokCtrl.text = setDataValue(spouseData?.workSalary);
    elaunCtrl.text = setDataValue(spouseData?.workAllowance);
    lainPendapatanCtrl.text = setDataValue(spouseData?.workOtherIncome);
    bantuanCtrl.text = setDataValue(spouseData?.welfareAid);
    kesihatanCtrl.text = setDataValue(spouseData?.healthLevelDesc);
    isAliveCtrl.text =
        (spouseData?.isAlive.contains("0") ?? false) ? "Tidak" : "Ya";
  }

  String setDataValue(String? val, {String? defaultVal}) {
    return _isNewForm() ? "" : val ?? (defaultVal ?? "");
  }

  void _exitWarning() {
    CustomAlertDialog(
      title: "Hentikan bancian pasangan?",
      subtitle: "Anda pasti mahu menghentikan bancian untuk pasangan?",
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
    return BlocListener<PasanganBloc, PasanganState>(
      listener: (context, state) {
        if (state is PasanganLoading) {
          EasyLoading.show();
        } else if (state is PasanganSuccess) {
          EasyLoading.dismiss();
          CustomFlushbar.of(context)
              .showSuccess(msg: "Berjaya menmyimpan data");
          spouseData = spouseData!.copyWith(isChangeOnImage: false);
        } else if (state is PasanganSuccessAddNew) {
          EasyLoading.dismiss();
          Navigator.pop(context);
          CustomFlushbar.of(context)
              .showSuccess(msg: "Berjaya menmyimpan data");
          // .then((val) => Navigator.pop(context));
        } else if (state is PasanganError) {
          EasyLoading.dismiss();
          CustomFlushbar.of(context).showFailed(msg: state.msg);
        } else if (state is PasanganNoChanges) {
          CustomFlushbar.of(context).showInfo(msg: state.msg);
        }
      },
      child: Form(
        key: formKey,
        child: DraggableScrollableSheet(
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
                    onTap: () {
                      setState(() {
                        spouseData = spouseData!.copyWith(
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
                            welfareAid: bantuanCtrl.text);
                      });

                      //if update data
                      if (!_isNewForm()) {
                        _pasanganBloc.add(SavePasanganData(data: spouseData!));
                        return;
                      }
                      //if add new data
                      if (formKey.currentState!.validate() == false) {
                        //Trigger if form is not validate
                        CustomFlushbar.of(context)
                            .showWarning(msg: "Sila isi maklumat diperlukan");
                        return;
                      } else {
                        _pasanganBloc
                            .add(AddNewPasanganData(data: spouseData!));
                      }
                    },
                    title: "Simpan"),
              ),
            );
          },
        ),
      ),
    );
  }

  Padding _header() {
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
              onTap: () => _exitWarning(), child: const Icon(Icons.close)),
          const SizedBox(width: 15),
        ],
      ),
    );
  }

  Expanded _form() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KadPengenalanTile(
              frontCard: spouseData?.uploadIcFront,
              onFrontCard: (bytes) {
                setState(() => spouseData = spouseData!
                    .copyWith(uploadIcFront: bytes, isChangeOnImage: true));
              },
              backCard: spouseData?.uploadIcBack,
              onBackCard: (bytes) {
                setState(() => spouseData = spouseData!
                    .copyWith(uploadIcBack: bytes, isChangeOnImage: true));
              },
            ),
            const Divider(height: 0, indent: 20, endIndent: 20),
            _gap(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: Column(
                children: [
                  _textField(
                    title: 'No. IC',
                    controller: icNoCtrl,
                    keyboardType: TextInputType.number,
                    isMandatory: _isNewForm(),
                    width: double.infinity,
                    readOnly: _isReadOnly(),
                    validator: (value) {
                      return Validator.validatePhoneNumber(value, length: 12);
                    },
                  ),
                  _gap(height: 14),
                  TwoColumnForm(
                    children: [
                      // _textField(
                      //   title: 'Emel',
                      //   controller: emelCtrl,
                      //   keyboardType: TextInputType.emailAddress,
                      // ),
                      _textField(
                          title: 'Nama Penghuni',
                          controller: nameCtrl,
                          isMandatory: _isNewForm(),
                          width: double.infinity,
                          readOnly: _isReadOnly()),
                      _textField(
                        title: 'No Telefon Bimbit',
                        keyboardType: TextInputType.phone,
                        controller: noTelCtrl,
                        validator: (value) {
                          return Validator.validatePhoneNumber(value,
                              length: 10);
                        },
                      ),
                      _dropdownJantina(),
                      _textField(
                          title: 'Umur',
                          controller: umurCtrl,
                          keyboardType: TextInputType.number,
                          readOnly: _isReadOnly()),
                      _dropdownBangsa(),
                      _dropdownKesihatan(),
                      _textField(
                          title: 'Masih Hidup',
                          initialValue: "Ya",
                          isDropdown: true,
                          isMandatory: _isNewForm(),
                          controller: isAliveCtrl,
                          onTap: () {
                            SwitchModal(
                                label: "Pilih status",
                                onFindGroupValue: (data) {
                                  var a = data
                                      .where((val) =>
                                          val.code?.contains(
                                              spouseData?.isAlive ?? "*_*") ??
                                          false)
                                      .toList();
                                  return a.firstOrNull;
                                },
                                getTitle: (data) => data.desc!,
                                onChange: (val) {
                                  if (val == null) return;
                                  spouseData = spouseData!
                                      .copyWith(isAlive: val.code ?? "-");
                                  isAliveCtrl.text = val.desc ?? "-";
                                  setState(() {});
                                }).show(context);
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
                        initVal: (spouseData?.isOku == "1"),
                        onCheck: (val) {
                          setState(() {
                            spouseData =
                                spouseData!.copyWith(isOku: val ? "1" : "0");
                          });
                        }),
                    Visibility(
                      visible: (spouseData?.isOku == "1"),
                      child: CardDisplay(
                        title: "",
                        img: spouseData!.uploadOkuCard,
                        onPicture: (bytes) => setState(() {
                          spouseData =
                              spouseData!.copyWith(uploadOkuCard: bytes);
                        }),
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

  SizedBox _textField(
      {required String title,
      String? initialValue,
      bool readOnly = false,
      bool isMandatory = false,
      bool enableDropdown = true,
      TextEditingController? controller,
      String? hintText,
      void Function(String)? onChanged,
      double? width,
      TextInputType keyboardType = TextInputType.text,
      void Function()? onTap,
      bool isDropdown = false,
      String? Function(String?)? validator}) {
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
        keyboardType: keyboardType,
        readOnly: readOnly,
        hintText: hintText,
        onChanged: onChanged,
        isMandatory: isMandatory,
        validator: isMandatory
            ? (value) {
                if (validator != null) return validator(value);
                if (value == null || value.isEmpty) return '';

                return null;
              }
            : (value) {
                if (validator != null) return validator(value);
                return null;
              },
        // initialValue: _isNewForm() ? "" : initialValue,
      ),
    );
  }

  dynamic _dropdownBangsa() {
    return _textField(
      title: 'Bangsa',
      readOnly: _isReadOnly(),
      enableDropdown: _isNewForm(),
      controller: bangsaCtrl,
      isDropdown: true,
      onTap: () {
        final ddR = context.read<DropdownProvider>();
        ddR.fetchDropdownData(DdType.race).then((val) {
          CustomDropdownSheet(
            label: "Pilih Bangsa",
            items: ddR.raceList,
            onFindGroupValue: (data) {
              final searchData = (spouseData?.raceCode != null &&
                      (spouseData?.raceCode?.isNotEmpty ?? false))
                  ? (spouseData?.raceCode?.toLowerCase() ?? "*_*")
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
              spouseData =
                  spouseData!.copyWith(raceCode: val.code, raceDesc: val.desc);
              bangsaCtrl.text = val.desc ?? "";
            },
            // ignore: use_build_context_synchronously
          ).show(context);
        });
      },
    );
    // return BlocListener<DropdownBloc, DropdownState>(
    //   listener: (context, state) {
    //     if (state is DropdownSuccess) {
    //       if (state.type == DdType.race) {
    //         CustomDropdownSheet(
    //           label: "Pilih Bangsa",
    //           items: state.data,
    //           onFindGroupValue: (data) {
    //             return data.where((val) {
    //               var a = val?.code?.contains(spouseData?.raceCode ?? "*_*") ??
    //                   false;
    //               return a;
    //             }).firstOrNull;
    //           },
    //           getTitle: (data) => data?.desc ?? "-",
    //           onChange: (val) {
    //             if (val == null) return;
    //             spouseData = spouseData!
    //                 .copyWith(raceCode: val.code, raceDesc: val.desc);
    //             bangsaCtrl.text = val.desc ?? "";
    //           },
    //         ).show(context);
    //       }
    //     }
    //   },
    //   child: _textField(
    //     title: 'Bangsa',
    //     readOnly: _isReadOnly(),
    //     enableDropdown: _isNewForm(),
    //     controller: bangsaCtrl,
    //     isDropdown: true,
    //     onTap: () {
    //       _dropdownBloc.add(const FetchDdFormData(type: DdType.race));
    //     },
    //   ),
    // );
  }

  dynamic _dropdownJantina() {
    return _textField(
        title: 'Jantina',
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
                final searchData = (spouseData?.genderCode != null &&
                        (spouseData?.genderCode?.isNotEmpty ?? false))
                    ? (spouseData?.genderCode?.toLowerCase() ?? "*_*")
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
                spouseData = spouseData!
                    .copyWith(genderCode: val.code, genderDesc: val.desc);
                jantinaCtrl.text = val.desc ?? "";
              },
              // ignore: use_build_context_synchronously
            ).show(context);
          });
        },
        controller: jantinaCtrl);
    // return BlocListener<DropdownBloc, DropdownState>(
    //   listener: (context, state) {
    //     if (state is DropdownSuccess) {
    //       if (state.type == DdType.gender) {
    //         CustomDropdownSheet(
    //           label: "Pilih Jantina",
    //           items: state.data,
    //           onFindGroupValue: (data) {
    //             return data.where((val) {
    //               var a =
    //                   val?.code?.contains(spouseData?.genderCode ?? "*_*") ??
    //                       false;
    //               return a;
    //             }).firstOrNull;
    //           },
    //           getTitle: (data) => data?.desc ?? "-",
    //           onChange: (val) {
    //             if (val == null) return;
    //             spouseData = spouseData!
    //                 .copyWith(genderCode: val.code, genderDesc: val.desc);
    //             jantinaCtrl.text = val.desc ?? "";
    //           },
    //         ).show(context);
    //       }
    //     }
    //   },
    //   child: _textField(
    //       title: 'Jantina',
    //       readOnly: _isReadOnly(),
    //       enableDropdown: _isNewForm(),
    //       isDropdown: true,
    //       onTap: () {
    //         _dropdownBloc.add(const FetchDdFormData(type: DdType.gender));
    //       },
    //       controller: jantinaCtrl),
    // );
  }

  dynamic _dropdownKesihatan() {
    return _textField(
        title: 'Tahap Kesihatan',
        isDropdown: true,
        isMandatory: _isNewForm(),
        onTap: () {
          final ddR = context.read<DropdownProvider>();
          ddR.fetchDropdownData(DdType.healthLevel).then((val) {
            CustomDropdownSheet(
              label: "Pilih Tahap Kesihatan",
              items: ddR.healthLevelList,
              onFindGroupValue: (data) {
                final searchData = (spouseData?.healthLevelCode != null &&
                        (spouseData?.healthLevelCode?.isNotEmpty ?? false))
                    ? (spouseData?.healthLevelCode?.toLowerCase() ?? "*_*")
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
                spouseData = spouseData!.copyWith(
                    healthLevelCode: val.code, healthLevelDesc: val.desc);
                kesihatanCtrl.text = val.desc ?? "";
              },
              // ignore: use_build_context_synchronously
            ).show(context);
          });
        },
        controller: kesihatanCtrl);
    // return BlocListener<DropdownBloc, DropdownState>(
    //   listener: (context, state) {
    //     if (state is DropdownSuccess) {
    //       if (state.type == DdType.healthLevel) {
    //         CustomDropdownSheet(
    //           label: "Pilih Tahap Kesihatan",
    //           items: state.data,
    //           onFindGroupValue: (data) {
    //             return data.where((val) {
    //               var a = val?.code
    //                       ?.contains(spouseData?.healthLevelCode ?? "*_*") ??
    //                   false;
    //               return a;
    //             }).firstOrNull;
    //           },
    //           getTitle: (data) => data?.desc ?? "-",
    //           onChange: (val) {
    //             if (val == null) return;
    //             spouseData = spouseData!.copyWith(
    //                 healthLevelCode: val.code, healthLevelDesc: val.desc);
    //             kesihatanCtrl.text = val.desc ?? "";
    //           },
    //         ).show(context);
    //       }
    //     }
    //   },
    //   child: _textField(
    //       title: 'Tahap Kesihatan',
    //       isDropdown: true,
    //       isMandatory: _isNewForm(),
    //       onTap: () {
    //         _dropdownBloc.add(const FetchDdFormData(type: DdType.healthLevel));
    //       },
    //       controller: kesihatanCtrl),
    // );
  }

  dynamic _dropdownJenisPekerjaan() {
    return _textField(
        title: 'Jenis Pekerjaan',
        isDropdown: true,
        isMandatory: _isNewForm(),
        onTap: () {
          final ddR = context.read<DropdownProvider>();
          ddR.fetchDropdownData(DdType.occupationType).then((val) {
            CustomDropdownSheet(
              label: "Pilih Jenis Pekerjaan",
              items: ddR.occupationTypeList,
              onFindGroupValue: (data) {
                final searchData = (spouseData?.occupationTypeCode != null &&
                        (spouseData?.occupationTypeCode?.isNotEmpty ?? false))
                    ? (spouseData?.occupationTypeCode?.toLowerCase() ?? "*_*")
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
                spouseData = spouseData!.copyWith(
                    occupationTypeCode: val.code, occupationTypeDesc: val.desc);
                jenisKerjaCtrl.text = val.desc ?? "";
              },
              // ignore: use_build_context_synchronously
            ).show(context);
          });
        },
        controller: jenisKerjaCtrl);
    // return BlocListener<DropdownBloc, DropdownState>(
    //   listener: (context, state) {
    //     if (state is DropdownSuccess) {
    //       if (state.type == DdType.occupationType) {
    //         CustomDropdownSheet(
    //           label: "Pilih Jenis Pekerjaan",
    //           items: state.data,
    //           onFindGroupValue: (data) {
    //             return data.where((val) {
    //               var a = val?.code
    //                       ?.contains(spouseData?.occupationTypeCode ?? "*_*") ??
    //                   false;
    //               return a;
    //             }).firstOrNull;
    //           },
    //           getTitle: (data) => data?.desc ?? "-",
    //           onChange: (val) {
    //             if (val == null) return;
    //             spouseData = spouseData!.copyWith(
    //                 occupationTypeCode: val.code, occupationTypeDesc: val.desc);
    //             jenisKerjaCtrl.text = val.desc ?? "";
    //           },
    //         ).show(context);
    //       }
    //     }
    //   },
    //   child: _textField(
    //       title: 'Jenis Pekerjaan',
    //       isDropdown: true,
    //       isMandatory: _isNewForm(),
    //       onTap: () {
    //         _dropdownBloc
    //             .add(const FetchDdFormData(type: DdType.occupationType));
    //       },
    //       controller: jenisKerjaCtrl),
    // );
  }

  Padding _formPenadapatan() {
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
              const SizedBox(height: 10),
              FileDisplay(
                title: "Slip Gaji / Penyata KWSP",
                isMandatory: true,
                img: spouseData?.uploadIncome,
                onPicture: (bytes) => setState(() => setState(() =>
                    spouseData = spouseData!.copyWith(uploadIncome: bytes))),
              ),
              const SizedBox(height: 10),
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
                  title: 'Elaun (RM)', hintText: "0.00", controller: elaunCtrl),
              _textField(
                  title: 'Lain-lain Pendapatan',
                  controller: lainPendapatanCtrl),
              _textField(title: 'Bantuan Kewangan', controller: bantuanCtrl),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox _gap({double height = 10}) => SizedBox(height: height);
}
