import 'dart:typed_data';

import 'package:eperumahan_bancian/screens/bancian-forms/bancian_image_preview.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_main_screen.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bloc/bancian_bloc.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/unit_kedai/unit_kedai_main_screen.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/unit_kosong/unit_kosong_main_screen.dart';
import 'package:eperumahan_bancian/services/camera_service/screenshot_camera_widget.dart';
import 'package:eperumahan_bancian/services/flushbar/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/image_bottom_sheet.dart';

class BancianProofCamera extends StatefulWidget {
  const BancianProofCamera({super.key});

  @override
  State<BancianProofCamera> createState() => _BancianProofCameraState();
}

class _BancianProofCameraState extends State<BancianProofCamera> {
  double initSize = 1;
  double maxSize = 1;
  double minSize = 0.1;
  int maxImage = 3;
  final DraggableScrollableController _controller =
      DraggableScrollableController();
  List<Uint8List> imgs = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Gambar Unit"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
      ),
      body: ScreenshotCameraWidget(
        onTakePicture: (Uint8List uintImg) async {
          _controller.jumpTo(maxSize);
          if (imgs.length >= maxImage) return;
          setState(() => imgs.add(uintImg));
        },
      ),
      bottomSheet: ImageBottomSheet(
        images: imgs,
        initSize: initSize,
        maxSize: maxSize,
        minSize: minSize,
        maxImage: maxImage,
        controller: _controller,
        onNext: (images) {
          final bancianBloc = context.read<BancianBloc>();
          bancianBloc.setImages(imgs: images);
          final screen = getScreenIfUnitKosong(bancianBloc.houseStatus);
          if (screen == null) {
            final screen2 = getScreenByUnitType(bancianBloc.unitTypeCode);
            if (screen2 != null) {
              _goReplace(screen2);
              return;
            }

            CustomFlushbar.of(context).showWarning(
                msg:
                    "Status unit : ${bancianBloc.unitData.unit?.status ?? "Tidak wujud"} comming soon!");
            return;
          }
          _goReplace(screen);
        },
        onTapImage: (image, index) {
          BancianImagePreview(
            canDelete: true,
            title: "Gambar ${index + 1}",
            image: imgs[index],
            onDelete: () {
              setState(() => imgs.removeAt(index));
              Navigator.pop(context);
            },
          ).show(context);
        },
      ),
    );
  }

  Widget? getScreenIfUnitKosong(String stats) {
    final map = {
      //--- Unit Bancian
      // "UNS001": const BancianMainScreen(), //Unit Boleh Dibanci
      // "UNS002": const BancianMainScreen(), //Unit Boleh Dibanci

      //--- Unit Kosong
      "UNS003": const UnitKosongMainScreen(),
      "UNS004": const UnitKosongMainScreen(),
      "UNS005": const UnitKosongMainScreen(),
      "UNS006": const UnitKosongMainScreen(),
      "UNS007": const UnitKosongMainScreen(),
      "UNS008": const UnitKosongMainScreen(),
    };

    return map[stats];
  }

  Widget? getScreenByUnitType(String stats) {
    final map = {
      // Already develop
      "UNT001": const BancianMainScreen(), //KEDIAMAN
      // "UNT002": const UnitKosongMainScreen(), //GERAI
      // "UNT003": const UnitKosongMainScreen(), //DEWAN
      // "UNT004": const UnitKosongMainScreen(), //PEJABAT
      // "UNT005": const UnitKosongMainScreen(), //SURAU
      "UNT006": const UnitKedaiMainScreen(), //KEDAI
      // "UNT007": const UnitKosongMainScreen(), //KEDIAMAN SEMENTARA
      // "UNT008": const UnitKosongMainScreen(), //TADIKA
      // "UNT009": const UnitKosongMainScreen(), //TABIKA
      // "UNT010": const UnitKosongMainScreen(), //PEJABAT PERSATUAN
      // "UNT011": const UnitKosongMainScreen(), //SEWA TAPAK
      // "UNT012": const UnitKosongMainScreen(), //KEMAS
      // "UNT013": const UnitKosongMainScreen(), //TASKA
      // "UNT014": const UnitKosongMainScreen(), //TASKOM
      // "UNT015": const UnitKosongMainScreen(), //GERAI BERKUNCI
      // "UNT016": const UnitKosongMainScreen(), //PUSAT KOMUNITI
      // "UNT017": const UnitKosongMainScreen(), //PUSTAKA
    };

    return map[stats];
  }

  Future _goReplace(Widget screen) => Navigator.pushReplacement(context,
      PageTransition(child: screen, type: PageTransitionType.rightToLeft));
}
