import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/custom_dropdown_sheet.dart';
import '../../../components/tingkat_chip.dart';
import '../../../data/api/repositories/bloc/property_bloc/property_bloc.dart';
import '../../../data/api/repositories/model/property_model.dart';
import '../../qr-home/bloc/qr_bloc.dart';

class BancianPprSearch extends StatefulWidget {
  final void Function(PropertyData data) onSelect;
  const BancianPprSearch({super.key, required this.onSelect});

  @override
  State<BancianPprSearch> createState() => _BancianPprSearchState();
}

class _BancianPprSearchState extends State<BancianPprSearch> {
  late TextEditingController zoneCtrl, areaCtrl, blockCtrl;
  late PropertyBloc _propertyBloc;
  late QrBloc _qrBloc;
  bool _hideLevel = true;
  @override
  void initState() {
    super.initState();
    _propertyBloc = BlocProvider.of<PropertyBloc>(context, listen: false);
    _propertyBloc.add(FetchAllArea());
    _qrBloc = BlocProvider.of<QrBloc>(context, listen: false);
    zoneCtrl = TextEditingController();
    areaCtrl = TextEditingController();
    blockCtrl = TextEditingController();
  }

  void hideLevel(bool val) {
    _hideLevel = val;
  }

  @override
  Widget build(BuildContext context) {
    final propertyWatch = context.watch<PropertyBloc>();
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: BgImage(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(145),
                // preferredSize: const Size.fromHeight(180),
                child: Container(
                  decoration:
                      const BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                        blurRadius: 4),
                  ]),
                  padding: const EdgeInsets.only(right: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 14),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                // textField(
                                //   controller: zoneCtrl,
                                //   hintText: "Pilih Zon",
                                //   onTap: () {
                                //     CustomDropdownSheet(
                                //         label: "Pilih Zon",
                                //         items: propertyWatch.listZone,
                                //         groupValue: propertyWatch.selectedZone,
                                //         getTitle: (data) => data.desc ?? "-",
                                //         onQuery: (data, query) {
                                //           final result = data.where((zon) {
                                //             String value =
                                //                 (zon.desc ?? "").toLowerCase();
                                //             return value.contains(
                                //                 query?.toLowerCase() ?? "");
                                //           }).toList();
                                //           return result;
                                //         },
                                //         onChange: (val) {
                                //           if (val == null) return;
                                //           setState(() {
                                //             zoneCtrl.text = val.desc!;
                                //             areaCtrl.clear();
                                //             blockCtrl.clear();
                                //           });
                                //           _propertyBloc
                                //               .add(FetchArea(zoneData: val));
                                //           hideLevel(true);
                                //         }).show(context);
                                //   },
                                // ),
                                const SizedBox(height: 8),
                                textField(
                                  controller: areaCtrl,
                                  hintText: "Pilih Perumahan",
                                  onTap: () {
                                    CustomDropdownSheet(
                                      label: "Pilih Perumahan",
                                      items: propertyWatch.listArea,
                                      groupValue: propertyWatch.selectedArea,
                                      getTitle: (data) => data.desc ?? "-",
                                      onChange: (val) {
                                        if (val == null) return;
                                        setState(() {
                                          areaCtrl.text = val.desc!;
                                          blockCtrl.clear();
                                        });
                                        _propertyBloc
                                            .add(FetchBlock(areaData: val));
                                        hideLevel(true);
                                      },
                                      onQuery: (data, query) {
                                        final result = data.where((area) {
                                          String value =
                                              (area.desc ?? "").toLowerCase();
                                          return value.contains(
                                              query?.toLowerCase() ?? "");
                                        }).toList();
                                        return result;
                                      },
                                    ).show(context);
                                  },
                                ),
                                const SizedBox(height: 8),
                                textField(
                                  controller: blockCtrl,
                                  hintText: "Pilih Blok",
                                  onTap: () {
                                    CustomDropdownSheet(
                                      label: "Pilih Blok",
                                      items: propertyWatch.listBlock,
                                      getTitle: (data) => data.blockNo ?? "-",
                                      groupValue: propertyWatch.selectedBlock,
                                      onChange: (val) {
                                        if (val == null) return;
                                        _propertyBloc.add(
                                            FetchFloorAndUnit(blockData: val));
                                        hideLevel(true);
                                        setState(() =>
                                            blockCtrl.text = val.blockNo!);
                                      },
                                      onQuery: (data, query) {
                                        final result = data.where((blok) {
                                          String value = (blok.blockNo ?? "")
                                              .toLowerCase();
                                          return value.contains(
                                              query?.toLowerCase() ?? "");
                                        }).toList();
                                        return result;
                                      },
                                    ).show(context);
                                  },
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 10),
                                //   child: SizedBox(
                                //     height: 50,
                                //     width: double.infinity,
                                //     child: ElevatedButton(
                                //         onPressed: () {},
                                //         style: ElevatedButton.styleFrom(
                                //             shape: RoundedRectangleBorder(
                                //                 borderRadius:
                                //                     BorderRadius.circular(50))),
                                //         child: const Text("Carian")),
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  title:
                                      "${_propertyBloc.listFloor[index].floorNo}",
                                  onPressed: () {
                                    _propertyBloc.add(ChangePropertyFloor(
                                        floorData:
                                            _propertyBloc.listFloor[index]));
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
                                  title:
                                      "${_propertyBloc.listFloor[index].floorNo}",
                                  onPressed: () {
                                    _propertyBloc.add(ChangePropertyFloor(
                                        floorData:
                                            _propertyBloc.listFloor[index]));
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
                BlocBuilder<PropertyBloc, PropertyState>(
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
                    } else if (state is PropertySuccess ||
                        state is UnitSuccess) {
                      // return Expanded(
                      //     child: ListView(children: [
                      //   const SizedBox(height: 10),
                      //   ...List.generate(
                      //     10,
                      //     (index) => _newInfoTile(lawatan: 1, index: index),
                      //   ),
                      // ]));
                      return Expanded(
                        child: Scrollbar(
                            child: ListView.builder(
                                itemCount: propertyWatch.listProperty.length,
                                itemBuilder: (_, index) {
                                  return _newInfoTile(
                                      data: propertyWatch.listProperty[index]);
                                })),
                      );
                    } else if (state is PropertyInitial) {
                      return const Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: Text("Sila Pilih Perumahan dan Blok"))
                        ],
                      ));
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
        ),
      ),
    );
  }

  SizedBox textField(
      {required String hintText,
      TextEditingController? controller,
      void Function()? onTap}) {
    return SizedBox(
        height: 45,
        child: TextFormField(
          readOnly: true,
          controller: controller,
          onTap: onTap,
          decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: const Icon(Icons.arrow_drop_down)),
        ));
  }

  Padding _newInfoTile({required PropertyData data}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () {
          widget.onSelect(data);
          _qrBloc.setPropertyData(selectedProperty: data);
          Navigator.pop(context);
        },
        minLeadingWidth: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Container(
          decoration: BoxDecoration(
            color: AppColors.midGrey.color,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 4),
          child: const Icon(Icons.location_on),
        ),
        tileColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
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
      ),
    );
  }
  // _newInfoTile({required int lawatan, required int index}) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: ListTile(
  //       onTap: () {
  //         widget.onSelect("Test Data");
  //         Navigator.pop(context);
  //       },
  //       minLeadingWidth: 0,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //       tileColor: Colors.white,
  //       leading: Container(
  //         decoration: BoxDecoration(
  //           color: AppColors.midGrey.color,
  //           shape: BoxShape.circle,
  //         ),
  //         padding: const EdgeInsets.all(10),
  //         margin: const EdgeInsets.only(top: 4),
  //         child: const Icon(Icons.location_on),
  //       ),
  //       contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
  //       isThreeLine: true,
  //       dense: true,
  //       title: const Text("NOMBOR UNIT"),
  //       subtitle: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text("01-01-${index.toString().padLeft(2, '0')}"),
  //           Text("PPR Desa Tun Razak • Lawatan $lawatan"),
  //         ],
  //       ),
  //       trailing: const Padding(
  //         padding: EdgeInsets.only(top: 13),
  //         child: Icon(Icons.chevron_right),
  //       ),
  //     ),
  //   );
  // }
}
