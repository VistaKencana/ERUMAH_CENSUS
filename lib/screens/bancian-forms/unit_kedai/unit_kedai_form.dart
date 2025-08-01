import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/custom_alertdialog.dart';
import 'package:eperumahan_bancian/components/custom_appbar.dart';
import 'package:eperumahan_bancian/components/custom_dropdown_sheet.dart';
import 'package:eperumahan_bancian/components/custom_form_field.dart';
import 'package:eperumahan_bancian/components/file_display.dart';
import 'package:eperumahan_bancian/components/section_container.dart';
import 'package:eperumahan_bancian/components/two_column_form.dart';
import 'package:eperumahan_bancian/components/validator.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/data/api/repositories/dropdown_repository.dart';
import 'package:eperumahan_bancian/data/api/repositories/provider/dropdown_provider.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/models/unit_kedai_input_model.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/unit_kedai/bloc/unit_kedai_bloc.dart';
import 'package:eperumahan_bancian/services/flushbar/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UnitKedaiForm extends StatefulWidget {
  const UnitKedaiForm({super.key});

  @override
  State<UnitKedaiForm> createState() => _UnitKedaiFormState();
}

class _UnitKedaiFormState extends State<UnitKedaiForm> {
  UnitKedaiInputModel? ownerData;
  final nameCtrl = TextEditingController();
  final emelCtrl = TextEditingController();
  final icNoCtrl = TextEditingController();
  final noTelCtrl = TextEditingController();
  final businessCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late UnitKedaiBloc _unitKedaiBloc;
  @override
  void initState() {
    super.initState();
    // _dropdownBloc = BlocProvider.of<DropdownBloc>(context, listen: false);
    _unitKedaiBloc = BlocProvider.of<UnitKedaiBloc>(context, listen: false);

    initVal();
  }

  void initVal() {
    ownerData = _unitKedaiBloc.existData.copyWith(isChangeOnImage: false);
    nameCtrl.text = setDataValue(ownerData?.name);
    icNoCtrl.text = setDataValue(ownerData?.icNo);
    emelCtrl.text = setDataValue(ownerData?.email);
    noTelCtrl.text = setDataValue(ownerData?.phoneNo);
    businessCtrl.text = setDataValue(ownerData?.businessTypeDesc);
  }

  String setDataValue(String? val, {String? defaultVal}) {
    return val ?? (defaultVal ?? "");
    // return _isNewForm() ? "" : val ?? (defaultVal ?? "");
  }

  void _exitWarning() {
    CustomAlertDialog(
      title: "Batalkan bancian kedai?",
      subtitle: "Anda pasti mahu membatalkan bancian untuk kedai?",
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
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          _exitWarning();
        },
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(
              title: "",
              onPressedBack: () {
                _exitWarning();
              },
            ),
            body: BlocListener<UnitKedaiBloc, UnitKedaiState>(
              listener: (context, state) {
                if (state is UnitKedaiLoading) {
                  EasyLoading.show();
                } else if (state is UnitKedaiSuccess) {
                  EasyLoading.dismiss();
                  setState(() =>
                      ownerData = ownerData!.copyWith(isChangeOnImage: false));
                  CustomFlushbar.of(context)
                      .showSuccess(msg: "Berjaya menmyimpan data");
                } else if (state is UnitKedaiNoChanges) {
                  CustomFlushbar.of(context).showInfo(msg: state.msg);
                } else if (state is UnitKedaiError) {
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
                          "Maklumat Kedai",
                          style: appTextStyle(
                              size: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SectionContainer(
                        border: Border.all(color: Colors.black12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _textField(
                              title: 'Nama Penuh',
                              controller: nameCtrl,
                              // isMandatory: _isNewForm(),
                              // initialValue:
                              //     _isNewForm() ? "" : ownerData?.name ?? "",
                              width: double.infinity,
                              // readOnly: _isReadOnly()
                            ),
                            _gap(),
                            TwoColumnForm(
                              children: [
                                _textField(
                                  title: 'No. K.P',
                                  controller: icNoCtrl,
                                  // isMandatory: _isNewForm(),
                                  keyboardType: TextInputType.number,
                                  // readOnly: _isReadOnly(),
                                  validator: (value) {
                                    return Validator.validatePhoneNumber(value,
                                        length: 12);
                                  },
                                ),
                                _textField(
                                  title: 'Emel',
                                  controller: emelCtrl,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    return Validator.validateEmail(value);
                                  },
                                ),
                                _textField(
                                  title: 'No Telefon',
                                  controller: noTelCtrl,
                                  keyboardType: TextInputType.phone,
                                  // isMandatory: _isNewForm(),
                                  validator: (value) {
                                    return Validator.validatePhoneNumber(value,
                                        length: 10);
                                  },
                                ),
                                _dropdownBusinessType(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SectionContainer(
                        border: Border.all(color: Colors.black12),
                        child: Column(
                          children: [
                            _headerTitle('SSM'),
                            FileDisplay(
                                img: ownerData!.uploadSSM,
                                subtitle: 'SSM',
                                onPicture: (bytes) {
                                  setState(() => setState(() {
                                        ownerData = ownerData!.copyWith(
                                            uploadSSM: bytes,
                                            isChangeOnImage: true);
                                      }));
                                })
                          ],
                        ),
                      ),
                      SectionContainer(
                        border: Border.all(color: Colors.black12),
                        child: Column(
                          children: [
                            _headerTitle('Lesen Perniagaan'),
                            FileDisplay(
                                img: ownerData!.uploadBusinessLicense,
                                subtitle: 'Lesen Perniagaan',
                                onPicture: (bytes) {
                                  setState(() => setState(() {
                                        ownerData = ownerData!.copyWith(
                                            uploadBusinessLicense: bytes,
                                            isChangeOnImage: true);
                                      }));
                                })
                          ],
                        ),
                      ),
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
                      icNo: icNoCtrl.text,
                      email: emelCtrl.text,
                      phoneNo: noTelCtrl.text,
                    );
                  });
                  _unitKedaiBloc.add(SavePemilikData(data: ownerData!));
                },
                title: "Simpan Maklumat"),
          ),
        ));
  }

  Padding _headerTitle(String title) {
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

  SizedBox _textField(
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
                    if (validator != null) return validator(value);
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

  dynamic _dropdownBusinessType() {
    return _textField(
      title: 'Perniagaan',
      // isMandatory: _isNewForm(),
      controller: businessCtrl,
      // readOnly: _isReadOnly(),
      // enableDropdown: _isNewForm(),
      isDropdown: true,
      onTap: () {
        final ddR = context.read<DropdownProvider>();
        ddR.fetchDropdownData(DdType.businessType).then((val) {
          CustomDropdownSheet(
            label: "Pilih Jenis Perniagaan",
            items: ddR.businessTypeList,
            onFindGroupValue: (data) {
              final searchData = (ownerData?.businessTypeCode != null &&
                      (ownerData?.businessTypeCode?.isNotEmpty ?? false))
                  ? (ownerData?.businessTypeCode?.toLowerCase() ?? "*_*")
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
                  businessTypeCode: val.code, businessTypeDesc: val.desc);
              businessCtrl.text = val.desc ?? "";
            },
            // ignore: use_build_context_synchronously
          ).show(context);
        });
      },
    );
  }

  SizedBox _gap({double height = 10}) => SizedBox(height: height);
}
