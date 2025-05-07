import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/config/constants/app_size.dart';
import 'package:eperumahan_bancian/screens/dashboard/dashboard_header.dart';
import 'package:eperumahan_bancian/screens/dashboard/dashboard_section.dart';
import 'package:eperumahan_bancian/screens/dashboard/kawasan_modal.dart';
import 'package:eperumahan_bancian/screens/dashboard/provider/dashboard_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../components/indicator.dart';
import '../../config/constants/app_images.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashboardProvider dashboardProvider;

  @override
  void initState() {
    super.initState();
    dashboardProvider = Provider.of(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((a) {
      dashboardProvider.initDashboard();
    });
  }

  String nullOrEmptyReplace(String? val, {String? replaceWIth}) {
    String result = replaceWIth ?? "0";
    if (val == null) {
      return result;
    }
    return "${((val.isEmpty) ? result : val)} Unit";
  }

  @override
  Widget build(BuildContext context) {
    final watchDashboard = Provider.of<DashboardProvider>(context);
    return BgImage(
      // bgPath: AppImages.homeBg.path,
      child: LayoutBuilder(builder: (context, constraint) {
        return Scaffold(
          // backgroundColor: Colors.transparent,
          // backgroundColor: AppColors.lightBlue.color,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DashboardHeader(),
                SizedBox(height: constraint.maxHeight * .03),
                //MARK: Latest Activity
                GridView(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 3 items per row
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.6,
                  ),
                  children: [
                    //MARK: Latest Activity
                    DashboardSection(
                        isLoading: watchDashboard.latestLoading,
                        title: "Aktiviti terkini",
                        data: watchDashboard.latestList),
                    DashboardSection(
                      isLoading: watchDashboard.incompleteLoading,
                      title: "Untuk susulan",
                      data: watchDashboard.incompleteList,
                      showButton: true,
                    ),
                  ],
                ),
                SizedBox(height: constraint.maxHeight * .03),
                const Divider(height: 18),
                SizedBox(height: constraint.maxHeight * .02),
                //MARK: Incomplete Activity

                //MARK: User Activity
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: AppColors.darkGrey.color,
                            borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          "AKTIVITI ANDA",
                          style: appTextStyle(
                              color: Colors.white,
                              size: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                          "${DateFormat.MMMM().format(DateTime.now())} ${DateFormat.y().format(DateTime.now())}"
                              .toUpperCase(),
                          style: appTextStyle(
                              fontWeight: FontWeight.bold,
                              size: 26,
                              color: Colors.black87)),
                    ],
                  ),
                ),
                SizedBox(height: constraint.maxHeight * .02),
                sectionContainer(children: [
                  watchDashboard.activityLoading
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        )
                      : GridView(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // 3 items per row
                            crossAxisSpacing: 6.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 1.2,
                          ),
                          children: [
                            _item(
                                title: "Unit rumah",
                                val: nullOrEmptyReplace(
                                    watchDashboard.acitivtyData.totalUnit),
                                icon: Icons.apartment_outlined,
                                color: const Color(0xFF8F69EE)),
                            _item(
                                title: "Berjaya",
                                val: nullOrEmptyReplace(
                                    watchDashboard.acitivtyData.totalComplete),
                                icon: Icons.check_circle_outline,
                                color: const Color(0xFF28C194)),
                            _item(
                                title: "Dalam Proses",
                                val: nullOrEmptyReplace(watchDashboard
                                    .acitivtyData.totalInProgress),
                                icon: Icons.error_outline_outlined,
                                color: Colors.amber),
                          ],
                        ),
                ]),

                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      }),
    );
  }

  _title(
      {required String title,
      String? subtitle,
      EdgeInsetsGeometry? padding,
      void Function()? onTap,
      Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: color,
        padding: padding ?? const EdgeInsets.only(left: 16, bottom: 12),
        child: Row(
          children: [
            Text(
              title,
              style: appTextStyle(
                  color: AppColors.primary.color,
                  size: 22,
                  fontWeight: FontWeight.bold),
            ),
            Text(subtitle ?? "",
                style: appTextStyle(
                  color: AppColors.primary.color,
                  size: 14,
                )),
          ],
        ),
      ),
    );
  }

  _item({
    required String title,
    required String val,
    required IconData icon,
    Color? color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: color?.withOpacity(.2)),
              child: Icon(icon, size: 24, color: color),
            ),
            const Spacer(),
            Text(
              title,
              style: appTextStyle(size: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              val,
              style: appTextStyle(
                  size: 16.sp, color: AppColors.dimmedPurple.color),
            ),
          ],
        ),
      ),
    );
  }

  listTile(
      {required String title,
      required String phoneNo,
      bool addDivider = true}) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(8),
          tileColor: Colors.white,
          leading: Image.asset(
            AppImages.custService.path,
            height: 45,
          ),
          title: Text(title),
          subtitle: Text(phoneNo),
          trailing: const Icon(Icons.chevron_right),
        ),
        Visibility(
          visible: addDivider,
          child: _divider(),
        ),
      ],
    );
  }

  _divider() {
    return const Divider(
      height: 0,
      indent: 16,
      endIndent: 14,
    );
  }

  Widget sectionContainer({
    List<Widget> children = const <Widget>[],
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    return Card(
      elevation: 0,
      // margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        // padding: const EdgeInsets.only(top: 18, bottom: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          // border: Border.all(color: Colors.grey.shade400)
        ),
        child: Column(
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            crossAxisAlignment: crossAxisAlignment,
            children: children),
      ),
    );
  }

  cartaPerumahan() {
    return Column(
      children: [
        const SizedBox(height: 28),
        _title(title: "Carta perumahan"),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 28),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade400)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _title(title: "PPR Desa Tun Razak", padding: EdgeInsets.zero),
                  IconButton(
                      onPressed: () {
                        const KawasanModal().show(context);
                      },
                      icon: const Icon(Icons.keyboard_arrow_down_rounded))
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Keseluruhan: 20000",
                  style: appTextStyle(size: 13),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: AppSize().screenWidth! * .4,
                    width: AppSize().screenWidth! * .4,
                    child: PieChart(PieChartData(sections: [
                      PieChartSectionData(value: 20, color: Colors.blue),
                      PieChartSectionData(),
                    ])),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Indicator(
                    color: Colors.blue,
                    text: 'Selesai',
                    isSquare: true,
                  ),
                  Indicator(
                    color: Colors.cyan,
                    text: 'Dalam proses',
                    isSquare: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  maklumatTelefon() {
    return Column(
      children: [
        _title(title: 'Makmulat Telefon'),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade400)),
          child: Column(
            children: [
              listTile(title: "Admin", phoneNo: "+6034865745614"),
              listTile(
                  title: "Pejabat Zon 1 ",
                  phoneNo: "+6034865745614",
                  addDivider: false),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  headerNew() {
    // SizedBox(height: constraint.maxHeight * .12),
    // AspectRatio(
    //   aspectRatio: 40 / 9,
    //   child: Image.asset(
    //     AppImages.dbklLogo.path,
    //     fit: BoxFit.contain,
    //     height: constraint.maxHeight * .3,
    //     width: constraint.maxWidth * .4,
    //   ),
    // ),
    // SizedBox(height: constraint.maxHeight * .02),
    // Center(
    //   child: Text(
    //     "PENGURUSAN\nPERUMAHAN",
    //     style: appTextStyle(
    //         size: 20.sp,
    //         fontWeight: FontWeight.w700,
    //         color: Colors.white),
    //     textAlign: TextAlign.center,
    //   ),
    // ),
    // SizedBox(height: constraint.maxHeight * .02),
    // Container(
    //   margin: const EdgeInsets.symmetric(horizontal: 16),
    //   padding: const EdgeInsets.all(14),
    //   decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(10)),
    //   child: Row(
    //     children: [
    //       Icon(Icons.search, color: AppColors.darkGrey.color),
    //       SizedBox(width: constraint.maxWidth * .04),
    //       Text(
    //         "Carian PPR",
    //         style: appTextStyle(color: AppColors.darkGrey.color),
    //       )
    //     ],
    //   ),
    // ),
  }
}
