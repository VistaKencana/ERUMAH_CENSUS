import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/components/custom_appbar.dart';
import 'package:eperumahan_bancian/components/custom_form_field.dart';
import 'package:eperumahan_bancian/components/two_column_form.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BgImage(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(
        title: "Daftar akaun",
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
                    isMandatory: true,
                  ),
                  _gap(),
                  const CustomFormField(
                    title: "No Kad Pengenalan",
                    isMandatory: true,
                  ),
                  _gap(),
                  const TwoColumnForm(
                    children: [
                      CustomFormField(
                        title: "No Telefon",
                        isMandatory: true,
                      ),
                      CustomFormField(
                        title: "Emel",
                        isMandatory: true,
                      ),
                    ],
                  ),
                  _gap(),
                  CustomFormField(
                    title: "Kawasan",
                    isMandatory: true,
                    suffixIcon: Icons.arrow_drop_down,
                    readOnly: true,
                    fillColor: Colors.white,
                    onTap: () {},
                  ),
                  _gap(height: 24),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text("Daftar")))
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
