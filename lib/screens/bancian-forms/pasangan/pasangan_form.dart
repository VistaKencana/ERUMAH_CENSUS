import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/pasangan/bloc/pasangan_bloc.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/pasangan/pasangan_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              ListTile(
                onTap: () {
                  const PasanganModal(isNewForm: true).show(context);
                },
                contentPadding: const EdgeInsets.all(12),
                leading: Container(
                  decoration: BoxDecoration(
                      color: AppColors.primary.color,
                      shape: BoxShape.circle,
                      border: Border.all()),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                title: const Text("Tambah pasangan"),
              ),
              const Divider(height: 0),
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

  _pasanganTile({required SpouseInputModel data, required int index}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListTile(
          onTap: () {
            _pasanganBloc.selectPasangan(data, index);
            const PasanganModal(
              isNewForm: false,
            ).show(context);
          },
          contentPadding: const EdgeInsets.all(12),
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text("Pasangan ${index + 1}"),
          subtitle: Text(data.name),
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
}
