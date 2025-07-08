import 'package:eperumahan_bancian/components/activity_appbar.dart';
import 'package:eperumahan_bancian/components/tingkat_chip.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/data/api/repositories/bloc/property_bloc/property_bloc.dart';
import 'package:eperumahan_bancian/data/api/repositories/model/property_model.dart';
import 'package:eperumahan_bancian/data/hive-manager/repository/qr_navigation_pref.dart';
import 'package:eperumahan_bancian/screens/qr-home/bloc/qr_bloc.dart';
import 'package:eperumahan_bancian/screens/qr-home/qrscan_screen.dart';
import 'package:eperumahan_bancian/services/extensions/skeletonizer_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  bool _hideLevel = true;
  void hideLevel(bool val) {
    _hideLevel = val;
  }

  @override
  void initState() {
    super.initState();
    _propertyBloc = BlocProvider.of<PropertyBloc>(context, listen: false);
    _qrBloc = BlocProvider.of<QrBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final propertyWatch = BlocProvider.of<PropertyBloc>(context);
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: ActivityAppbar(
        automaticallyImplyLeading: false,
        onOpenFloor: () {},
        floor: propertyWatch.selectedFloor.floorNo ?? "-",
        title: _propertyBloc.selectedArea.desc ?? "-",
        subtitle: " Blok : ${_propertyBloc.selectedBlock.blockNo}",
        centerTitle: false,
        foregroundColor: AppColors.primary.color,
      ),
      body: ListView(
        children: [
          BlocBuilder<PropertyBloc, PropertyState>(
            builder: (context, state) {
              if (state is PropertySuccess || state is UnitSuccess) {
                return Container(
                  color: Colors.white,
                  height: 65,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        _propertyBloc.listFloor.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                              left: (index == 0) ? 14 : 0, right: 8),
                          child: TingkatChip(
                            isSelected: propertyWatch.selectedFloor ==
                                _propertyBloc.listFloor[index],
                            title: "${_propertyBloc.listFloor[index].floorNo}",
                            onPressed: () {
                              _propertyBloc.add(ChangePropertyFloor(
                                  floorData: _propertyBloc.listFloor[index]));
                              hideLevel(false);
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else if (!_hideLevel) {
                return Container(
                  color: Colors.white,
                  height: 65,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        _propertyBloc.listFloor.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                              left: (index == 0) ? 14 : 0, right: 8),
                          child: TingkatChip(
                            isSelected: propertyWatch.selectedFloor ==
                                _propertyBloc.listFloor[index],
                            title: "${_propertyBloc.listFloor[index].floorNo}",
                            onPressed: () {
                              _propertyBloc.add(ChangePropertyFloor(
                                  floorData: _propertyBloc.listFloor[index]));
                              hideLevel(false);
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          Container(
            height: size.height * 0.7,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<PropertyBloc, PropertyState>(
                  listener: (state, context) {},
                  builder: (context, state) {
                    if (state is UnitLoading || state is PropertyLoading) {
                      return Expanded(
                          child: ListView.builder(
                              itemCount: 4,
                              itemBuilder: (_, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.grey.shade200,
                                    ),
                                    title: Text("Loading .."),
                                    subtitle: Text('Loading ..............'),
                                  ),
                                ).withSkeleton(isLoading: true);
                              }));
                    } else if (state is PropertySuccess ||
                        state is UnitSuccess) {
                      if (propertyWatch.listProperty.isEmpty) {
                        return Expanded(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: size.height * .2),
                                Text(
                                  "Tiada Rumah dijumpai",
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        );
                      }
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
          )
        ],
      ),
    );
  }

  ListTile _newInfoTile({required PropertyData data}) {
    return ListTile(
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
          color: AppColors.primary.color.withValues(alpha: .1),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 4),
        child: Icon(Icons.house, color: AppColors.primary.color),
      ),
      contentPadding: EdgeInsets.zero,
      isThreeLine: true,
      dense: true,
      title: const Text("NOMBOR UNIT"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.unitNo ?? "-"),
          Text("Lawatan ${data.totalVisit}"),
        ],
      ),
      trailing: Chip(
        color: WidgetStatePropertyAll((data.status ?? "").contains("BELUM")
            ? Colors.amber
            : Colors.green),
        label: Text(
          data.status ?? "-",
          style: appTextStyle(
              size: 10, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        shape: const StadiumBorder(),
        side: BorderSide.none,
      ),
    );
  }

  Future _goTo(Widget screen) => Navigator.push(context,
      PageTransition(child: screen, type: PageTransitionType.rightToLeft));
}
