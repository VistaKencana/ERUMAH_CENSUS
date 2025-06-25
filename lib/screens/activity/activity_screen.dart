import 'package:eperumahan_bancian/components/custom_dropdown_sheet.dart';
import 'package:eperumahan_bancian/components/custom_textfield.dart';
import 'package:eperumahan_bancian/components/modal/custom_draggable_sheet.dart';
import 'package:eperumahan_bancian/components/modal/modal_handler.dart';
import 'package:eperumahan_bancian/components/search_appbar.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
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
  late TextEditingController searchCtrl, areaCtrl, blockCtrl;
  @override
  void initState() {
    super.initState();
    _propertyBloc = BlocProvider.of<PropertyBloc>(context, listen: false);
    _qrBloc = BlocProvider.of<QrBloc>(context, listen: false);
    _propertyBloc.add(FetchAllArea());
    searchCtrl = TextEditingController();
    areaCtrl = TextEditingController();
    blockCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final propertyWatch = context.watch<PropertyBloc>();
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: SearchAppbar(
        searchController: searchCtrl,
        onTap: () {
          CustomDraggableSheet.show(
              context: context,
              builder: (_, __) => searchSection(size, propertyWatch));
        },
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              "Carian terbaru",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _recentTile(),
            //  searchSection(size, propertyWatch),
            const SizedBox(height: 14),
            // _recentTile(),
          ],
        ),
      ),
    );
  }

  Widget searchSection(Size size, PropertyBloc propertyWatch) {
    return Scaffold(
      appBar: const ModalHandler(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Center(
              child: Text(
                "All Filter",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 22),
              ),
            ),
            section(
              text: "Perumahan",
              controller: areaCtrl,
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
                  onQuery: (data, query) {
                    final result = data.where((area) {
                      String value = (area.desc ?? "").toLowerCase();
                      return value.contains(query?.toLowerCase() ?? "");
                    }).toList();
                    return result;
                  },
                ).show(context);
              },
            ),
            section(
              text: "Blok",
              controller: blockCtrl,
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
                  onQuery: (data, query) {
                    final result = data.where((blok) {
                      String value = (blok.blockNo ?? "").toLowerCase();
                      return value.contains(query?.toLowerCase() ?? "");
                    }).toList();
                    return result;
                  },
                ).show(context);
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.blueGrey.shade100))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                onPressed: () {},
                child: Text(
                  "Set semula",
                  style: TextStyle(
                      color: Colors.blueGrey.shade400,
                      fontWeight: FontWeight.bold),
                )),
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
                child: ElevatedButton(
                    onPressed: () {
                      _propertyBloc.add(const FetchListProperties());
                      _qrBloc.setPropertyData(
                          selectedZone: _propertyBloc.selectedZone,
                          selectedArea: _propertyBloc.selectedArea,
                          selectedBlock: _propertyBloc.selectedBlock);
                    },
                    child: const Text(
                      "Carian",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))),
          ],
        ),
      ),
    );
  }

  Widget section(
      {required String text,
      TextEditingController? controller,
      void Function()? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Text(
          text,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        CustomTextField(
            suffixIcon: Icons.arrow_drop_down,
            controller: controller,
            readOnly: true,
            hintText: text,
            fillColor: Colors.white,
            onTap: onTap),
        const SizedBox(height: 30),
        const Divider(height: 0)
      ],
    );
  }

  void _goToList() {
    Navigator.pushNamed(context, RoutesName.activitySearch);
  }

  Widget _recentTile() {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      onTap: () {},
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.color.withValues(alpha: .1)),
        child: Icon(
          Icons.history,
          color: AppColors.primary.color,
        ),
      ),
      title: Text("Perumahan"),
      subtitle: Text("Kawasan"),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.black26,
      ),
    );
  }
}
