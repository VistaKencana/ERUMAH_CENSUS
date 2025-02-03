import 'package:eperumahan_bancian/components/custom_textfield.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/qr/bancian_ppr_search.dart';
import 'package:eperumahan_bancian/screens/qr-home/bloc/qr_bloc.dart';
import 'package:eperumahan_bancian/services/flushbar/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:page_transition/page_transition.dart';

class BancianRegisterQr extends StatefulWidget {
  const BancianRegisterQr({super.key});

  Future<T?> show<T>(BuildContext context) => showModalBottomSheet<T>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(14))),
      isScrollControlled: true,
      builder: (context) => this);

  @override
  State<BancianRegisterQr> createState() => _BancianRegisterQrState();
}

class _BancianRegisterQrState extends State<BancianRegisterQr> {
  late QrBloc _qrBloc;
  final unitCtrl = TextEditingController();
  @override
  void initState() {
    super.initState();
    _qrBloc = BlocProvider.of<QrBloc>(context, listen: false);
    unitCtrl.text = _qrBloc.selectedProperty.unitNo ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Padding(
        padding: EdgeInsets.only(
            left: constraint.maxWidth * .05,
            right: constraint.maxWidth * .05,
            top: constraint.maxHeight * .03,
            bottom: constraint.maxHeight * .03),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Daftar QR",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    backgroundColor: AppColors.midGrey.color,
                    child: const Icon(Icons.close),
                  ),
                )
              ],
            ),
            _gap(),
            const Icon(
              Icons.qr_code_2,
              size: 100,
            ),
            Text(_qrBloc.qrCode),
            _gap(height: 16),
            CustomTextField(
              title: "Unit Rumah",
              hintText: "Sila Pilih Unit Rumah",
              controller: unitCtrl,
              suffixIcon: Icons.arrow_drop_down,
              fillColor: Colors.white,
              onTap: () {
                if (!_qrBloc.isFromHome) {
                  CustomFlushbar.of(context)
                      .showWarning(msg: "Unit rumah sudah dipilih");
                  return;
                }

                Navigator.push(
                    context,
                    PageTransition(
                      child: BancianPprSearch(
                        onSelect: (data) {
                          setState(() {
                            unitCtrl.text = data.unitNo ?? "";
                          });
                        },
                      ),
                      type: PageTransitionType.topToBottom,
                    ));
              },
              readOnly: true,
            ),
            _gap(height: 40),
            BlocListener<QrBloc, QrState>(
              listener: (context, state) {
                if (state is QrRegLoading) {
                  EasyLoading.show();
                } else if (state is QrRegSuccess) {
                  // ignore: use_build_context_synchronously
                  EasyLoading.dismiss()
                      // ignore: use_build_context_synchronously
                      .then((val) => Navigator.pop(context))
                      .then((val) {
                    // ignore: use_build_context_synchronously
                    CustomFlushbar.of(context).showSuccess(
                        msg:
                            "QR berjaya didaftar, sila imbas qr semula untuk memulakan bancian",
                        duration: const Duration(seconds: 3));
                  });
                } else if (state is QrRegError) {
                  EasyLoading.dismiss();
                  CustomFlushbar.of(context).showFailed(
                      msg: state.msg, duration: const Duration(seconds: 3));
                }
              },
              child: SizedBox(
                height: 50,
                width: double.maxFinite,
                child: ElevatedButton(
                    onPressed: () {
                      _qrBloc.add(const RegisterQrcode());
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    child: const Text("Daftar QR")),
              ),
            )
          ],
        ),
      );
    });
  }

  _gap({double height = 10}) => SizedBox(height: height);
}
