import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/components/custom_appbar.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../components/custom_tab.dart';
import 'bancian_constants.dart';

class BancianMainScreen extends StatefulWidget {
  const BancianMainScreen({super.key});

  @override
  State<BancianMainScreen> createState() => _BancianMainScreenState();
}

class _BancianMainScreenState extends State<BancianMainScreen> {
  int selectedIndex = 0;
  final tabBtn = BancianForms.values;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return DefaultTabController(
      length: tabBtn.length,
      child: BgImage(
        child: Scaffold(
            appBar: const CustomAppBar(
              title: "Maklumat Penghuni",
              centerTitle: false,
            ),
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    padding: const EdgeInsets.all(14),
                    color: Colors.white.withOpacity(0.7),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(Icons.location_on),
                        const Text(
                          "PPR Sri Selangor",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: size.width * .1),
                        Text(
                          "Unit No: 01-1-01",
                          style: TextStyle(color: AppColors.dimmedPurple.color),
                        )
                      ],
                    ),
                  ),
                  TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    labelColor: Colors.white,
                    unselectedLabelColor: AppColors.brightBlue.color,
                    indicatorSize: TabBarIndicatorSize.label,
                    dividerColor: AppColors.brightBlue.color,
                    indicator: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                    ),
                    onTap: (value) => setState(() => selectedIndex = value),
                    tabs: List.generate(
                      tabBtn.length,
                      (index) => CustomTab(
                          text: tabBtn[index].title,
                          isSelected: selectedIndex == index),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                            tabBtn.length, (index) => tabBtn[index].screen)),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
