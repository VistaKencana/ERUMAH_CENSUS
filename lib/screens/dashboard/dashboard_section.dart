import 'dart:developer';

import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/screens/dashboard/dashboard_data_view.dart';
import 'package:eperumahan_bancian/screens/dashboard/model/dashboard_json_model.dart';
import 'package:flutter/material.dart';

class DashboardSection extends StatefulWidget {
  final String? miniTitle;
  final String title;
  final bool isLoading;
  final bool showButton;
  final List<DashboardModel> data;
  const DashboardSection(
      {super.key,
      required this.isLoading,
      required this.data,
      this.miniTitle,
      this.showButton = false,
      required this.title});

  @override
  State<DashboardSection> createState() => _DashboardSectionState();
}

class _DashboardSectionState extends State<DashboardSection> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      //Loading
      return cardWidget(children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator()],
          ),
        ),
      ]);
    }
    //Loaded
    if (widget.data.isNotEmpty) {
      //set limit 3
      int listLen = widget.data.length >= 3 ? 3 : widget.data.length;

      return cardWidget(
          children: List.generate(listLen, (index) {
        String? listTitle = widget.data[index].housingProject?.desc;
        String? listSubtitle = (widget.data[index].visit?.isEmpty ?? true)
            ? "Bancian Pertama"
            : widget.data[index].visit?.first.remark;
        String? listUnitNo = widget.data[index].unit?.unitNo;

        log("this is unit no test ===> $listUnitNo");

        return _dataTile(context,
            data: widget.data[index],
            title: listTitle,
            subtitle: listSubtitle,
            unitNo: listUnitNo);
      }));
    } else {
      //Empty
      return cardWidget(children: [
        const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Tiada Data")],
        )
      ]);
    }
  }

  cardWidget({required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 18, bottom: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          // border: Border.all(color: Colors.grey.shade400)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 4, top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.miniTitle != null)
                    Text(
                      widget.miniTitle ?? "",
                      style: appTextStyle(
                          fontWeight: FontWeight.bold,
                          size: 14,
                          color: AppColors.dimmedPurple.color),
                    ),
                  Text(
                    widget.title,
                    style: appTextStyle(
                        color: AppColors.primary.color,
                        size: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ...children,
          ],
        ),
      ),
    );
  }

  ListTile _dataTile(
    BuildContext context, {
    required String? title,
    required String? subtitle,
    required String? unitNo,
    required DashboardModel data,
  }) {
    return ListTile(
      onTap: () {
        DashboardDataView.show(context,
            data: data, onPressed: widget.showButton ? () {} : null);
      },
      isThreeLine: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      tileColor: Colors.white,
      leading: Container(
        decoration: BoxDecoration(
          color: AppColors.midGrey.color,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 4),
        child: const Icon(Icons.location_on),
      ),
      title: Text(
        title ?? "-",
        style: const TextStyle(overflow: TextOverflow.ellipsis),
      ),
      subtitle: Text("${unitNo ?? "-"}\n${subtitle ?? "-"}"),
      trailing: const SizedBox(
          height: double.infinity, child: Icon(Icons.chevron_right)),
    );
  }
}
