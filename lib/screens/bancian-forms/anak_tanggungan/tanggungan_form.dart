import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/anak_tanggungan/anak_modal.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/anak_tanggungan/bloc/anak_tanggungan_bloc.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/capture_card/capture_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () {
              final index = DefaultTabController.of(context).index;
              if (index == 0) {
                // Do something for "Anak"
                addAnak();
              } else {
                // Do something for "Tanggungan"
                addTanggungan();
              }
            },
            backgroundColor: AppColors.primary.color,
            foregroundColor: Colors.white,
            child: Icon(Icons.add),
          ),
        ),
        bottomNavigationBar: BottomBarButton(
            onTap: () => Navigator.pop(context), title: "Simpan"),
      ),
    );
  }

  void pushScreen(Widget screen) {
    Navigator.push(context,
        PageTransition(child: screen, type: PageTransitionType.bottomToTop));
  }

  void addAnak() {
    pushScreen(
      CaptureCardScreen(onNext: (frontImg, backImg) {
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
    );
  }

  void addTanggungan() {
    pushScreen(
      CaptureCardScreen(onNext: (frontImg, backImg) {
        context
            .read<AnakTanggunganBloc>()
            .addNewDependant(frontImg: frontImg, backImg: backImg)
            .then((val) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          const TanggunganModal(
            isEdit: true,
            // ignore: use_build_context_synchronously
          ).show(context);
        });
      }),
    );
  }

  Widget _anakTabForm() {
    return BlocBuilder<AnakTanggunganBloc, AnakTanggunganState>(
        builder: (context, state) {
      if (state is AnakTanggunganLoaded) {
        final length = state.childData.length;
        if (length == 0) {
          return emptyScren(
              title: "Tiada Data Anak",
              buttonText: "Tambah Anak",
              onPressed: addAnak);
        }
        return ListView(
            children: List.generate(
                length,
                (index) => _customTile(
                      title: "Anak ${index + 1}",
                      name: state.childData[index].name ?? "",
                      onTap: () {
                        _tanggunganBloc.selectDependant(
                            state.childData[index], index);
                      },
                    )));
      }
      return const SizedBox();
    });
  }

  Widget emptyScren(
      {required String title,
      required String buttonText,
      void Function()? onPressed}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_box_rounded, size: 80, color: Colors.black26),
          Text(title),
          ElevatedButton(
            onPressed: onPressed,
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  Widget _tanggunganTabForm() {
    return BlocBuilder<AnakTanggunganBloc, AnakTanggunganState>(
        builder: (context, state) {
      if (state is AnakTanggunganLoaded) {
        final length = state.otherData.length;
        if (length == 0) {
          return emptyScren(
              title: "Tiada Data Tanggungan",
              buttonText: "Tambah Tanggungan",
              onPressed: addTanggungan);
        }
        return ListView(
            children: List.generate(
                length,
                (index) => _customTile(
                      title: "Tanggungan ${index + 1}",
                      name: state.otherData[index].name ?? "",
                      onTap: () {
                        _tanggunganBloc.selectDependant(
                            state.otherData[index], index);
                      },
                    )));
      }
      return const SizedBox();
    });
  }

  Widget _customTile(
      {required String title,
      required String name,
      bool isAnak = true,
      void Function()? onTap}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListTile(
          onTap: () {
            if (onTap != null) {
              onTap();
            }
            isAnak
                ? const AnakModal().show(context)
                : const TanggunganModal().show(context);
          },
          contentPadding: const EdgeInsets.all(12),
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(title),
          subtitle: Text(name),
        ),
        const Divider(
          height: 0,
          indent: 30,
          color: Colors.black12,
          endIndent: 10,
        ),
      ],
    );
  }
}
