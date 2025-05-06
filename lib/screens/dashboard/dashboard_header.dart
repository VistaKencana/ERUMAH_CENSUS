import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/config/constants/app_images.dart';
import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/constants/app_size.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: AppSize().screenHeight! * .21,
        child: LayoutBuilder(builder: (context, constraint) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.greenBg.path),
                      fit: BoxFit.cover),
                ),
                height: AppSize().screenHeight! * .2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Text(
                            "Dashboard",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28.sp,
                                color: Colors.white),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RoutesName.profile);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.midGrey.color,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(top: 4),
                              child: const Icon(Icons.person),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                  ],
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   left: constraint.maxHeight * .05,
              //   right: constraint.maxHeight * .05,
              //   child: SizedBox(
              //     height: 60,
              //     child: Card(
              //       color: Colors.white,
              //       clipBehavior: Clip.antiAlias,
              //       child: IntrinsicHeight(
              //         child: Row(
              //           children: [
              //             IconButton(
              //                 onPressed: () {
              //                   moveScreenTo(1);
              //                 },
              //                 icon: const Icon(Icons.qr_code_scanner)),
              //             VerticalDivider(
              //               color: Colors.grey.shade200,
              //               width: 0,
              //             ),
              //             const SizedBox(width: 1),
              //             Expanded(
              //               child: TextFormField(
              //                 readOnly: true,
              //                 onTap: () => homePageController.jumpToPage(2),
              //                 decoration: const InputDecoration(
              //                     fillColor: Colors.white,
              //                     hintText: "Carian Perumahan",
              //                     hintStyle: TextStyle(color: Colors.grey),
              //                     border: InputBorder.none,
              //                     focusedBorder: InputBorder.none),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          );
        }));
  }
}
