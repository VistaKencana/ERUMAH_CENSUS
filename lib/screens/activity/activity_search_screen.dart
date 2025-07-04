import 'package:eperumahan_bancian/components/activity_appbar.dart';
import 'package:eperumahan_bancian/components/custom_dropdown_sheet.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/data/api/repositories/bloc/property_bloc/property_bloc.dart';
import 'package:eperumahan_bancian/data/api/repositories/model/property_model.dart';
import 'package:eperumahan_bancian/data/hive-manager/repository/qr_navigation_pref.dart';
import 'package:eperumahan_bancian/screens/qr-home/bloc/qr_bloc.dart';
import 'package:eperumahan_bancian/screens/qr-home/qrscan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'model/bancian_info.dart';

class ActivitySearchScreen extends StatefulWidget {
  const ActivitySearchScreen({super.key});

  @override
  State<ActivitySearchScreen> createState() => _ActivitySearchScreenState();
}

class _ActivitySearchScreenState extends State<ActivitySearchScreen> {
  final info = BancianInfo.getExampleData();
  late PropertyBloc _propertyBloc;
  late QrBloc _qrBloc;
  @override
  void initState() {
    super.initState();
    _propertyBloc = BlocProvider.of<PropertyBloc>(context, listen: false);
    _qrBloc = BlocProvider.of<QrBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final propertyWatch = BlocProvider.of<PropertyBloc>(context);
    return Scaffold(
      appBar: ActivityAppbar(
        gradientBg: true,
        onOpenFloor: () {
          CustomDropdownSheet(
              label: "Pilih Tingkat",
              items: _propertyBloc.listFloor,
              getTitle: (data) => data.floorNo ?? "",
              groupValue: propertyWatch.selectedFloor,
              onChange: (val) {
                if (val == null) return;
                _propertyBloc.add(ChangePropertyFloor(floorData: val));
                setState(() {});
              }).show(context);
        },
        floor: propertyWatch.selectedFloor.floorNo ?? "-",
        title: _propertyBloc.selectedArea.desc ?? "-",
        subtitle: " Blok : ${_propertyBloc.selectedBlock.blockNo}",
        centerTitle: false,
        foregroundColor: AppColors.primary.color,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.only(top: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Senarai unit bancian",
                    style: appTextStyle(fontWeight: FontWeight.bold, size: 25),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            BlocConsumer<PropertyBloc, PropertyState>(
              listener: (state, context) {},
              builder: (context, state) {
                if (state is UnitLoading || state is PropertyLoading) {
                  return const Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      )
                    ],
                  ));
                } else if (state is PropertySuccess || state is UnitSuccess) {
                  return Expanded(
                    child: Scrollbar(
                        child: ListView.builder(
                            itemCount: propertyWatch.listProperty.length,
                            itemBuilder: (_, index) {
                              return _newInfoTile(
                                  data: propertyWatch.listProperty[index]);
                            })),
                  );
                } else {
                  return const Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Center(child: Text("Something went wrong"))],
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }

  // _infoContainer({required String val, required String title}) {
  //   return Container(
  //     width: MediaQuery.sizeOf(context).width * .44,
  //     margin: const EdgeInsets.all(10),
  //     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
  //     decoration: BoxDecoration(
  //         color: Colors.white, borderRadius: BorderRadius.circular(10)),
  //     child: Column(
  //       children: [
  //         Text(
  //           val,
  //           style: appTextStyle(size: 22, fontWeight: FontWeight.bold),
  //         ),
  //         Text(title),
  //       ],
  //     ),
  //   );
  // }

  Widget _newInfoTile({required PropertyData data}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: (data.status ?? "").contains("BELUM")
                  ? Colors.amber
                  : Colors.green),
          child: Text(
            data.status ?? "-",
            style: appTextStyle(
                size: 10, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        ListTile(
          onTap: () {
            _qrBloc.setPropertyData(selectedProperty: data);
            QrNavigationPref.setFromHome(val: false)
                .then((val) => _goTo(QrScanScreen(
                      isFromHome: false,
                      isFirstBancian: (data.totalVisit ?? 0) == 0,
                      unitNumber: data.unitNo,
                      unitCode: data.unitCode,
                    )));
          },
          // onTap: () => const BancianInfosModal().show(context),
          minLeadingWidth: 0,
          leading: Container(
            decoration: BoxDecoration(
              color: AppColors.midGrey.color,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 4),
            child: FaIcon(FontAwesomeIcons.mapPin, color: Color(0xFF8D182D)),
          ),
          contentPadding: EdgeInsets.zero,
          isThreeLine: true,
          dense: true,
          title: const Text(
            "NOMBOR UNIT",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.unitNo ?? "-"),
              SizedBox(height: 4),
              Text("Lawatan ${data.totalVisit}"),
            ],
          ),
        ),
        SizedBox(height: 4),
        Divider(height: 0, indent: 40),
        SizedBox(height: 8),
      ],
    );
  }

  Future _goTo(Widget screen) => Navigator.push(context,
      PageTransition(child: screen, type: PageTransitionType.rightToLeft));
}
