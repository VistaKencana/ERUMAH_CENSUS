import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/config/constants/app_images.dart';
import 'package:eperumahan_bancian/screens/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/bg_image.dart';
import '../../components/custom_appbar.dart';

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
    return LayoutBuilder(builder: (context, constraint) {
      return BgImage(
          bgPath: AppImages.greenBg.path,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const CustomAppBar(
              title: "Maklumat Akaun",
              foregroundColor: Colors.white,
              centerTitle: true,
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
                    SizedBox(height: constraint.maxHeight * .1),
                    Center(
                      child: Container(
                        height: constraint.maxWidth * .5,
                        width: constraint.maxWidth * .5,
                        decoration: BoxDecoration(
                          color: AppColors.midGrey.color,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(24),
                        child: const FittedBox(
                          child: Icon(
                            Icons.person_outline,
                            // size: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: constraint.maxHeight * .04),
                    Text(
                      nameCtrl.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26.sp,
                          color: Colors.white),
                    ),
                    SizedBox(height: constraint.maxHeight * .02),
                    Text(
                      emailCtrl.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16.sp,
                          color: Colors.white),
                    ),
                    SizedBox(height: constraint.maxHeight * .04),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFC7D2D2)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: constraint.maxWidth * .08,
                            width: constraint.maxWidth * .08,
                            decoration: BoxDecoration(
                              color: AppColors.midGrey.color,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const FittedBox(
                              child: Icon(Icons.phone),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            phoneCtrl.text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 12, vertical: 30),
                    //   margin: const EdgeInsets.only(top: 20, left: 12, right: 12),
                    //   clipBehavior: Clip.antiAlias,
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(16)),
                    //   child: Column(
                    //     children: [
                    //       CustomFormField(
                    //         title: "Nama",
                    //         readOnly: true,
                    //         controller: nameCtrl,
                    //       ),
                    //       _gap(),
                    //       TwoColumnForm(
                    //         children: [
                    //           CustomFormField(
                    //             title: "No Telefon",
                    //             controller: phoneCtrl,
                    //             readOnly: true,
                    //           ),
                    //           CustomFormField(
                    //             title: "Emel",
                    //             readOnly: true,
                    //             controller: emailCtrl,
                    //           ),
                    //         ],
                    //       ),
                    //       _gap(height: 24),
                    //       // SizedBox(
                    //       //     width: double.infinity,
                    //       //     height: 50,
                    //       //     child: ElevatedButton(
                    //       //         onPressed: () {}, child: const Text("Simpan")))
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ));
    });
  }

  // _gap({double height = 10}) => SizedBox(height: height);
  String _nullConverter({required String? data, String? placeholder}) =>
      data ?? (placeholder ?? "-");
}
