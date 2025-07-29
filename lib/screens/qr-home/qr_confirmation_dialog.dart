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
      this.position = QrConfirmationPosition.leftRignt,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(widget.title),
        content: widget.position == QrConfirmationPosition.topDown
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [_subtitle(), gapHeight(), ..._listButton()],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.lokasiPpr,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          decoration: BoxDecoration(),
          child: Text(
            widget.unitNumber,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.only(bottom: 10),
        //   child: Text(widget.subtitle),
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
        _button(
            color: Colors.grey.shade500,
            onPressed: widget.onDimmedBtn,
            title: widget.dimmedBtnLabel ?? "-"),
    ];
  }

  Widget _button(
      {required String title,
      required void Function()? onPressed,
      Color? color}) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        height: 45,
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: color),
            onPressed: onPressed,
            child: Text(title)),
      ),
    ));
  }
}
