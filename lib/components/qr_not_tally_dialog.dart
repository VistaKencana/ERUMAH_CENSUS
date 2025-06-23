import 'package:flutter/material.dart';

enum AlertBtnPosition { leftRignt, topDown }

class QrNotTallyDialog extends StatefulWidget {
  final String title;
  final String subtitle;
  final String colorBtnLabel;
  final String? dimmedBtnLabel;
  final AlertBtnPosition position;
  final void Function()? onColorBtn;
  final void Function()? onDimmedBtn;
  final bool barrierDismissible;
  const QrNotTallyDialog(
      {super.key,
      required this.title,
      this.onColorBtn,
      this.onDimmedBtn,
      required this.colorBtnLabel,
      this.dimmedBtnLabel,
      required this.subtitle,
      this.position = AlertBtnPosition.leftRignt,
      this.barrierDismissible = true});
  Future<T?> show<T>(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => this,
    );
  }

  @override
  State<QrNotTallyDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<QrNotTallyDialog> {
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: ModalRoute.of(context)!.animation!,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
      child: Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          // title: Text(widget.title),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: widget.position == AlertBtnPosition.topDown
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      gapHeight(),
                      _title(),
                      _subtitle(),
                      gapHeight(),
                      _content(),
                      ..._listButton()
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      gapHeight(),
                      _title(),
                      _subtitle(),
                      gapHeight(height: 20),
                      _content(),
                      gapHeight(height: 20),
                      Row(
                        children: _listButton().reversed.toList(),
                      )
                    ],
                  ),
          )),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        widget.title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _subtitle() {
    return Text(widget.subtitle);
  }

  Widget gapHeight({double height = 10}) {
    return SizedBox(height: height);
  }

  Widget _content() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.blueGrey.withValues(alpha: 0.2))),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: Colors.blue,
          ),
          SizedBox(width: 5),
          Expanded(
            child: Text(
                "Anda mungkin telah memilih unit yang lain atau kod QR ditukar oleh pihak lain"),
          )
        ],
      ),
    );
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
