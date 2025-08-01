import 'package:eperumahan_bancian/screens/bancian-forms/capture_card/capture_card_screen.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/pasangan/bloc/pasangan_bloc.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/pasangan/pasangan_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

import '../../../components/bottombar_button.dart';
import '../../../components/custom_appbar.dart';
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
      appBar: const CustomAppBar(title: "Maklumat Pasangan"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: CaptureCardScreen(onNext: (frontImg, backImg) {
                            context.read<PasanganBloc>().addNewPasangan(
                                frontImg: frontImg, backImg: backImg);
                            Navigator.pop(context);
                            const PasanganModal(isNewForm: true).show(context);
                          }),
                          type: PageTransitionType.bottomToTop));
                },
                child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black26),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black54)),
                          child: const Icon(
                            Icons.add,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(width: 8),
                        const Text(
                          "Tambah pasangan",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    )),
              ),
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
      bottomNavigationBar: BottomBarButton(
          onTap: () => Navigator.pop(context), title: "Simpan Maklumat"),
    );
  }

  Widget _pasanganTile({required SpouseInputModel data, required int index}) {
    return GestureDetector(
      onTap: () {
        _pasanganBloc.selectPasangan(data, index);
        const PasanganModal(
          isNewForm: false,
        ).show(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black26),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      FaIcon(FontAwesomeIcons.user, size: 20),
                      const SizedBox(width: 8),
                      Text("Pasangan ${index + 1}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(data.name ?? ""),
                  SizedBox(height: 4),
                  Text(data.icNo ?? ""),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
