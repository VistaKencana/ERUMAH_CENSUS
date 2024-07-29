import 'package:eperumahan_bancian/components/custom_dialog_loading.dart';
import 'package:eperumahan_bancian/components/custom_textfield.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/qr/bancian_ppr_search.dart';
import 'package:flutter/material.dart';
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
            const Text("Qwer-123asd-58974"),
            _gap(height: 16),
            CustomTextField(
              title: "Unit Rumah",
              hintText: "Sila Pilih Unit Rumah",
              suffixIcon: Icons.arrow_drop_down,
              fillColor: Colors.white,
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                      child: BancianPprSearch(
                        onSelect: (data) {},
                      ),
                      type: PageTransitionType.topToBottom,
                    ));
              },
              readOnly: true,
            ),
            _gap(height: 40),
            SizedBox(
              height: 50,
              width: double.maxFinite,
              child: ElevatedButton(
                  onPressed: () {
                    final dialogController = LoadingDialogController();
                    CustomDialogLoading.show(
                      context,
                      controller: dialogController,
                      succesMsg: "QR Berjaya Didaftar",
                      isDissmissable: false,
                      onFinish: (state) {
                        Navigator.pop(context);
                        Future.delayed(const Duration(milliseconds: 180), () {
                          Navigator.pop(context);
                        });
                      },
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      dialogController.updateState(DialogState.success);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: const Text("Daftar QR")),
            )
          ],
        ),
      );
    });
  }

  _gap({double height = 10}) => SizedBox(height: height);
}
