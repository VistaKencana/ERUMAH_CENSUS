import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/capture_card/capture_card_screen.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/pasangan/bloc/pasangan_bloc.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/pasangan/pasangan_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../components/bottombar_button.dart';
import '../models/spouse_input_model.dart';

class PasanganForm extends StatefulWidget {
  const PasanganForm({super.key});

  @override
  State<PasanganForm> createState() => _PasanganFormState();
}

class _PasanganFormState extends State<PasanganForm> {
  late PasanganBloc _pasanganBloc;

  @override
  void initState() {
    super.initState();
    _pasanganBloc = BlocProvider.of<PasanganBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const CustomAppBar(title: "Maklumat Pasangan"),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Stack(
          children: [
            Column(
              children: [
                AppBar(
                  backgroundColor: AppColors.primary.color,
                  foregroundColor: Colors.white,
                  centerTitle: true,
                  leading: IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Container(
                  color: AppColors.primary.color,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: const Text(
                    "Maklumat Pasangan",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
            Positioned(
                right: 16,
                bottom: 0,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child:
                                CaptureCardScreen(onNext: (frontImg, backImg) {
                              context.read<PasanganBloc>().addNewPasangan(
                                  frontImg: frontImg, backImg: backImg);
                              Navigator.pop(context);
                              const PasanganModal(isNewForm: true)
                                  .show(context);
                            }),
                            type: PageTransitionType.bottomToTop));
                  },
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary.color,
                  child: Icon(Icons.add),
                )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              // ListTile(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         PageTransition(
              //             child: CaptureCardScreen(onNext: (frontImg, backImg) {
              //               context.read<PasanganBloc>().addNewPasangan(
              //                   frontImg: frontImg, backImg: backImg);
              //               Navigator.pop(context);
              //               const PasanganModal(isNewForm: true).show(context);
              //             }),
              //             type: PageTransitionType.bottomToTop));
              //   },
              //   contentPadding: const EdgeInsets.all(12),
              //   leading: Container(
              //     decoration: BoxDecoration(
              //         color: AppColors.primary.color,
              //         shape: BoxShape.circle,
              //         border: Border.all()),
              //     child: const Icon(
              //       Icons.add,
              //       color: Colors.white,
              //     ),
              //   ),
              //   title: const Text("Tambah pasangan"),
              // ),
              // const Divider(height: 0),
              SizedBox(height: 12),
              BlocBuilder<PasanganBloc, PasanganState>(
                builder: (context, state) {
                  if (state is PasanganLoaded) {
                    return Column(
                      children: List.generate(
                          state.spouseData.length,
                          (index) => _pasanganTile(
                              data: state.spouseData[index], index: index)),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          BottomBarButton(onTap: () => Navigator.pop(context), title: "Simpan"),
    );
  }

  Widget _pasanganTile({required SpouseInputModel data, required int index}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PASANGAN ${index + 1}",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        ListTile(
          onTap: () {
            _pasanganBloc.selectPasangan(data, index);
            const PasanganModal(
              isNewForm: false,
            ).show(context);
          },
          contentPadding: const EdgeInsets.all(2),
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(
            _isEmpty(data.name) ? "Nama : -" : data.name!,
            style: _isEmpty(data.name)
                ? TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                    fontSize: 14)
                : null,
          ),
          subtitle: Text(
            _isEmpty(data.icNo) ? "Ic : -" : data.icNo!,
            style: _isEmpty(data.icNo)
                ? TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                    fontSize: 14)
                : null,
          ),
        ),
        const Divider(
          height: 0,
          indent: 30,
          color: Colors.black12,
          endIndent: 10,
        ),
      ],
    );
  }

  bool _isEmpty(String? value) {
    return value == null || value.isEmpty;
  }
}
