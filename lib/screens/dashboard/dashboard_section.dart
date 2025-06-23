import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/data/api/repositories/qr_repository.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_proof_camera.dart';
import 'package:eperumahan_bancian/screens/dashboard/dashboard_data_view.dart';
import 'package:eperumahan_bancian/screens/dashboard/model/dashboard_json_model.dart';
import 'package:eperumahan_bancian/services/flushbar/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../data/hive-manager/repository/qr_navigation_pref.dart';
import '../bancian-forms/anak_tanggungan/bloc/anak_tanggungan_bloc.dart';
import '../bancian-forms/bloc/bancian_bloc.dart';
import '../bancian-forms/pasangan/bloc/pasangan_bloc.dart';
import '../bancian-forms/penghuni/bloc/penghuni_bloc.dart';
import '../bancian-forms/subrent/provider/subrent_provider.dart';

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
  String currValue = "Bancian Biasa";
  late BancianBloc _bancianBloc;
  late PenghuniBloc _penghuniBloc;
  late PasanganBloc _pasanganBloc;
  late AnakTanggunganBloc _anakTanggunganBloc;
  late SubrentProvider subrentProvider;

  @override
  void initState() {
    super.initState();

    _bancianBloc = BlocProvider.of<BancianBloc>(context, listen: false);
    _penghuniBloc = BlocProvider.of<PenghuniBloc>(context, listen: false);
    _pasanganBloc = BlocProvider.of<PasanganBloc>(context, listen: false);
    _anakTanggunganBloc =
        BlocProvider.of<AnakTanggunganBloc>(context, listen: false);
    subrentProvider = Provider.of<SubrentProvider>(context, listen: false);
  }

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

      return cardWidget(children: [
        ...List.generate(listLen, (index) {
          String? listTitle = widget.data[index].housingProject?.desc;
          String? listSubtitle = (widget.data[index].visit?.isEmpty ?? true)
              ? "Bancian Pertama"
              : widget.data[index].visit?.first.remark;
          String? listUnitNo = widget.data[index].unit?.unitNo;

          // log("this is unit no test ===> $listUnitNo");

          return _dataTile(context,
              data: widget.data[index],
              title: listTitle,
              subtitle: listSubtitle,
              unitNo: listUnitNo);
        }),
        Visibility(
            visible: widget.data.length > 3,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    builder: (_) {
                      return DraggableScrollableSheet(
                        expand: false,
                        maxChildSize: .9,
                        initialChildSize: .5,
                        minChildSize: .3,
                        builder: (_, sc) {
                          return ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: Scaffold(
                              appBar: AppBar(
                                centerTitle: true,
                                title: Text(widget.title),
                                backgroundColor: Colors.white,
                                bottom: const PreferredSize(
                                  preferredSize: Size.fromHeight(1.0),
                                  child: Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                              body: Scrollbar(
                                thickness: 10,
                                controller: sc,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  controller: sc,
                                  itemCount: widget.data.length,
                                  itemBuilder: (context, index) {
                                    String? listTitle =
                                        widget.data[index].housingProject?.desc;
                                    String? listSubtitle =
                                        (widget.data[index].visit?.isEmpty ??
                                                true)
                                            ? "Bancian Pertama"
                                            : widget.data[index].visit?.first
                                                .remark;
                                    String? listUnitNo =
                                        widget.data[index].unit?.unitNo;

                                    return _dataTile(
                                      context,
                                      data: widget.data[index],
                                      title: listTitle,
                                      subtitle: listSubtitle,
                                      unitNo: listUnitNo,
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    });
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Lihat Semua",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 22, 99, 138)),
                    ),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.blueGrey.shade100,
                      ),
                      margin: const EdgeInsets.only(left: 12),
                      padding: const EdgeInsets.only(
                          left: 6, right: 6, top: 2, bottom: 2),
                      child: Text(
                        widget.data.length.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
            ))
      ]);
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

  Card cardWidget({required List<Widget> children}) {
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
            data: data,
            onPressed: widget.showButton
                ? () async {
                    QrNavigationPref.setFromHome(val: true);
                    String? censusCode = data.censusCode;
                    if (censusCode == null) {
                      CustomFlushbar.of(context).showWarning(
                          msg:
                              "Bancian Dibenarkan Untuk Bancian ke-2 dan ke atas akibat ralat sistem.");
                      return;
                    }
                    EasyLoading.show();
                    try {
                      final residentData = await QrRepository().scanQrCode(
                          code: data.unit?.code ?? "",
                          type: Searchtype.unitCode);

                      _bancianBloc.add(SetBancianData(
                          data: residentData, censusCode: censusCode));
                      _penghuniBloc.add(SetPenghuniData(
                          data: residentData, censusCode: censusCode));
                      _pasanganBloc.add(SetPasanganData(
                          data: residentData, censusCode: censusCode));
                      _anakTanggunganBloc.add(SetAnakTanggungData(
                          data: residentData, censusCode: censusCode));
                      Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          PageTransition(
                              child: const BancianProofCamera(),
                              type: PageTransitionType.rightToLeft));
                      subrentProvider.clearListSUbrent();
                    } catch (e) {
                      // ignore: use_build_context_synchronously
                      CustomFlushbar.of(context).showWarning(msg: e.toString());
                    } finally {
                      EasyLoading.dismiss();
                    }
                  }
                : null);
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
