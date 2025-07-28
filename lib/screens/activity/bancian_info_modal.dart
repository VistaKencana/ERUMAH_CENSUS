import 'package:eperumahan_bancian/components/bottombar_button.dart';
import 'package:eperumahan_bancian/screens/activity/bancian_info_tile.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/anak_tanggungan/bloc/anak_tanggungan_bloc.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_proof_camera.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bloc/bancian_bloc.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/pasangan/bloc/pasangan_bloc.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/penghuni/bloc/penghuni_bloc.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/subrent/provider/subrent_provider.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/unit_kedai/bloc/unit_kedai_bloc.dart';
import 'package:eperumahan_bancian/screens/qr-home/bloc/qr_bloc.dart';
import 'package:eperumahan_bancian/screens/qr-home/models/resident_info_model.dart';
import 'package:eperumahan_bancian/services/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class BancianInfosModal extends StatefulWidget {
  const BancianInfosModal({super.key});

  static Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      isScrollControlled: true,
      builder: (_) => const BancianInfosModal(),
    );
  }

  @override
  State<BancianInfosModal> createState() => _BancianInfosModalState();
}

class _BancianInfosModalState extends State<BancianInfosModal> {
  late QrBloc _qrBloc;
  String currValue = "Bancian Biasa";
  late BancianBloc _bancianBloc;
  late PenghuniBloc _penghuniBloc;
  late PasanganBloc _pasanganBloc;
  late AnakTanggunganBloc _anakTanggunganBloc;
  late SubrentProvider subrentProvider;
  late UnitKedaiBloc _unitKedaiBloc;
  List<String> statusFilter = [
    "Bancian Biasa",
    "Tiada Penghuni",
  ];
  late ResidentInfoData residentData;
  @override
  void initState() {
    super.initState();
    _qrBloc = BlocProvider.of<QrBloc>(context, listen: false);
    _bancianBloc = BlocProvider.of<BancianBloc>(context, listen: false);
    _penghuniBloc = BlocProvider.of<PenghuniBloc>(context, listen: false);
    _pasanganBloc = BlocProvider.of<PasanganBloc>(context, listen: false);
    _anakTanggunganBloc =
        BlocProvider.of<AnakTanggunganBloc>(context, listen: false);
    subrentProvider = Provider.of<SubrentProvider>(context, listen: false);
    residentData = _qrBloc.residentData;
    _unitKedaiBloc = BlocProvider.of<UnitKedaiBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.7,
      builder: (context, sc) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        child: Scaffold(
          body: SingleChildScrollView(
            controller: sc,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 28, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Info Unit Bancian',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      GestureDetector(
                          onTap: () {
                            showReportDialog();
                          },
                          child: const Icon(Icons.error_outline_outlined))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 5),
                  child: Text(
                    'UNIT: ${residentData.unit?.no ?? ""}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey[600]),
                  ),
                ),
                LayoutBuilder(builder: (context, constraint) {
                  // final cWidth = constraint.maxWidth;
                  return Stack(
                    children: [
                      // Positioned(
                      //   left: cWidth * 0.04,
                      //   top: 23,
                      //   bottom: 23,
                      //   child: VerticalDivider(
                      //     width: 10,
                      //     color: AppColors.darkGrey.color,
                      //   ),
                      // ),
                      _visitsData()
                    ],
                  );
                })
              ],
            ),
          ),
          bottomNavigationBar: Visibility(
            // visible: (residentData.visits?.length ?? 0) < 2,
            child: BottomBarButton(
                onTap: () {
                  _bancianBloc.add(SetBancianData(
                      data: _qrBloc.residentData,
                      censusCode: _qrBloc.residentData.censusCode ?? ""));
                  _penghuniBloc.add(SetPenghuniData(
                      data: _qrBloc.residentData,
                      censusCode: _qrBloc.residentData.censusCode ?? ""));
                  _pasanganBloc.add(SetPasanganData(
                      data: _qrBloc.residentData,
                      censusCode: _qrBloc.residentData.censusCode ?? ""));
                  _anakTanggunganBloc.add(SetAnakTanggungData(
                      data: _qrBloc.residentData,
                      censusCode: _qrBloc.residentData.censusCode ?? ""));
                  _unitKedaiBloc.add(SetPemilikData(
                      data: _qrBloc.residentData,
                      censusCode: _qrBloc.residentData.censusCode ?? ""));
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const BancianProofCamera(),
                          type: PageTransitionType.rightToLeft));
                  subrentProvider.clearListSUbrent();
                },
                title: "Teruskan Bancian"),
          ),
        ),
      ),
    );
  }

  Widget _visitsData() {
    int visitsLen = residentData.visits?.length ?? 0;
    final data = residentData.visits!;

    if (visitsLen <= 0) {
      return Column(
        children: [
          BancianInfoTile(
              status: "BELUM MULA",
              lawatan: "1",
              isComplete: false,
              date: FormatDate.formatTo(
                  date: DateTime.now().toString(), format: "d MMMM y"),
              remarks: "-"),
        ],
      );
    }

    return Column(children: [
      ...List.generate(
        visitsLen,
        (index) => BancianInfoTile(
            status: data[index].status ?? "-",
            lawatan: data[index].round ?? "0",
            isComplete:
                (data[index].status ?? "").toLowerCase().contains("selesai"),
            date: FormatDate.formatTo(
                date: DateTime.now().toString(), format: "d MMMM y"),
            remarks: data[index].remark ?? ""),
      ),
      Visibility(
        visible: (residentData.visits?.length ?? 0) < 1,
        child: BancianInfoTile(
            status: "BELUM MULA",
            lawatan: (visitsLen + 1).toString(),
            isComplete: false,
            date: FormatDate.formatTo(
                date: DateTime.now().toString(), format: "d MMMM y"),
            remarks: "-"),
      )
    ]);
  }

  void showReportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text(
            'Adakah Pemilik Tidak Berada di Rumah?',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Jika ya, kami akan menghantar pautan untuk tindakan lanjut.',
            textAlign: TextAlign.center,
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(
                      context); // Action for "Yes, I don’t want to learn"
                },
                child: const Text('Ya, Hantar Pautan'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context); // Action for "Cancel"
                },
                child: const Text('Batal'),
              ),
            ),
          ],
        );
      },
    );
  }
}
