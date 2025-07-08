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
  late TextEditingController areaCtrl, blockCtrl;
  @override
  void initState() {
    super.initState();
    _propertyBloc = BlocProvider.of<PropertyBloc>(context, listen: false);
    _qrBloc = BlocProvider.of<QrBloc>(context, listen: false);
    _propertyBloc.add(FetchAllArea());
    areaCtrl = TextEditingController();
    blockCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final propertyWatch = context.watch<PropertyBloc>();
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: size.height * 0.36,
                width: double.infinity,
                padding: const EdgeInsets.only(
                    top: 80, left: 12, right: 4, bottom: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xFFBA2C45), // 0%
                      Color(0xFF040001), // 100%
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 40 / 9,
                      child: Image.asset(
                        AppImages.dbklLogo.path,
                        fit: BoxFit.contain,
                        // height: constraint.maxHeight * .2,
                        // width: constraint.maxWidth * .4,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Carian Perumahan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            const SizedBox(height: 14),
            // _recentTile(),
            Container(
              margin: EdgeInsets.all(16),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.midGrey.color),
                  borderRadius: BorderRadius.circular(14)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(children: [
                      CustomTextField(
                        suffixIcon: Icons.arrow_drop_down_circle_outlined,
                        controller: areaCtrl,
                        readOnly: true,
                        hintText: "Perumahan",
                        fillColor: Colors.white,
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
                              _propertyBloc.add(FetchBlock(areaData: val));
                            },
                            // onQuery: (data, query) {
                            //   final result = data.where((area) {
                            //     String value = (area.desc ?? "").toLowerCase();
                            //     return value
                            //         .contains(query?.toLowerCase() ?? "");
                            //   }).toList();
                            //   return result;
                            // },
                          ).show(context);
                        },
                      ),
                      CustomTextField(
                        suffixIcon: Icons.arrow_drop_down_circle_outlined,
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
                              _propertyBloc.add(FetchUnitFloor(blockData: val));
                              setState(() => blockCtrl.text = val.blockNo!);
                            },
                            // onQuery: (data, query) {
                            //   final result = data.where((blok) {
                            //     String value =
                            //         (blok.blockNo ?? "").toLowerCase();
                            //     return value
                            //         .contains(query?.toLowerCase() ?? "");
                            //   }).toList();
                            //   return result;
                            // },
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
                        EasyLoading.dismiss().then((val) => _goToList());
                      } else if (state is PropertyError) {
                        CustomFlushbar.of(context).showWarning(msg: state.msg);
                        EasyLoading.dismiss();
                      }
                    },
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 52,
                      child: ElevatedButton(
                          onPressed: () {
                            _propertyBloc.add(const FetchListProperties());
                            _qrBloc.setPropertyData(
                                selectedZone: _propertyBloc.selectedZone,
                                selectedArea: _propertyBloc.selectedArea,
                                selectedBlock: _propertyBloc.selectedBlock);
                          },
                          child: const Text("Carian")),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _goToList() {
    Navigator.pushNamed(context, RoutesName.activitySearch);
  }

  // _recentTile() {
  //   return ListTile(
  //       // onTap: _goToList,
  //       minLeadingWidth: 0,
  //       leading: Container(
  //         decoration: BoxDecoration(
  //           color: AppColors.midGrey.color,
  //           shape: BoxShape.circle,
  //         ),
  //         padding: const EdgeInsets.all(10),
  //         margin: const EdgeInsets.only(top: 4),
  //         child: const Icon(Icons.schedule),
  //       ),
  //       contentPadding: const EdgeInsets.symmetric(horizontal: 14),
  //       title: Text(
  //         "PPR Sri Selangor",
  //         style: TextStyle(
  //             fontWeight: FontWeight.bold, color: AppColors.primary.color),
  //       ),
  //       subtitle: const Text("Zon 1 • Blok 20"),
  //       trailing: const Icon(Icons.chevron_right));
  // }
}
