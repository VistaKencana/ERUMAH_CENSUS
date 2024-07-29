import 'package:flutter/material.dart';

import '../../components/bg_image.dart';
import '../../components/custom_appbar.dart';
import '../../components/custom_form_field.dart';
import '../../components/two_column_form.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return BgImage(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(
        title: "Maklumat Akaun",
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
              margin: const EdgeInsets.only(top: 20, left: 12, right: 12),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  const CustomFormField(
                    title: "Nama",
                    initialValue: "Ahmad Hazim",
                    readOnly: true,
                  ),
                  _gap(),
                  const CustomFormField(
                    title: "No Kad Pengenalan",
                    initialValue: "904678455",
                    readOnly: true,
                  ),
                  _gap(),
                  const TwoColumnForm(
                    children: [
                      CustomFormField(
                        title: "No Telefon",
                        initialValue: "0157486456",
                        readOnly: true,
                      ),
                      CustomFormField(
                        title: "Emel",
                        initialValue: "ahmadhazim@gmail.com",
                        readOnly: true,
                      ),
                    ],
                  ),
                  _gap(height: 24),
                  // SizedBox(
                  //     width: double.infinity,
                  //     height: 50,
                  //     child: ElevatedButton(
                  //         onPressed: () {}, child: const Text("Simpan")))
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  _gap({double height = 10}) => SizedBox(height: height);
}
