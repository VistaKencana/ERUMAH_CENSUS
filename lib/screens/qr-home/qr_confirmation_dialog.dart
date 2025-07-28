import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

enum QrConfirmationPosition { leftRignt, topDown }

class QrConfirmationDialog extends StatefulWidget {
  final String title;
  final String subtitle;
  final String unitNumber;
  final String lokasiPpr;
  final String colorBtnLabel;
  final String? dimmedBtnLabel;
  final QrConfirmationPosition position;
  final void Function()? onColorBtn;
  final void Function()? onDimmedBtn;
  final bool barrierDismissible;
  const QrConfirmationDialog(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.unitNumber,
      required this.lokasiPpr,
      this.onColorBtn,
      this.onDimmedBtn,
      required this.colorBtnLabel,
      this.dimmedBtnLabel,
      this.position = QrConfirmationPosition.topDown,
      this.barrierDismissible = true});
  Future<T?> show<T>(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => this,
    );
  }

  @override
  State<QrConfirmationDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<QrConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: ModalRoute.of(context)!.animation!,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: widget.position == QrConfirmationPosition.topDown
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [_subtitle(), gapHeight(), ..._listButton()],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _subtitle(),
                  gapHeight(height: 20),
                  Row(
                    children: _listButton().reversed.toList(),
                  )
                ],
              ),
      ),
    );
  }

  Widget _subtitle() {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppColors.lightGrey.color,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            widget.unitNumber,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        // Text(
        //   widget.lokasiPpr,
        //   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 10),
        //   child: Text(
        //     widget.subtitle,
        //     textAlign: TextAlign.center,
        //   ),
        // )
      ],
    );
  }

  SizedBox gapHeight({double height = 10}) {
    return SizedBox(height: height);
  }

  List<Widget> _listButton() {
    return [
      _button(onPressed: widget.onColorBtn, title: widget.colorBtnLabel),
      if (widget.dimmedBtnLabel != null)
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: SizedBox(
            height: 45,
            width: double.infinity,
            child: OutlinedButton(
              onPressed: widget.onDimmedBtn,
              child: Text(widget.dimmedBtnLabel ?? "-"),
            ),
          ),
        )
      // _button(
      //     color: Colors.grey.shade500,
      //     onPressed: widget.onDimmedBtn,
      //     title: widget.dimmedBtnLabel ?? "-"),
    ];
  }

  Widget _button(
      {required String title,
      required void Function()? onPressed,
      Color? color}) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        height: 45,
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: color, shape: StadiumBorder()),
            onPressed: onPressed,
            child: Text(title)),
      ),
    );
  }
}
