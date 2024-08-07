import 'package:eperumahan_bancian/data/hive-manager/repository/qr_navigation_pref.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../config/constants/app_colors.dart';
import '../../config/constants/app_size.dart';
import '../bancian-forms/bancian_qrscan.dart';
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
                                  QrNavigationPref.setFromHome(val: true).then(
                                    (val) => Navigator.push(
                                        context,
                                        PageTransition(
                                            child: const BancianQrscan(),
                                            type: PageTransitionType
                                                .leftToRight)),
                                  );
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
                                onTap: () => moveScreenTo(1),
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
