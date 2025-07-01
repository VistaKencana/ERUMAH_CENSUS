import 'package:eperumahan_bancian/components/borang_listtile.dart';
import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/custom_alertdialog.dart';
import 'package:eperumahan_bancian/components/custom_form_field.dart';
import 'package:eperumahan_bancian/components/modal/custom_dialog.dart';
import 'package:eperumahan_bancian/components/shrink_text_appbar.dart';
import 'package:eperumahan_bancian/components/sliver_overlap_builder.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/config/routes/routes_name.dart';

import 'package:eperumahan_bancian/data/hive-manager/repository/qr_navigation_pref.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_add_proof.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_image_preview.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_result.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bloc/bancian_bloc.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/models/status_input_model.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/penghuni/bloc/penghuni_bloc.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/subrent/subrent_main_screen.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/unit_kedai/unit_kedai_form.dart';
import 'package:eperumahan_bancian/services/flushbar/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:page_transition/page_transition.dart';

class UnitKedaiMainScreen extends StatefulWidget {
  final bool? isNewForm;
  const UnitKedaiMainScreen({super.key, this.isNewForm});

  @override
  State<UnitKedaiMainScreen> createState() => _UnitKedaiMainScreenState();
}

class _UnitKedaiMainScreenState extends State<UnitKedaiMainScreen> {
  // late DropdownBloc _dropdownBloc;
  late BancianBloc _bancianBloc;
  late StatusInputModel statusData;
  final statusCtrl = TextEditingController();
  final remarkCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isNewForm() => (widget.isNewForm != null && widget.isNewForm == true);
  @override
  void initState() {
    super.initState();
    // _dropdownBloc = BlocProvider.of<DropdownBloc>(context, listen: false);
    _bancianBloc = BlocProvider.of<BancianBloc>(context, listen: false);
    if (_isNewForm()) {
      _bancianBloc.initNotOwner();
      statusData = _bancianBloc.statusNotOwnerData!;
    } else {
      statusData = _bancianBloc.statusData!;
    }
  }

  Future<void> _onPop() async {
    if (_isNewForm()) {
      CustomAlertDialog(
        title: "Berhenti banci?",
        subtitle:
            "Adakah anda akan berhenti membuat bancian untuk bukan pemilik?",
        colorBtnLabel: "Ya",
        onColorBtn: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        dimmedBtnLabel: "Kembali",
        onDimmedBtn: () => Navigator.pop(context),
      ).show(context);
      return;
    }
    final isFromHome = await QrNavigationPref.isFromHome();

    if (!mounted) return;
    CustomAlertDialog(
      title: "Berhenti banci",
      subtitle: "Adakah anda akan berhenti membuat bancian?",
      colorBtnLabel: "Ya",
      onColorBtn: () {
        if (isFromHome) {
          Navigator.popUntil(context, ModalRoute.withName(RoutesName.home));
          return;
        }
        Navigator.popUntil(
            context, ModalRoute.withName(RoutesName.activitySearch));
      },
      dimmedBtnLabel: "Kembali",
      onDimmedBtn: () => Navigator.pop(context),
    ).show(context);
  }

  final _appBar = SliverOverlapAbsorberHandle();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _onPop();
      },
      child: Scaffold(
        body: Form(
          key: formKey,
          child: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverOverlapAbsorber(
                  handle: _appBar,
                  sliver: ShrinkTextAppbar(
                    title: 'Maklumat Unit Kedai',
                    scrolledUnderElevation: 0,
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.primary.color,
                    onPressed: _onPop,
                    actions: [
                      IconButton(
                          onPressed: () {
                            CustomDialog.show(
                                context: context,
                                builder: (_) => Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(
                                                  10)),
                                      backgroundColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(14),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.warning_amber_rounded,
                                                color: Colors.red, size: 60),
                                            SizedBox(height: 10),
                                            Text(
                                              "Lapor Penghuni",
                                              style: appTextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "Adakah anda ingin membuat laporan bancian?",
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 10),
                                            SizedBox(
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    _go(const SubrentMainScreen());
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                          foregroundColor:
                                                              Colors.white),
                                                  child: Text("Teruskan")),
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              child: OutlinedButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  style: OutlinedButton.styleFrom(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadiusGeometry
                                                                  .circular(
                                                                      10)),
                                                      foregroundColor:
                                                          Colors.black87),
                                                  child: Text("Kembali")),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          icon: Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ),
              ];
            },
            body: SliverOverlapBuilder(
              physics: const BouncingScrollPhysics(),
              sliversInjector: [
                SliverOverlapInjector(handle: _appBar),
              ],
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: _isNewForm(),
                        child: Chip(
                          label: Text(
                            "Borang Baharu",
                            style: appTextStyle(size: 14, color: Colors.white),
                          ),
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                          color: const WidgetStatePropertyAll(Colors.blue),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black12))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                _bancianBloc.unitData.unit?.status ?? "-",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            _gap(size: 6),
                            Text(
                              _bancianBloc
                                      .unitData.unit?.housingProject?.desc ??
                                  "-",
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            _gap(size: 4),
                            Row(
                              children: [
                                Text(
                                  "Unit No:${_bancianBloc.unitData.unit?.no ?? "-"}",
                                  style: TextStyle(
                                      color: AppColors.dimmedPurple.color),
                                ),
                              ],
                            ),
                            _gap(size: 6),
                          ],
                        ),
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   margin: const EdgeInsets.symmetric(vertical: 12),
                      //   padding: const EdgeInsets.all(14),
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(10)),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Wrap(
                      //         crossAxisAlignment: WrapCrossAlignment.center,
                      //         children: [
                      //           const Icon(Icons.location_on),
                      //           Text(
                      //             _bancianBloc.unitData.unit?.housingProject
                      //                     ?.desc ??
                      //                 "-",
                      //             style: const TextStyle(
                      //                 fontSize: 18,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //           SizedBox(width: size.width * .1),
                      //           Text(
                      //             _bancianBloc.unitData.unit?.status ?? "-",
                      //             style: TextStyle(
                      //                 color: AppColors.dimmedPurple.color),
                      //           ),
                      //           SizedBox(width: size.width * .1),
                      //           Text(
                      //             "Unit No:${_bancianBloc.unitData.unit?.no ?? "-"}",
                      //             style: TextStyle(
                      //                 color: AppColors.dimmedPurple.color),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      _gap(size: 40),
                      _section("Borang"), divider(),
                      _gap(),
                      _borangTile(
                          label: "Kedai",
                          screen: const UnitKedaiForm(
                              // isNewForm: widget.isNewForm,
                              // imgs: statusData.getFiles()
                              )),
                      _gap(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _section("Gambar"),
                          GestureDetector(
                              onTap: () {
                                _go(BancianAddProof(onTakePicture: (val) {
                                  setState(() {
                                    statusData.addImages(val);
                                  });
                                }));
                              },
                              child: const Icon(Icons.add_a_photo,
                                  color: Colors.black54))
                        ],
                      ),
                      divider(),
                      SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            // GestureDetector(
                            //   onTap: () {

                            //   },
                            //   child: Container(
                            //     width: size.width * .26,
                            //     height: size.height * .12,
                            //     margin: const EdgeInsets.only(left: 12),
                            //     decoration: BoxDecoration(
                            //         border: Border.all(
                            //             color: Colors.black87, width: 3),
                            //         color: Colors.grey.withValues(alpha:.5),
                            //         borderRadius: BorderRadius.circular(10)),
                            //     child: const Center(
                            //       child: Icon(Icons.camera_alt),
                            //     ),
                            //   ),
                            // ),
                            Expanded(
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: List.generate(
                                    statusData.getFiles().length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      BancianImagePreview(
                                        title: "Gambar ${index + 1}",
                                        image: statusData.getFiles()[index],
                                        canDelete:
                                            statusData.getFiles().length > 2,
                                        onDelete: () {
                                          setState(() =>
                                              statusData.removeImages(index));
                                          Navigator.pop(context);
                                        },
                                      ).show(context);
                                    },
                                    child: Container(
                                        width: 120,
                                        height: 100,
                                        margin:
                                            const EdgeInsets.only(right: 12),
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Image.memory(
                                          statusData.getFiles()[index],
                                          fit: BoxFit.fill,
                                        )),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _gap(size: 14),
                      // _section("Cap Jari"),
                      // SectionContainer(
                      //   border: Border.all(color: Colors.grey),
                      //   padding: EdgeInsets.zero,
                      //   margin: EdgeInsets.zero,
                      //   child: ListTile(
                      //     tileColor: Colors.white,
                      //     leading: const Icon(Icons.fingerprint),
                      //     title: const Text("Sahkan Cap Jari"),
                      //     onTap: () => _go(const BancianFingerprint()),
                      //   ),
                      // ),
                      // _gap(size: 14),

                      // _borangTile(
                      //     label: "Maklumat Penghuni",
                      //     screen: PenghuniForm(
                      //         isNewForm: widget.isNewForm,
                      //         imgs: statusData.getFiles())),
                      // if (!_isNewForm())
                      //   _borangTile(
                      //       label: "Maklumat Pasangan",
                      //       screen: const PasanganForm()),
                      // if (!_isNewForm())
                      //   _borangTile(
                      //       label: "Maklumat Anak & Tanggungan",
                      //       screen: const TanggunganForm()),
                      // _gap(size: 20),

                      // _gap(),
                      // _section("Status Bancian"),
                      // CustomTextField(
                      //   hintText: "Pilih status",
                      //   readOnly: true,
                      //   controller: statusCtrl,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) return '';
                      //     return null;
                      //   },
                      //   suffixIcon: Icons.arrow_drop_down,
                      //   onTap: () {
                      //     final ddR = context.read<DropdownProvider>();
                      //     ddR.fetchDropdownData(DdType.censusStatus).then((val) {
                      //       CustomDropdownSheet(
                      //         label: "Pilih status",
                      //         items: ddR.censusStatusList,
                      //         onFindGroupValue: (data) {
                      //           return data.where((val) {
                      //             var a = val.code?.contains(
                      //                     statusData.statusCode ?? "*_*") ??
                      //                 false;
                      //             return a;
                      //           }).firstOrNull;
                      //         },
                      //         getTitle: (data) => data.desc ?? "-",
                      //         onChange: (val) {
                      //           if (val == null) return;
                      //           statusData =
                      //               statusData.copyWith(statusCode: val.code);
                      //           statusCtrl.text = val.desc ?? "";
                      //         },
                      //         // ignore: use_build_context_synchronously
                      //       ).show(context);
                      //     });
                      //   },
                      // ),
                      _gap(),
                      _section("Catatan"), divider(),
                      CustomFormField(
                        maxLines: 3,
                        controller: remarkCtrl,
                        validator: (value) {
                          if (value == null || value.isEmpty) return '';
                          return null;
                        },
                        hintText: "Sila tulis catatan",
                        contentPadding: const EdgeInsets.only(
                            top: 10, left: 10, right: 10, bottom: 10),
                      ),
                      _gap(size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BlocListener<BancianBloc, BancianState>(
          listener: (context, state) {
            if (_isNewForm()) return;
            if (state is BancianLoading) {
              EasyLoading.show();
            } else if (state is BancianSuccess) {
              EasyLoading.dismiss();
              CustomFlushbar.of(context)
                  .showSuccess(msg: "Berjaya menmyimpan data");
              _go(const BancianResult(isVerify: false));
            } else if (state is BancianError) {
              EasyLoading.dismiss();
              CustomFlushbar.of(context).showFailed(msg: state.msg);
            }
          },
          child: BottomBarButton(
            title: "Selesai Bancian",
            onTap: () {
              setState(() {
                statusData = statusData.copyWith(
                  remark: remarkCtrl.text,
                );
              });
              //if add new data
              if (formKey.currentState!.validate() == false) {
                //Trigger if form is not validate
                CustomFlushbar.of(context)
                    .showWarning(msg: "Sila isi maklumat diperlukan");
                return;
              }
              if (statusData.getFiles().length < 2) {
                CustomFlushbar.of(context).showWarning(
                    msg: "Sekurangnya minimum 2 gambar diperlukan");
                return;
              } else {
                CustomAlertDialog(
                  title: "Peringatan !",
                  subtitle: "Sila pastikan semua maklumat adalah betul",
                  colorBtnLabel: "Teruskan",
                  onColorBtn: () {
                    if (_isNewForm() &&
                        context.read<PenghuniBloc>().isNotOwnerisFilled() ==
                            false) {
                      CustomFlushbar.of(context)
                          .showWarning(msg: "Sila isi maklumat penghuni");
                      return;
                    }
                    //Call API
                    _bancianBloc.add(SaveBancianData(data: statusData));
                  },
                  dimmedBtnLabel: "Kembali",
                  onDimmedBtn: () => Navigator.pop(context),
                ).show(context);
              }
            },
          ),
        ),
      ),
    );
  }

  SizedBox _gap({double size = 10}) {
    return SizedBox(height: size);
  }

  Column _borangTile({required String label, required Widget screen}) {
    return Column(
      children: [
        BorangTile(
          title: "Borang",
          subtitle: label,
          onTap: () {
            _go(screen);
          },
        ),
        _gap(),
      ],
    );
  }

  Widget _section(String title) {
    return Text(
      title.toUpperCase(),
      style: appTextStyle(
          fontWeight: FontWeight.bold, size: 16, color: Colors.black54),
    );
  }

  Widget divider() {
    return Column(
      children: [
        SizedBox(height: 8),
        Divider(height: 0),
        SizedBox(height: 10),
      ],
    );
  }

  Future _go(Widget screen) => Navigator.push(context,
      PageTransition(child: screen, type: PageTransitionType.rightToLeft));
}
