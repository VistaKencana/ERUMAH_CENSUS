import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/components/borang_listtile.dart';
import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/components/custom_appbar.dart';
import 'package:eperumahan_bancian/components/custom_form_field.dart';
import 'package:eperumahan_bancian/components/section_container.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_fingerprint.dart';
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
    Size size = MediaQuery.sizeOf(context);
    return Form(
      key: formKey,
      child: BgImage(
        child: Scaffold(
          appBar: const CustomAppBar(title: "Maklumat Subrent"),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Icon(Icons.location_on),
                            Text(
                              _bancianBloc
                                      .unitData.unit?.housingProject?.desc ??
                                  "-",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: size.width * .1),
                            Text(
                              _bancianBloc.unitData.unit?.status ?? "-",
                              style: TextStyle(
                                  color: AppColors.dimmedPurple.color),
                            ),
                            SizedBox(width: size.width * .1),
                            Text(
                              "Unit No:${_bancianBloc.unitData.unit?.no ?? "-"}",
                              style: TextStyle(
                                  color: AppColors.dimmedPurple.color),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //MARK: Cap Jari
                  _section("Cap Jari"),
                  SectionContainer(
                    border: Border.all(color: Colors.grey),
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    child: ListTile(
                      tileColor: Colors.white,
                      leading: const Icon(Icons.fingerprint),
                      title: const Text("Sahkan Cap Jari"),
                      onTap: () => _go(const BancianFingerprint()),
                    ),
                  ),
                  _gap(),
                  //MARK: Rmark
                  _section("Catatan"),
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
                  _gap(size: 26),
                  const Divider(height: 2), _gap(size: 20),
                  _section("Maklumat subrent"),
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
            onTap: () {
              setState(() {
                statusData = statusData.copyWith(
                  remark: remarkCtrl.text,
                );
              });
            },
          ),
        ),
      ),
    );
  }

  _borangTile(
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

  _addSubrentBtn({required bool showBtn}) {
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
                  color: Colors.black.withOpacity(0.1),
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

  _gap({double size = 10}) {
    return SizedBox(height: size);
  }

  _section(String title) {
    return Text(
      title,
      style: appTextStyle(fontWeight: FontWeight.bold, size: 20),
    );
  }

  _go(Widget screen) => Navigator.push(context,
      PageTransition(child: screen, type: PageTransitionType.rightToLeft));
}
