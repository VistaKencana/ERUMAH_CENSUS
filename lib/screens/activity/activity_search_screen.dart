// import 'package:eperumahan_bancian/components/activity_appbar.dart';
// import 'package:eperumahan_bancian/components/bg_image.dart';
// import 'package:eperumahan_bancian/components/custom_dropdown_sheet.dart';
import 'package:eperumahan_bancian/components/custom_persistent_header.dart';
import 'package:eperumahan_bancian/components/tingkat_chip.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/config/constants/app_images.dart';
import 'package:eperumahan_bancian/data/api/repositories/bloc/property_bloc/property_bloc.dart';
import 'package:eperumahan_bancian/data/api/repositories/model/property_model.dart';
// import 'package:eperumahan_bancian/data/hive-manager/repository/qr_navigation_pref.dart';
import 'package:eperumahan_bancian/screens/activity/bancian_info_modal.dart';
import 'package:eperumahan_bancian/screens/qr-home/bloc/qr_bloc.dart';
// import 'package:eperumahan_bancian/screens/qr-home/qrscan_screen.dart';
import 'package:eperumahan_bancian/services/flushbar/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:page_transition/page_transition.dart';
import 'model/bancian_info.dart';

class ActivitySearchScreen extends StatefulWidget {
  const ActivitySearchScreen({super.key});

  @override
  State<ActivitySearchScreen> createState() => _ActivitySearchScreenState();
}

class _ActivitySearchScreenState extends State<ActivitySearchScreen> {
  final info = BancianInfo.getExampleData();
  final scrollController = ScrollController();
  late PropertyBloc _propertyBloc;
  late QrBloc _qrBloc;
  double scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _propertyBloc = BlocProvider.of<PropertyBloc>(context, listen: false);
    _qrBloc = BlocProvider.of<QrBloc>(context, listen: false);
    scrollController.addListener(() {
      setState(() {
        scrollOffset = scrollController.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final propertyWatch = BlocProvider.of<PropertyBloc>(context);
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.grey[100],
        // appBar: ActivityAppbar(
        //   onOpenFloor: () {
        //     CustomDropdownSheet(
        //         label: "Pilih Tingkat",
        //         items: _propertyBloc.listFloor,
        //         getTitle: (data) => data.floorNo ?? "",
        //         groupValue: propertyWatch.selectedFloor,
        //         onChange: (val) {
        //           if (val == null) return;
        //           _propertyBloc.add(ChangePropertyFloor(floorData: val));
        //           setState(() {});
        //         }).show(context);
        //   },
        //   floor: propertyWatch.selectedFloor.floorNo ?? "-",
        //   title: _propertyBloc.selectedArea.desc ?? "-",
        //   subtitle:
        //       "${_propertyBloc.selectedZone.desc} • Blok : ${_propertyBloc.selectedBlock.blockNo}",
        //   centerTitle: false,
        //   foregroundColor: AppColors.primary.color,
        // ),
        body: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: true,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  _propertyBloc.selectedArea.desc ?? "-",
                  style: TextStyle(
                      color: Colors.black.withOpacity(
                          (scrollOffset / 80).clamp(0, 1).toDouble())),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        )),
                  ),
                ),
                expandedHeight: 135,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Image.asset(
                        AppImages.activityHeader.path,
                        fit: BoxFit.cover,
                        height: 130,
                        width: double.infinity,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 20,
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              color: AppColors.primary.color,
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 10, bottom: 22),
                  child: Row(
                    children: [
                      Text(
                        _propertyBloc.selectedArea.desc ?? "-",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: CustomPersistentHeader(child: _tingkat()),
              ),
            ];
          },
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Senarai unit bancian",
                              style: appTextStyle(
                                  fontWeight: FontWeight.bold, size: 25),
                            ),
                          ),
                        ],
                      ),
                      BlocListener<QrBloc, QrState>(
                        listener: (context, state) {
                          if (state is UnitCodeLoading) {
                            EasyLoading.show();
                          } else if (state is UnitCodeSuccess) {
                            EasyLoading.dismiss()
                                .then((val) => BancianInfosModal.show(context));
                          } else if (state is UnitCodeError) {
                            CustomFlushbar.of(context)
                                .showFailed(msg: state.msg);
                            EasyLoading.dismiss();
                          }
                        },
                        child: const SizedBox(height: 0),
                      ),
                      BlocConsumer<PropertyBloc, PropertyState>(
                        listener: (state, context) {},
                        builder: (context, state) {
                          if (state is UnitLoading ||
                              state is PropertyLoading) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: size.height * .1),
                                const Center(
                                    child: CircularProgressIndicator()),
                                SizedBox(height: size.height * .1),
                              ],
                            );
                          } else if (state is PropertySuccess ||
                              state is UnitSuccess) {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: propertyWatch.listProperty.length,
                                itemBuilder: (c, index) {
                                  return _newInfoTile(
                                      data: propertyWatch.listProperty[index]);
                                });
                          } else {
                            return const Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: Text("Something went wrong"))
                              ],
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _newInfoTile({required PropertyData data}) {
    return ListTile(
      onTap: () {
        _qrBloc.add(
            SelectHouseUnit(unitCode: data.unitCode ?? "", isFromHome: false));
      },
      minLeadingWidth: 0,
      leading: Container(
        decoration: BoxDecoration(
          color: AppColors.midGrey.color,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 4),
        child: const Icon(Icons.location_on),
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

  _tingkat() {
    final propertyWatch = BlocProvider.of<PropertyBloc>(context);
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
              padding: EdgeInsets.only(left: (index == 0) ? 14 : 0, right: 8),
              child: TingkatChip(
                isSelected: propertyWatch.selectedFloor ==
                    _propertyBloc.listFloor[index],
                title: "${_propertyBloc.listFloor[index].floorNo}",
                onPressed: () {
                  _propertyBloc.add(ChangePropertyFloor(
                      floorData: _propertyBloc.listFloor[index]));
                  setState(() {});
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
  // _goTo(Widget screen) => Navigator.push(context,
  //     PageTransition(child: screen, type: PageTransitionType.rightToLeft));
}
