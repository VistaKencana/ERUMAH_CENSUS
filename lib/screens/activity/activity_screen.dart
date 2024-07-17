import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/components/custom_textfield.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/config/constants/app_images.dart';
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
                height: size.height * 0.61,
                // color: Colors.amber,
                child: LayoutBuilder(builder: (context, constraint) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                            height: size.height * 0.38,
                            padding: const EdgeInsets.only(
                                top: 80, left: 12, right: 4, bottom: 10),
                            color: AppColors.primary.color,
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Carian Kawasan \nBancian",
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                ),
                                Image.asset(
                                  AppImages.apartment.path,
                                  scale: 16 / 6,
                                )
                              ],
                            )),
                      ),
                      Positioned(
                          child: Container(
                        margin: EdgeInsets.only(
                            left: constraint.maxWidth * .06,
                            right: constraint.maxWidth * .06),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 1,
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 0.5)
                            ],
                            borderRadius: BorderRadius.circular(14)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: List.generate(
                                    dropdown.length,
                                    (index) => _dropdownField(
                                        hintText: dropdown[index],
                                        onTap: () {})),
                              ),
                            ),
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
                  );
                }),
              ),
              const SizedBox(height: 14),
              _recentTile(),
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

  _recentTile() {
    return ListTile(
        onTap: _goToList,
        minLeadingWidth: 0,
        leading: Container(
          decoration: BoxDecoration(
            color: AppColors.midGrey.color,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 4),
          child: const Icon(Icons.schedule),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14),
        title: Text(
          "PPR Sri Selangor",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.primary.color),
        ),
        subtitle: const Text("Zon 1 • Blok 20"),
        trailing: const Icon(Icons.chevron_right));
  }
}
