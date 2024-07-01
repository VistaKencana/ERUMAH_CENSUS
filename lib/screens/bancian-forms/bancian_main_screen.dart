import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/components/custom_alertdialog.dart';
import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/borang_listtile.dart';
import '../../components/bottombar_button.dart';
import '../../components/custom_appbar.dart';
import '../../config/constants/app_colors.dart';
import 'bancian_constants.dart';

class BancianMainScreen extends StatefulWidget {
  const BancianMainScreen({super.key});

  @override
  State<BancianMainScreen> createState() => _BancianMainScreenState();
}

class _BancianMainScreenState extends State<BancianMainScreen> {
  final forms = BancianForms.values;
  _onPop() {
    CustomAlertDialog(
      title: "Berhenti banci",
      subtitle: "Adakah anda akan berhenti membuat bancian?",
      colorBtnLabel: "Ya",
      onColorBtn: () {
        Navigator.popUntil(
            context, ModalRoute.withName(RoutesName.activitySearch));
      },
      dimmedBtnLabel: "Kembali",
      onDimmedBtn: () => Navigator.pop(context),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _onPop();
      },
      child: BgImage(
          child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: "Maklumat Penghuni",
          centerTitle: false,
          onPressedBack: _onPop,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(Icons.location_on),
                      const Text(
                        "PPR Sri Selangor",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: size.width * .1),
                      Text(
                        "Unit No: 01-1-01",
                        style: TextStyle(color: AppColors.dimmedPurple.color),
                      )
                    ],
                  ),
                ),
                ...List.generate(
                    forms.length,
                    (index) => Column(
                          children: [
                            BorangTile(
                              title: "Borang",
                              subtitle: forms[index].title,
                              onTap: () {
                                _goTemplate(
                                  forms[index].screen,
                                  forms[index].title,
                                );
                              },
                            ),
                            _gap(),
                          ],
                        )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomBarButton(
          title: "Selesai Bancian",
          onTap: () {},
        ),
      )),
    );
  }

  _gap({double size = 10}) {
    return SizedBox(height: size);
  }

  // _go(Widget screen) => Navigator.push(context,
  //     PageTransition(child: screen, type: PageTransitionType.rightToLeft));
  _goTemplate(Widget screen, String title) => Navigator.push(
      context,
      PageTransition(
          child: Scaffold(
              appBar: CustomAppBar(title: title),
              body: screen,
              bottomNavigationBar: BottomBarButton(
                  onTap: () => Navigator.pop(context), title: "Simpan")),
          type: PageTransitionType.rightToLeft));
}
