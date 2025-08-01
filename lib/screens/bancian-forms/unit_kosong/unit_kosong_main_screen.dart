import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/custom_alertdialog.dart';
import 'package:eperumahan_bancian/components/custom_form_field.dart';
import 'package:eperumahan_bancian/components/modal/custom_modal_sheet.dart';
import 'package:eperumahan_bancian/components/section_container.dart';
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
import 'package:eperumahan_bancian/services/flushbar/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:page_transition/page_transition.dart';

class UnitKosongMainScreen extends StatefulWidget {
  final bool? isNewForm;
  const UnitKosongMainScreen({super.key, this.isNewForm});

  @override
  State<UnitKosongMainScreen> createState() => _UnitKosongMainScreenState();
}

class _UnitKosongMainScreenState extends State<UnitKosongMainScreen> {
  // late DropdownBloc _dropdownBloc;
  late BancianBloc _bancianBloc;
  late StatusInputModel statusData;
  final statusCtrl = TextEditingController();
  final remarkCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isVerifyFP = false;
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
        subtitle: "Anda pasti mahu membatalkan bancian untuk bukan pemilik?",
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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _onPop();
      },
      child: LayoutBuilder(builder: (context, constraint) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(constraint.maxHeight * .108),
              child: Container(
                color: AppColors.primary.color,
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _bancianBloc.unitData.unit?.housingProject
                                          ?.desc ??
                                      "-",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Unit No:${_bancianBloc.unitData.unit?.no ?? "-"}",
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    // Text(
                                    //   " • ",
                                    //   style: TextStyle(color: Colors.white70),
                                    // ),
                                    // Text(
                                    //   _bancianBloc.unitData.unit?.status ?? "-",
                                    //   style: TextStyle(color: Colors.white70),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            TextButton(
                                onPressed: _onPop, child: Text("Kembali"))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          // CustomAppBar(
          //   title: "Maklumat Unit Kosong",
          //   centerTitle: false,
          //   onPressedBack: _onPop,
          //   actions: [
          //     PopupMenuButton<int>(
          //       itemBuilder: (context) => [
          //         PopupMenuItem(
          //           value: 1,
          //           onTap: () {
          //             _go(const SubrentMainScreen());
          //           },
          //           child: const Row(
          //             children: [
          //               Icon(Icons.report),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Text("Lapor Penghuni")
          //             ],
          //           ),
          //         ),
          //       ],
          //       offset: const Offset(0, 50),
          //       color: Colors.white,
          //       elevation: 2,
          //     ),
          //   ],
          // ),
          body: Container(
            color: AppColors.primary.color,
            child: SectionContainer(
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: Form(
                key: formKey,
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
                              style:
                                  appTextStyle(size: 14, color: Colors.white),
                            ),
                            side: BorderSide.none,
                            shape: const StadiumBorder(),
                            color: const WidgetStatePropertyAll(Colors.blue),
                          ),
                        ),
                        _gap(size: 22),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            _bancianBloc.unitData.unit?.status ?? "-",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        _section("Info Unit Kosong", size: 26, btmPadding: 0),
                        GestureDetector(
                          onTap: () {
                            CustomModalSheet.show(
                                context: context,
                                builder: (_) => Scaffold(
                                      body: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.warning_amber_rounded,
                                              color: Colors.red,
                                              size: 60,
                                            ),
                                            SizedBox(height: 12),
                                            Text(
                                              "Lapor Penghuni",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                                "Adakah anda mahu melapor penghuni ini?",
                                                style: TextStyle(fontSize: 18),
                                                textAlign: TextAlign.center),
                                          ],
                                        ),
                                      ),
                                      bottomNavigationBar: Container(
                                        height: 50,
                                        margin: EdgeInsets.all(10),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          SubrentMainScreen()));
                                            },
                                            child: Text("Lapor Penghuni")),
                                      ),
                                    ));
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 16, bottom: 20),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.black54),
                                borderRadius: BorderRadius.circular(14)),
                            child: ListTile(
                              leading: Icon(Icons.campaign_outlined),
                              title: Text("Lapor penghuni"),
                              subtitle: Text(
                                "Isi borang jika bukan penghuni",
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Icon(Icons.chevron_right),
                            ),
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
                        //             _bancianBloc
                        //                     .unitData.unit?.housingProject?.desc ??
                        //                 "-",
                        //             style: const TextStyle(
                        //                 fontSize: 18, fontWeight: FontWeight.bold),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _section("Gambar"),
                            // GestureDetector(
                            //     onTap: () {
                            //       _go(BancianAddProof(onTakePicture: (val) {
                            //         setState(() {
                            //           statusData.addImages(val);
                            //         });
                            //       }));
                            //     },
                            //     child: const Icon(Icons.camera_alt_rounded))
                          ],
                        ),
                        SizedBox(
                          height: 100,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _go(BancianAddProof(onTakePicture: (val) {
                                    setState(() {
                                      statusData.addImages(val);
                                    });
                                  }));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.midGrey.color,
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 20),
                                  margin: EdgeInsets.only(right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_a_photo_outlined,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        "Add\nImage",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 10),
                                      )
                                    ],
                                  ),
                                ),
                              ),
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
                        // _gap(size: 14),
                        // _section("Cap Jari"),
                        // SectionContainer(
                        //   border: Border.all(color: Colors.grey),
                        //   padding: EdgeInsets.zero,
                        //   margin: EdgeInsets.zero,
                        //   child: ListTile(
                        //     tileColor: Colors.white,
                        //     leading: const Icon(Icons.fingerprint),
                        //     title: const Text("Sahkan Cap Jari"),
                        //     onTap: () => _go(BancianFingerprint(
                        //       onVerifyFP: (val) {
                        //         setState(() => isVerifyFP = val);
                        //       },
                        //     )),
                        //   ),
                        // ),
                        _gap(size: 22),
                        Divider(),
                        _gap(size: 18),
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

                        _section("Nota Tambahan"),
                        CustomFormField(
                          maxLines: 3,
                          addBorder: true,
                          controller: remarkCtrl,
                          validator: (value) {
                            if (value == null || value.isEmpty) return '';
                            return null;
                          },
                          hintText: "Masukkan sebarang nota di sini",
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
                _go(BancianResult(
                  isVerify: isVerifyFP,
                ));
              } else if (state is BancianError) {
                EasyLoading.dismiss();
                CustomFlushbar.of(context).showFailed(msg: state.msg);
              }
            },
            child: BottomBarButton(
              title: "Tamatkan Bancian",
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
                    title: "Semakan Diperlukan",
                    subtitle: "Periksa semula maklumat anda sebelum meneruskan",
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
        );
      }),
    );
  }

  SizedBox _gap({double size = 10}) {
    return SizedBox(height: size);
  }

  // _borangTile({required String label, required Widget screen}) {
  //   return Column(
  //     children: [
  //       BorangTile(
  //         title: "Borang",
  //         subtitle: label,
  //         onTap: () {
  //           _go(screen);
  //         },
  //       ),
  //       _gap(),
  //     ],
  //   );
  // }

  Widget _section(String title, {double size = 20, double btmPadding = 10}) {
    return Column(
      children: [
        Text(
          title,
          style: appTextStyle(
              color: AppColors.darkGrey.color,
              fontWeight: FontWeight.bold,
              size: size),
        ),
        SizedBox(height: btmPadding)
      ],
    );
  }

  Future _go(Widget screen) => Navigator.push(context,
      PageTransition(child: screen, type: PageTransitionType.rightToLeft));
}
