import 'package:eperumahan_bancian/screens/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
  late ProfileBloc _profileBloc;
  late TextEditingController nameCtrl, emailCtrl, phoneCtrl;
  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context, listen: false);
    _profileBloc.add(FetchProfile());
    nameCtrl = TextEditingController(text: "-");
    emailCtrl = TextEditingController(text: "-");
    phoneCtrl = TextEditingController(text: "-");
  }

  @override
  Widget build(BuildContext context) {
    return BgImage(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(
        title: "Maklumat Akaun",
        centerTitle: false,
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoading) {
            EasyLoading.show();
          } else if (state is ProfileSuccess) {
            EasyLoading.dismiss();
            setState(() {
              nameCtrl.text = _nullConverter(data: state.data.name);
              phoneCtrl.text = _nullConverter(data: state.data.phoneNo);
              emailCtrl.text = _nullConverter(data: state.data.email);
            });
          } else if (state is ProfileError) {
            EasyLoading.dismiss();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
                margin: const EdgeInsets.only(top: 20, left: 12, right: 12),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    CustomFormField(
                      title: "Nama",
                      readOnly: true,
                      controller: nameCtrl,
                    ),
                    _gap(),
                    TwoColumnForm(
                      children: [
                        CustomFormField(
                          title: "No Telefon",
                          controller: phoneCtrl,
                          readOnly: true,
                        ),
                        CustomFormField(
                          title: "Emel",
                          readOnly: true,
                          controller: emailCtrl,
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
      ),
    ));
  }

  _gap({double height = 10}) => SizedBox(height: height);
  String _nullConverter({required String? data, String? placeholder}) =>
      data ?? (placeholder ?? "-");
}
