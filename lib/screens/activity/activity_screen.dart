import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/components/custom_textfield.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/screens/activity/activity_search_screen.dart';
import 'package:eperumahan_bancian/services/qr_code_scanner_widget.dart';
import 'package:flutter/material.dart';

import '../../components/search_textfield.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final dropdown = ["Zon", "Kawasan", "Blok", "Tingkat"];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BgImage(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.18),
                const Center(
                  child: Text(
                    "Sila Pilih Kawasan Bancian",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                  ),
                ),
                const SearchTextField(),
                ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dropdown.length,
                    itemBuilder: (_, index) => _dropdownField(
                        hintText: dropdown[index], onTap: () {})),
                ElevatedButton(
                    onPressed: () => _go(const ActivitySearchScreen()),
                    child: const Text("Carian")),
                _divider(),
                ElevatedButton(
                    onPressed: () {
                      _go(const QrCodeScannerWidget());
                    },
                    child: const Text("QR Scan Code")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _go(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  _dropdownField({required String hintText, required void Function() onTap}) {
    return CustomTextField(
      suffixIcon: Icons.unfold_more_rounded,
      readOnly: true,
      hintText: hintText,
      fillColor: Colors.white,
      onTap: onTap,
    );
  }

  _divider() {
    return Row(
      children: [
        Expanded(
            child: Divider(endIndent: 20, color: AppColors.dimmedPurple.color)),
        Text(
          "atau",
          style: TextStyle(color: AppColors.dimmedPurple.color),
        ),
        Expanded(
            child: Divider(indent: 20, color: AppColors.dimmedPurple.color)),
      ],
    );
  }
}
