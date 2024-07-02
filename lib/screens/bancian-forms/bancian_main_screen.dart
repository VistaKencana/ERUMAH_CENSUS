import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/components/custom_alertdialog.dart';
import 'package:eperumahan_bancian/components/custom_textfield.dart';
import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/anak_tanggungan/tanggungan_form.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_status_field.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/pasangan/pasangan_form.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/pendapatan/pendapatan_form.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/penghuni/penghuni_form.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/borang_listtile.dart';
import '../../components/bottombar_button.dart';
import '../../components/custom_appbar.dart';
import '../../config/constants/app_colors.dart';

class BancianMainScreen extends StatefulWidget {
  final bool? isEdit;
  const BancianMainScreen({super.key, this.isEdit});

  @override
  State<BancianMainScreen> createState() => _BancianMainScreenState();
}

class _BancianMainScreenState extends State<BancianMainScreen> {
  _isEdit() => (widget.isEdit != null && widget.isEdit == true);
  _onPop() {
    if (_isEdit()) {
      Navigator.pop(context);
      return;
    }
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: _isEdit(),
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
                          const Text(
                            "PPR Sri Selangor",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: size.width * .1),
                          Text(
                            "Unit No: 01-1-01",
                            style:
                                TextStyle(color: AppColors.dimmedPurple.color),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text("Lawatan 2"),
                    ],
                  ),
                ),
                _borangTile(
                    label: "Maklumat Penghuni",
                    screen: PenghuniForm(isEdit: widget.isEdit)),
                _borangTile(
                    label: "Maklumat Pasangan", screen: const PasanganForm()),
                _borangTile(
                    label: "Maklumat Pendapatan",
                    screen: const PendapatanForm()),
                _borangTile(
                    label: "Maklumat Anak & Tanggungan",
                    screen: const TanggunganForm()),
                _gap(size: 20),
                _section("Cap Jari"),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()),
                  child: const ListTile(
                    tileColor: Colors.white,
                    leading: Icon(Icons.fingerprint),
                    title: Text("Sahkan Cap Jari"),
                  ),
                ),
                _gap(),
                _section("Status Bancian"),
                const BancianStatusField(
                  initialVal: "Bancian Biasa",
                ),
                _gap(),
                _section("Catatan"),
                const CustomTextField(
                  maxLines: 3,
                  hintText: "Sila tulis catatan",
                  contentPadding:
                      EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                ),
                _gap(size: 20),
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

  _borangTile({required String label, required Widget screen}) {
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

  _section(String title) {
    return Text(
      title,
      style: appTextStyle(fontWeight: FontWeight.bold, size: 20),
    );
  }

  _go(Widget screen) => Navigator.push(context,
      PageTransition(child: screen, type: PageTransitionType.rightToLeft));
}
