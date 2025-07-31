import 'dart:typed_data';

import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/card_display.dart';
import 'package:eperumahan_bancian/components/custom_alertdialog.dart';
import 'package:eperumahan_bancian/components/custom_form_field.dart';
import 'package:eperumahan_bancian/components/kad_pengenalan_tile.dart';
import 'package:eperumahan_bancian/components/two_column_form.dart';
import 'package:eperumahan_bancian/components/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../components/custom_dropdown_sheet.dart';
import '../../../components/disability_checkbox.dart';
import '../../../data/api/repositories/dropdown_repository.dart';
import '../../../data/api/repositories/provider/dropdown_provider.dart';
import '../../../services/flushbar/custom_flushbar.dart';
import '../models/dependant_input_model.dart';
import 'bloc/anak_tanggungan_bloc.dart';

class TanggunganModal extends StatefulWidget {
  final bool? isEdit;
  const TanggunganModal({super.key, this.isEdit});
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
  bool _isEdit() => (widget.isEdit != null && widget.isEdit == true);
  bool _isReadOnly() => _isEdit() ? false : true;
  Uint8List? frontCard;
  Uint8List? backCard;
  Uint8List? okuCard;
  bool isOKU = false;
  // late DropdownBloc _dropdownBloc;
  late AnakTanggunganBloc _tanggunganBloc;
  DependantInputModel? dependantData;
  final nameCtrl = TextEditingController();
  final icNoCtrl = TextEditingController();
  final emelCtrl = TextEditingController();
  final umurCtrl = TextEditingController();
  final noTelCtrl = TextEditingController();
  final hubunganCtrl = TextEditingController();
  final kesihatanCtrl = TextEditingController();
  final jantinaCtrl = TextEditingController();
  final bangsaCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _tanggunganBloc =
        BlocProvider.of<AnakTanggunganBloc>(context, listen: false);
    initVal();
  }

  void initVal() {
    // if (_isEdit()) {
    //   _tanggunganBloc.addNewDependant();
    // }
    dependantData = _tanggunganBloc.selectedData!.copyWith();
    // nameCtrl.text = setDataValue(dependantData?.name);
    nameCtrl.text = dependantData?.name ?? "";
    // icNoCtrl.text = setDataValue(dependantData?.icNo);
    icNoCtrl.text = dependantData?.icNo ?? "";
    emelCtrl.text = setDataValue(dependantData?.email);
    noTelCtrl.text = setDataValue(dependantData?.phoneNo);
    hubunganCtrl.text = setDataValue(dependantData?.relationshipDesc);
    umurCtrl.text = setDataValue(dependantData?.age);
    kesihatanCtrl.text = setDataValue(dependantData?.healthLevelDesc);
    // jantinaCtrl.text = setDataValue(dependantData?.genderDesc);
    jantinaCtrl.text = dependantData?.genderDesc ?? "";
    bangsaCtrl.text = setDataValue(dependantData?.raceDesc);
  }

  String setDataValue(String? val, {String? defaultVal}) {
    return _isEdit() ? "" : val ?? (defaultVal ?? "");
  }

  void _exitWarning() {
    CustomAlertDialog(
      title: "Hentikan bancian tanggungan?",
      subtitle: "Anda pasti mahu menghentikan bancian untuk tanggungan?",
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
    return Form(
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
                children: [
                  _header(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KadPengenalanTile(
                            frontCard: dependantData!.uploadIcFront,
                            onFrontCard: (bytes) {
                              setState(() => dependantData = dependantData!
                                  .copyWith(
                                      uploadIcFront: bytes,
                                      isChangeOnImage: true));
                            },
                            backCard: dependantData!.uploadIcBack,
                            onBackCard: (bytes) {
                              setState(() => dependantData = dependantData!
                                  .copyWith(
                                      uploadIcBack: bytes,
                                      isChangeOnImage: true));
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
                                    title: 'Nama Tanggungan',
                                    controller: nameCtrl,
                                    width: double.infinity,
                                    readOnly: _isReadOnly()),
                                _gap(height: 14),
                                TwoColumnForm(
                                  children: [
                                    _dropdownHubungan(),
                                    _textField(
                                      title: 'No. IC',
                                      controller: icNoCtrl,
                                      keyboardType: TextInputType.number,
                                      readOnly: _isReadOnly(),
                                      validator: (value) {
                                        return Validator.validatePhoneNumber(
                                            value,
                                            length: 12);
                                      },
                                    ),
                                    // _textField(
                                    //   title: 'Emel',
                                    //   controller: emelCtrl,
                                    //   keyboardType: TextInputType.emailAddress,
                                    // ),
                                    _dropdownKesihatan(),
                                    _dropdownBangsa(),
                                    _textField(
                                        title: 'Umur',
                                        controller: umurCtrl,
                                        keyboardType: TextInputType.number,
                                        readOnly: _isReadOnly()),

                                    // _textField(
                                    //     title: 'No. Telefon Bimbit',
                                    //     controller: noTelCtrl,
                                    //     keyboardType: TextInputType.phone,
                                    //     readOnly: _isReadOnly()),

                                    _dropdownJantina(),
                                  ],
                                ),
                                _gap(height: 14),
                                DisabilityCheckbox(
                                    initVal: (dependantData?.isOku == "1"),
                                    onCheck: (val) {
                                      setState(() {
                                        dependantData = dependantData!
                                            .copyWith(isOku: val ? "1" : "0");
                                      });
                                    }),
                                Visibility(
                                  visible: (dependantData?.isOku == "1"),
                                  child: CardDisplay(
                                    title: "",
                                    img: dependantData?.uploadOkuCard,
                                    onPicture: (bytes) => setState(() {
                                      dependantData = dependantData!.copyWith(
                                          uploadOkuCard: bytes,
                                          isChangeOnImage: true);
                                    }),
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
              bottomNavigationBar:
                  BlocListener<AnakTanggunganBloc, AnakTanggunganState>(
                listener: (context, state) {
                  if (state is DependantNoChanges) {
                    CustomFlushbar.of(context).showInfo(msg: state.msg);
                  } else if (state is DependantLoading) {
                    EasyLoading.show();
                  } else if (state is DependantSuccess) {
                    EasyLoading.dismiss();
                    setState(() => dependantData =
                        dependantData!.copyWith(isChangeOnImage: false));
                    CustomFlushbar.of(context)
                        .showSuccess(msg: "Berjaya menmyimpan data");
                  } else if (state is DependantSuccessAddNew) {
                    EasyLoading.dismiss();
                    Navigator.pop(context);
                    CustomFlushbar.of(context)
                        .showSuccess(msg: "Berjaya menmyimpan data");
                  } else if (state is DependantError) {
                    EasyLoading.dismiss();
                    CustomFlushbar.of(context).showFailed(msg: state.msg);
                  }
                },
                child: BottomBarButton(
                    onTap: () {
                      setState(() {
                        dependantData = dependantData!.copyWith(
                            name: nameCtrl.text,
                            icNo: icNoCtrl.text,
                            email: emelCtrl.text,
                            phoneNo: noTelCtrl.text,
                            age: umurCtrl.text);
                      });
                      //if update data
                      if (!_isEdit()) {
                        _tanggunganBloc
                            .add(SaveOtherData(data: dependantData!));
                        return;
                      }
                      //if add new data
                      if (formKey.currentState!.validate() == false) {
                        //Trigger if form is not validate
                        CustomFlushbar.of(context)
                            .showWarning(msg: "Sila isi maklumat diperlukan");
                        return;
                      } else {
                        _tanggunganBloc.add(AddOtherData(data: dependantData!));
                      }
                    },
                    title: "Simpan"),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding _header() {
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
              onTap: () => _exitWarning(), child: const Icon(Icons.close)),
          const SizedBox(width: 15)
        ],
      ),
    );
  }

  String _getHeaderTitle() {
    String prefix = _isEdit() ? "Tambah " : "Maklumat ";
    String title = 'Tanggungan';
    return prefix + title;
  }

  SizedBox _gap({double height = 10}) => SizedBox(height: height);

  SizedBox _textField(
      {required String title,
      bool isMandatory = false,
      bool readOnly = false,
      bool enableDropdown = true,
      TextEditingController? controller,
      String? hintText,
      TextInputType keyboardType = TextInputType.text,
      void Function(String)? onChanged,
      double? width,
      void Function()? onTap,
      bool isDropdown = false,
      String? Function(String?)? validator}) {
    if (isDropdown) {
      return SizedBox(
          width: width ?? MediaQuery.sizeOf(context).width * 0.4,
          child: CustomFormField(
            title: title,
            onChanged: onChanged,
            controller: controller, isMandatory: isMandatory,
            validator: isMandatory
                ? (value) {
                    if (value == null || value.isEmpty) return '';
                    return null;
                  }
                : null,
            onTap: () {
              if (onTap == null || !enableDropdown) return;
              onTap();
            },
            readOnly: true,
            fillColor: Colors.white,
            hintText: hintText,
            // initialValue: _isEdit() ? "" : initialValue,
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
        isMandatory: isMandatory,
        keyboardType: keyboardType,
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
        readOnly: readOnly,
        hintText: hintText,
        onChanged: onChanged,
      ),
    );
  }

  dynamic _dropdownHubungan() {
    return _textField(
      title: 'Hubungan Dengan Penyewa',
      isDropdown: true,
      readOnly: _isReadOnly(),
      isMandatory: _isEdit(),
      controller: hubunganCtrl,
      enableDropdown: _isEdit(),
      onTap: () {
        final ddR = context.read<DropdownProvider>();
        ddR.fetchDropdownData(DdType.relationship).then((val) {
          CustomDropdownSheet(
            label: "Hubungan Dengan Penyewa",
            items: ddR.relationshipList,
            onFindGroupValue: (data) {
              final searchData = (dependantData?.relationshipCode != null &&
                      (dependantData?.relationshipCode?.isNotEmpty ?? false))
                  ? (dependantData?.relationshipCode?.toLowerCase() ?? "*_*")
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
              dependantData = dependantData!.copyWith(
                  relationshipCode: val.code, relationshipDesc: val.desc);
              hubunganCtrl.text = val.desc ?? "";
            },
            // ignore: use_build_context_synchronously
          ).show(context);
        });
      },
    );
    // return BlocListener<DropdownBloc, DropdownState>(
    //   listener: (context, state) {
    //     if (state is DropdownSuccess) {
    //       if (state.type == DdType.relationship) {
    //         CustomDropdownSheet(
    //           label: "Hubungan Dengan Penyewa",
    //           items: state.data,
    //           onFindGroupValue: (data) {
    //             return data.where((val) {
    //               var a = val?.code
    //                       ?.contains(dependantData?.relationshipCode ?? "") ??
    //                   false;
    //               return a;
    //             }).firstOrNull;
    //           },
    //           getTitle: (data) => data?.desc ?? "-",
    //           onChange: (val) {
    //             if (val == null) return;
    //             dependantData = dependantData!.copyWith(
    //                 relationshipCode: val.code, relationshipDesc: val.desc);
    //             hubunganCtrl.text = val.desc ?? "";
    //           },
    //         ).show(context);
    //       }
    //     }
    //   },
    //   child: _textField(
    //     title: 'Hubungan Dengan Penyewa',
    //     isDropdown: true,
    //     isMandatory: _isEdit(),
    //     readOnly: _isReadOnly(),
    //     controller: hubunganCtrl,
    //     enableDropdown: _isEdit(),
    //     onTap: () {
    //       _dropdownBloc.add(const FetchDdFormData(type: DdType.relationship));
    //     },
    //   ),
    // );
  }

  dynamic _dropdownKesihatan() {
    return _textField(
        title: 'Tahap Kesihatan',
        isMandatory: _isEdit(),
        isDropdown: true,
        onTap: () {
          final ddR = context.read<DropdownProvider>();
          ddR.fetchDropdownData(DdType.healthLevel).then((val) {
            CustomDropdownSheet(
              label: "Pilih Tahap Kesihatan",
              items: ddR.healthLevelList,
              onFindGroupValue: (data) {
                final searchData = (dependantData?.healthLevelCode != null &&
                        (dependantData?.healthLevelCode?.isNotEmpty ?? false))
                    ? (dependantData?.healthLevelCode?.toLowerCase() ?? "*_*")
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
                dependantData = dependantData!.copyWith(
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
    //                       ?.contains(dependantData?.healthLevelCode ?? "") ??
    //                   false;
    //               return a;
    //             }).firstOrNull;
    //           },
    //           getTitle: (data) => data?.desc ?? "-",
    //           onChange: (val) {
    //             if (val == null) return;
    //             dependantData = dependantData!.copyWith(
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
    //       isMandatory: _isEdit(),
    //       onTap: () {
    //         _dropdownBloc.add(const FetchDdFormData(type: DdType.healthLevel));
    //       },
    //       controller: kesihatanCtrl),
    // );
  }

  dynamic _dropdownJantina() {
    return _textField(
        title: 'Jantina',
        controller: jantinaCtrl,
        isMandatory: _isEdit(),
        readOnly: _isReadOnly(),
        enableDropdown: _isEdit(),
        isDropdown: true,
        onTap: () {
          final ddR = context.read<DropdownProvider>();
          ddR.fetchDropdownData(DdType.gender).then((val) {
            CustomDropdownSheet(
              label: "Pilih Jantina",
              items: ddR.genderList,
              onFindGroupValue: (data) {
                final searchData = (dependantData?.genderCode != null &&
                        (dependantData?.genderCode?.isNotEmpty ?? false))
                    ? (dependantData?.genderCode?.toLowerCase() ?? "*_*")
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
                dependantData = dependantData!
                    .copyWith(genderCode: val.code, genderDesc: val.desc);
                jantinaCtrl.text = val.desc ?? "";
              },
              // ignore: use_build_context_synchronously
            ).show(context);
          });
        });
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
    //                   val?.code?.contains(dependantData?.genderCode ?? "") ??
    //                       false;
    //               return a;
    //             }).firstOrNull;
    //           },
    //           getTitle: (data) => data?.desc ?? "-",
    //           onChange: (val) {
    //             if (val == null) return;
    //             dependantData = dependantData!
    //                 .copyWith(genderCode: val.code, genderDesc: val.desc);
    //             jantinaCtrl.text = val.desc ?? "";
    //           },
    //         ).show(context);
    //       }
    //     }
    //   },
    //   child: _textField(
    //     title: 'Jantina',
    //     controller: jantinaCtrl,
    //     isMandatory: _isEdit(),
    //     readOnly: _isReadOnly(),
    //     enableDropdown: _isEdit(),
    //     isDropdown: true,
    //     onTap: () {
    //       _dropdownBloc.add(const FetchDdFormData(type: DdType.gender));
    //     },
    //   ),
    // );
  }

  dynamic _dropdownBangsa() {
    return _textField(
      title: 'Bangsa',
      controller: bangsaCtrl,
      isMandatory: _isEdit(),
      readOnly: _isReadOnly(),
      enableDropdown: _isEdit(),
      isDropdown: true,
      onTap: () {
        final ddR = context.read<DropdownProvider>();
        ddR.fetchDropdownData(DdType.race).then((val) {
          CustomDropdownSheet(
            label: "Pilih Bangsa",
            items: ddR.raceList,
            onFindGroupValue: (data) {
              //Query data
              final searchData = (dependantData?.raceCode != null &&
                      (dependantData?.raceCode?.isNotEmpty ?? false))
                  ? (dependantData?.raceCode?.toLowerCase() ?? "*_*")
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
              dependantData = dependantData!
                  .copyWith(raceCode: val.code, raceDesc: val.desc);
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
    //               var a = val?.code?.contains(dependantData?.raceCode ?? "") ??
    //                   false;
    //               return a;
    //             }).firstOrNull;
    //           },
    //           getTitle: (data) => data?.desc ?? "-",
    //           onChange: (val) {
    //             if (val == null) return;
    //             dependantData = dependantData!
    //                 .copyWith(raceCode: val.code, raceDesc: val.desc);
    //             bangsaCtrl.text = val.desc ?? "";
    //           },
    //         ).show(context);
    //       }
    //     }
    //   },
    //   child: _textField(
    //     title: 'Bangsa',
    //     controller: bangsaCtrl,
    //     isMandatory: _isEdit(),
    //     readOnly: _isReadOnly(),
    //     enableDropdown: _isEdit(),
    //     isDropdown: true,
    //     onTap: () {
    //       _dropdownBloc.add(const FetchDdFormData(type: DdType.race));
    //     },
    //   ),
    // );
  }
}
