import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/components/custom_dropdown_sheet.dart';
import 'package:eperumahan_bancian/components/custom_textfield.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/config/constants/app_images.dart';
import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:eperumahan_bancian/data/api/repositories/bloc/property_bloc/property_bloc.dart';
import 'package:eperumahan_bancian/screens/qr-home/bloc/qr_bloc.dart';
import 'package:eperumahan_bancian/services/flushbar/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  late PropertyBloc _propertyBloc;
  late QrBloc _qrBloc;
  late TextEditingController zoneCtrl, areaCtrl, blockCtrl;
  @override
  void initState() {
    super.initState();
    _propertyBloc = BlocProvider.of<PropertyBloc>(context, listen: false);
    _qrBloc = BlocProvider.of<QrBloc>(context, listen: false);
    _propertyBloc.add(FetchZone());
    zoneCtrl = TextEditingController();
    areaCtrl = TextEditingController();
    blockCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final propertyWatch = context.watch<PropertyBloc>();
    Size size = MediaQuery.sizeOf(context);
    return BgImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.61,
                // color: Colors.amber,
                child: LayoutBuilder(builder: (context, constraint) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                            height: size.height * 0.38,
                            padding: const EdgeInsets.only(
                                top: 80, left: 12, right: 4, bottom: 10),
                            color: AppColors.primary.color,
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Carian Kawasan \nBancian",
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                ),
                                Image.asset(
                                  AppImages.apartment.path,
                                  scale: 16 / 6,
                                )
                              ],
                            )),
                      ),
                      Positioned(
                          child: Container(
                        margin: EdgeInsets.only(
                            left: constraint.maxWidth * .06,
                            right: constraint.maxWidth * .06),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 1,
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 0.5)
                            ],
                            borderRadius: BorderRadius.circular(14)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(children: [
                                CustomTextField(
                                  suffixIcon: Icons.unfold_more_rounded,
                                  readOnly: true,
                                  controller: zoneCtrl,
                                  hintText: "Zon",
                                  fillColor: Colors.white,
                                  onTap: () {
                                    CustomDropdownSheet(
                                        label: "Pilih Zon",
                                        items: propertyWatch.listZone,
                                        groupValue: propertyWatch.selectedZone,
                                        getTitle: (data) => data.desc ?? "-",
                                        onQuery: (data, query) {
                                          final result = data.where((zon) {
                                            String value =
                                                (zon.desc ?? "").toLowerCase();
                                            return value.contains(
                                                query?.toLowerCase() ?? "");
                                          }).toList();
                                          return result;
                                        },
                                        onChange: (val) {
                                          if (val == null) return;
                                          setState(() {
                                            zoneCtrl.text = val.desc!;
                                            areaCtrl.clear();
                                            blockCtrl.clear();
                                          });
                                          _propertyBloc
                                              .add(FetchArea(zoneData: val));
                                        }).show(context);
                                  },
                                ),
                                CustomTextField(
                                  suffixIcon: Icons.unfold_more_rounded,
                                  controller: areaCtrl,
                                  readOnly: true,
                                  hintText: "Kawasan",
                                  fillColor: Colors.white,
                                  onTap: () {
                                    CustomDropdownSheet(
                                      label: "Pilih Kawasan",
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
                                CustomTextField(
                                  suffixIcon: Icons.unfold_more_rounded,
                                  controller: blockCtrl,
                                  readOnly: true,
                                  hintText: "Blok",
                                  fillColor: Colors.white,
                                  onTap: () {
                                    CustomDropdownSheet(
                                      label: "Pilih Blok",
                                      items: propertyWatch.listBlock,
                                      getTitle: (data) => data.blockNo ?? "-",
                                      groupValue: propertyWatch.selectedBlock,
                                      onChange: (val) {
                                        if (val == null) return;
                                        _propertyBloc.add(
                                            FetchUnitFloor(blockData: val));
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
                              ]),
                            ),
                            const SizedBox(height: 10),
                            BlocListener<PropertyBloc, PropertyState>(
                              listener: (context, state) {
                                if (state is PropertyLoading) {
                                  EasyLoading.show();
                                } else if (state is PropertySuccess) {
                                  EasyLoading.dismiss()
                                      .then((val) => _goToList());
                                } else if (state is PropertyError) {
                                  CustomFlushbar.of(context)
                                      .showWarning(msg: state.msg);
                                  EasyLoading.dismiss();
                                }
                              },
                              child: SizedBox(
                                width: double.maxFinite,
                                height: 52,
                                child: ElevatedButton(
                                    onPressed: () {
                                      _propertyBloc
                                          .add(const FetchListProperties());
                                      _qrBloc.setPropertyData(
                                          selectedZone:
                                              _propertyBloc.selectedZone,
                                          selectedArea:
                                              _propertyBloc.selectedArea,
                                          selectedBlock:
                                              _propertyBloc.selectedBlock);
                                    },
                                    child: const Text("Carian")),
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  );
                }),
              ),
              const SizedBox(height: 14),
              _recentTile(),
            ],
          ),
        ),
      ),
    );
  }

  _goToList() {
    Navigator.pushNamed(context, RoutesName.activitySearch);
  }

  _recentTile() {
    return ListTile(
        // onTap: _goToList,
        minLeadingWidth: 0,
        leading: Container(
          decoration: BoxDecoration(
            color: AppColors.midGrey.color,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 4),
          child: const Icon(Icons.schedule),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14),
        title: Text(
          "PPR Sri Selangor",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.primary.color),
        ),
        subtitle: const Text("Zon 1 • Blok 20"),
        trailing: const Icon(Icons.chevron_right));
  }
}
