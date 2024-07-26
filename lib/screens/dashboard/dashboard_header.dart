import 'package:flutter/material.dart';
import '../../config/constants/app_colors.dart';
import '../../config/constants/app_size.dart';
import '../home_screen.dart';

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
                color: AppColors.primary.color,
                height: AppSize().screenHeight! * .17,
              ),
              Positioned(
                  bottom: 0,
                  left: constraint.maxHeight * .05,
                  right: constraint.maxHeight * .05,
                  child: SizedBox(
                    height: 60,
                    child: Card(
                      color: Colors.white,
                      clipBehavior: Clip.antiAlias,
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  moveScreenTo(1);
                                  // QrNavigationPref.setFromHome(val: true).then(
                                  //   (val) => Navigator.push(
                                  //       context,
                                  //       PageTransition(
                                  //           child: const BancianQrscan(),
                                  //           type: PageTransitionType
                                  //               .leftToRight)),
                                  // );
                                },
                                icon: const Icon(Icons.qr_code_scanner)),
                            VerticalDivider(
                              color: Colors.grey.shade200,
                              width: 0,
                            ),
                            const SizedBox(width: 1),
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                onTap: () => homePageController.jumpToPage(2),
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    hintText: "Carian kawasan",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          );
        }));
  }
}
