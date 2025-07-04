import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../config/constants/app_colors.dart';
import '../../config/constants/app_size.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: AppSize().screenHeight! * .17,
        child: LayoutBuilder(builder: (context, constraint) {
          return Column(
            children: [
              Container(
                color: Colors.black,
                width: double.infinity,
                height: AppSize().screenHeight! * .14,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          Text(
                            "Dashboard",
                            style: appTextStyle(
                                color: Colors.white,
                                size: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
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
                  ],
                ),
              ),
              Container(
                height: AppSize().screenHeight! * .03,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      // Color(0xFFBA2C45), // 0%
                      Color(0xFFBA2C45),
                      Color.fromARGB(255, 252, 248, 249), // 0%
                      // Color(0xFF040001), // 100%
                    ],
                  ),
                ),
              ),
            ],
          );
          // return Stack(
          //   children: [
          //     Container(
          //       color: Colors.black,
          //       height: AppSize().screenHeight! * .17,
          //     ),
          //     // Positioned(
          //     //     bottom: 0,
          //     //     left: constraint.maxHeight * .05,
          //     //     right: constraint.maxHeight * .05,
          //     //     child: SizedBox(
          //     //       height: 60,
          //     //       child: Card(
          //     //         color: Colors.white,
          //     //         clipBehavior: Clip.antiAlias,
          //     //         child: IntrinsicHeight(
          //     //           child: Row(
          //     //             children: [
          //     //               IconButton(
          //     //                   onPressed: () {
          //     //                     moveScreenTo(1);
          //     //                   },
          //     //                   icon: const Icon(Icons.qr_code_scanner)),
          //     //               VerticalDivider(
          //     //                 color: Colors.grey.shade200,
          //     //                 width: 0,
          //     //               ),
          //     //               const SizedBox(width: 1),
          //     //               Expanded(
          //     //                 child: TextFormField(
          //     //                   readOnly: true,
          //     //                   onTap: () => homePageController.jumpToPage(2),
          //     //                   decoration: const InputDecoration(
          //     //                       fillColor: Colors.white,
          //     //                       hintText: "Carian Perumahan",
          //     //                       hintStyle: TextStyle(color: Colors.grey),
          //     //                       border: InputBorder.none,
          //     //                       focusedBorder: InputBorder.none),
          //     //                 ),
          //     //               ),
          //     //             ],
          //     //           ),
          //     //         ),
          //     //       ),
          //     //     ))
          //   ],
          // );
        }));
  }
}
