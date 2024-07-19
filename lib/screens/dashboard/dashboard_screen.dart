import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/config/constants/app_size.dart';
import 'package:eperumahan_bancian/screens/dashboard/kawasan_modal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../components/indicator.dart';
import 'dashboard_header.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return BgImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardHeader(),
              const SizedBox(height: 22),
              _title(
                  title: "Aktiviti anda • ",
                  subtitle:
                      "${DateFormat.MMMM().format(DateTime.now())} ${DateFormat.y().format(DateTime.now())}"),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _item(
                            title: "Unit rumah",
                            val: "118",
                            icon: Icons.apartment_outlined),
                        _item(
                            title: "Berjaya",
                            val: "90",
                            icon: Icons.check_circle_outline,
                            color: Colors.green),
                        _item(
                            title: "Gagal",
                            val: "28",
                            icon: Icons.cancel_outlined,
                            color: Colors.red),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              _title(title: "Carta kawasan"),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _title(
                            title: "PPR Sri Selangor",
                            padding: EdgeInsets.zero),
                        IconButton(
                            onPressed: () {
                              const KawasanModal().show(context);
                            },
                            icon: const Icon(Icons.keyboard_arrow_down_rounded))
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
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
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 6),
        Text(
          val,
          style: appTextStyle(size: 22, fontWeight: FontWeight.bold),
        ),
        Text(title),
      ],
    );
  }
}
