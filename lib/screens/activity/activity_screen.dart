import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/components/custom_textfield.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final dropdown = ["Zon", "Kawasan", "Blok" /*, "Tingkat"*/];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BgImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.6,
                // color: Colors.amber,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: size.height * 0.3,
                        padding: const EdgeInsets.only(top: 80),
                        color: AppColors.primary.color,
                        child: const Text(
                          "Sila Pilih Kawasan Bancian",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 26, color: Colors.white),
                        ),
                      ),
                    ),
                    Positioned(
                        child: Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...List.generate(
                              dropdown.length,
                              (index) => _dropdownField(
                                  hintText: dropdown[index], onTap: () {})),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.maxFinite,
                            height: 52,
                            child: ElevatedButton(
                                onPressed: () => _goToList(),
                                child: const Text("Carian")),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),

              // const Center(
              //   child: Text(
              //     "Sila Pilih Kawasan Bancian",
              //     textAlign: TextAlign.center,
              //     style: TextStyle(fontSize: 26),
              //   ),
              // ),
              // const SearchTextField(),
              // ListView.builder(
              //     shrinkWrap: true,
              //     padding: EdgeInsets.zero,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemCount: dropdown.length,
              //     itemBuilder: (_, index) =>
              //         _dropdownField(hintText: dropdown[index], onTap: () {})),
              // ElevatedButton(
              //     onPressed: () => _go(const ActivitySearchScreen()),
              //     child: const Text("Carian")),
              // _divider(),
              // ElevatedButton(
              //     onPressed: () {
              //       _go(const QrCodeScannerWidget());
              //     },
              //     child: const Text("QR Scan Code")),
            ],
          ),
        ),
      ),
    );
  }

  _goToList() {
    Navigator.pushNamed(context, RoutesName.activitySearch);
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

  // _divider() {
  //   return Row(
  //     children: [
  //       Expanded(
  //           child: Divider(endIndent: 20, color: AppColors.dimmedPurple.color)),
  //       Text(
  //         "atau",
  //         style: TextStyle(color: AppColors.dimmedPurple.color),
  //       ),
  //       Expanded(
  //           child: Divider(indent: 20, color: AppColors.dimmedPurple.color)),
  //     ],
  //   );
  // }
}
