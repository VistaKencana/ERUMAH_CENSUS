import 'package:eperumahan_bancian/components/borang_listtile.dart';
import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/custom_form_field.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/models/status_input_model.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/subrent/provider/subrent_provider.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/subrent/subrent_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../bloc/bancian_bloc.dart';

class SubrentMainScreen extends StatefulWidget {
  const SubrentMainScreen({super.key});

  @override
  State<SubrentMainScreen> createState() => _SubrentMainScreenState();
}

class _SubrentMainScreenState extends State<SubrentMainScreen> {
  late BancianBloc _bancianBloc;
  late StatusInputModel statusData;
  final formKey = GlobalKey<FormState>();
  final remarkCtrl = TextEditingController();
  @override
  void initState() {
    super.initState();
    _bancianBloc = BlocProvider.of<BancianBloc>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((val) {
      context.read<SubrentProvider>().initialize();
      context
          .read<SubrentProvider>()
          .setCensusCode(val: _bancianBloc.unitData.censusCode ?? "");
      _bancianBloc.initNotOwner();
      statusData = _bancianBloc.statusNotOwnerData!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final watchSubrent = context.watch<SubrentProvider>().listSubrent;
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Lapor Penghuni"),
          backgroundColor: Color(0xff950606),
          foregroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Navigator.pop(context), icon: Icon(Icons.close)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   padding: EdgeInsets.all(16),
                //   decoration: BoxDecoration(
                //       border:
                //           Border(bottom: BorderSide(color: Colors.black12))),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Container(
                //         padding: EdgeInsets.all(4),
                //         decoration: BoxDecoration(
                //             color: Colors.blueAccent,
                //             borderRadius: BorderRadius.circular(8)),
                //         child: Text(
                //           _bancianBloc.unitData.unit?.status ?? "-",
                //           style: TextStyle(color: Colors.white, fontSize: 14),
                //         ),
                //       ),
                //       _gap(size: 6),
                //       Text(
                //         _bancianBloc.unitData.unit?.housingProject?.desc ?? "-",
                //         style: const TextStyle(
                //             fontSize: 22, fontWeight: FontWeight.bold),
                //       ),
                //       _gap(size: 4),
                //       Row(
                //         children: [
                //           Text(
                //             "Unit No:${_bancianBloc.unitData.unit?.no ?? "-"}",
                //             style:
                //                 TextStyle(color: AppColors.dimmedPurple.color),
                //           ),
                //         ],
                //       ),
                //       _gap(size: 6),
                //     ],
                //   ),
                // ),
                //MARK: Cap Jari
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
                //       onVerifyFP: (val) {},
                //     )),
                //   ),
                // ),
                _gap(size: 40),
                //MARK: Rmark
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

                _gap(size: 40),
                _section("Subrent"), divider(),
                _gap(),
                ...List.generate(watchSubrent.length, (index) {
                  return _borangTile(
                    label: "Subrent ${index + 1}",
                    screen: const SubrentForm(isExistData: true),
                    onTap: () {
                      context
                          .read<SubrentProvider>()
                          .selectSubrent(watchSubrent[index]);
                    },
                  );
                }),
                // _borangTile(label: "label", screen: Container()),
                _addSubrentBtn(showBtn: watchSubrent.length < 5),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomBarButton(
          title: "Selesai Bancian",
          backgroundColor: Colors.black87,
          onTap: () {
            setState(() {
              statusData = statusData.copyWith(
                remark: remarkCtrl.text,
              );
            });
          },
        ),
      ),
    );
  }

  Column _borangTile(
      {required String label,
      required Widget screen,
      required void Function() onTap}) {
    return Column(
      children: [
        BorangTile(
          title: "Borang",
          subtitle: label,
          onTap: () {
            onTap();
            _go(screen);
          },
        ),
        _gap(),
      ],
    );
  }

  Visibility _addSubrentBtn({required bool showBtn}) {
    return Visibility(
      visible: showBtn,
      child: GestureDetector(
        onTap: () {
          _go(const SubrentForm(isExistData: false));
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: const Offset(2, 4),
                ),
              ]),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(width: 4),
              Text("Tambah Subrent"),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _gap({double size = 10}) {
    return SizedBox(height: size);
  }

  Widget _section(String title) {
    return Text(
      title.toUpperCase(),
      style: appTextStyle(
          fontWeight: FontWeight.bold, size: 16, color: Colors.black54),
    );
  }

  Future _go(Widget screen) => Navigator.push(context,
      PageTransition(child: screen, type: PageTransitionType.rightToLeft));
  Widget divider() {
    return Column(
      children: [
        SizedBox(height: 8),
        Divider(height: 0),
        SizedBox(height: 10),
      ],
    );
  }
}
