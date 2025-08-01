import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/anak_tanggungan/anak_modal.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/anak_tanggungan/bloc/anak_tanggungan_bloc.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/capture_card/capture_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

import 'tanggungan_modal.dart';

class TanggunganForm extends StatefulWidget {
  const TanggunganForm({super.key});

  @override
  State<TanggunganForm> createState() => _TanggunganFormState();
}

class _TanggunganFormState extends State<TanggunganForm> {
  List<String> tabName = ["Anak", "Tanggungan"];
  late AnakTanggunganBloc _tanggunganBloc;
  @override
  void initState() {
    super.initState();
    _tanggunganBloc =
        BlocProvider.of<AnakTanggunganBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabName.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Maklumat Anak & Tanggungan"),
          bottom: TabBar(
              tabs: List.generate(
                  tabName.length,
                  (index) => Tab(
                        text: tabName[index],
                      ))),
        ),
        body: TabBarView(children: [
          _anakTabForm(),
          _tanggunganTabForm(),
        ]),
        bottomNavigationBar: BottomBarButton(
            onTap: () => Navigator.pop(context), title: "Simpan Maklumat"),
      ),
    );
  }

  Widget _anakTabForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            tambahBtn(
              title: "Tambah anak",
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: CaptureCardScreen(onNext: (frontImg, backImg) {
                          context
                              .read<AnakTanggunganBloc>()
                              .addNewChild(frontImg: frontImg, backImg: backImg)
                              .then((val) {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            const AnakModal(
                              isEdit: true,
                              // ignore: use_build_context_synchronously
                            ).show(context);
                          });
                        }),
                        type: PageTransitionType.bottomToTop));
              },
            ),

            // _customTile(title: "Anak 1", name: "Liyana Aina"),
            // _customTile(title: "Anak 2", name: "Nur Fatin")
            BlocBuilder<AnakTanggunganBloc, AnakTanggunganState>(
              builder: (context, state) {
                if (state is AnakTanggunganLoaded) {
                  return Column(
                      children: List.generate(
                          state.childData.length,
                          (index) => _customTile(
                                title: "Anak ${index + 1}",
                                name: state.childData[index].name ?? "",
                                icNo: state.otherData[index].icNo ?? "",
                                onTap: () {
                                  _tanggunganBloc.selectDependant(
                                      state.childData[index], index);
                                },
                              )));
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _tanggunganTabForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            tambahBtn(
              title: "Tambah tanggungan",
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: CaptureCardScreen(onNext: (frontImg, backImg) {
                          context
                              .read<AnakTanggunganBloc>()
                              .addNewDependant(
                                  frontImg: frontImg, backImg: backImg)
                              .then((val) {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            const TanggunganModal(
                              isEdit: true,
                              // ignore: use_build_context_synchronously
                            ).show(context);
                          });
                        }),
                        type: PageTransitionType.bottomToTop));
              },
            ),

            // _customTile(
            //     title: "Tanggungan 1", name: "Liyana Aina", isAnak: false),
            // _customTile(title: "Tanggungan 2", name: "Nur Fatin", isAnak: false)
            BlocBuilder<AnakTanggunganBloc, AnakTanggunganState>(
              builder: (context, state) {
                if (state is AnakTanggunganLoaded) {
                  return Column(
                      children: List.generate(
                          state.otherData.length,
                          (index) => _customTile(
                                isAnak: false,
                                title: "Tanggungan ${index + 1}",
                                name: state.otherData[index].name ?? "",
                                icNo: state.otherData[index].icNo ?? "",
                                onTap: () {
                                  _tanggunganBloc.selectDependant(
                                      state.otherData[index], index);
                                },
                              )));
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _customTile(
      {required String title,
      required String name,
      required String icNo,
      bool isAnak = true,
      void Function()? onTap}) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
        isAnak
            ? const AnakModal().show(context)
            : const TanggunganModal().show(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black26),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      FaIcon(FontAwesomeIcons.user, size: 20),
                      const SizedBox(width: 8),
                      Text(title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(name.isEmpty ? "Tiada Nama" : name,
                      style: TextStyle(
                          color: name.isEmpty ? Colors.black54 : null,
                          fontStyle: name.isEmpty
                              ? FontStyle.italic
                              : FontStyle.normal)),
                  SizedBox(height: 4),
                  Text(icNo.isEmpty ? "Tiada IC No" : icNo,
                      style: TextStyle(
                          color: icNo.isEmpty ? Colors.black54 : null,
                          fontStyle: icNo.isEmpty
                              ? FontStyle.italic
                              : FontStyle.normal)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );

    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: [
    //     ListTile(
    //       onTap: () {
    //         if (onTap != null) {
    //           onTap();
    //         }
    //         isAnak
    //             ? const AnakModal().show(context)
    //             : const TanggunganModal().show(context);
    //       },
    //       contentPadding: const EdgeInsets.all(12),
    //       leading: const CircleAvatar(
    //         child: Icon(Icons.person),
    //       ),
    //       title: Text(title),
    //       subtitle: Text(name),
    //     ),
    //     const Divider(
    //       height: 0,
    //       indent: 30,
    //       color: Colors.black12,
    //       endIndent: 10,
    //     ),
    //   ],
    // );
  }

  Widget tambahBtn({required String title, required Function()? onTap}) {
    return Column(
      children: [
        SizedBox(height: 12),
        GestureDetector(
          onTap: onTap,
          child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black26),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black54)),
                    child: const Icon(
                      Icons.add,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
