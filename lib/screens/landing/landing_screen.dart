import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/config/constants/app_images.dart';
import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraint) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(140.r)),
                child: Image.asset(AppImages.landing.path)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: constraint.maxHeight * .04),
                  Text(
                    "Pengurusan\nPerumahan",
                    style: TextStyle(
                        color: AppColors.primary.color,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.1,
                        height: 1.2,
                        fontSize: 30.sp),
                  ),
                  SizedBox(height: constraint.maxHeight * .02),
                  Text(
                    "Menguruskan pembangunan, penyelenggaraan, dan penyediaan fasiliti perumahan",
                    style: TextStyle(
                        color: AppColors.primary.color,
                        letterSpacing: 0.1,
                        height: 1.2,
                        fontSize: 16.sp),
                  ),
                  SizedBox(height: constraint.maxHeight * .06),
                  SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RoutesName.login);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text("Log Masuk"),
                          )))
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
