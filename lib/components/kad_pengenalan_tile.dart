import 'dart:typed_data';

import 'package:eperumahan_bancian/components/card_display.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

class KadPengenalanTile extends StatefulWidget {
  final void Function(Uint8List bytes) onFrontCard;
  final void Function(Uint8List bytes) onBackCard;
  const KadPengenalanTile(
      {super.key, required this.onFrontCard, required this.onBackCard});

  @override
  State<KadPengenalanTile> createState() => _KadPengenalanTileState();
}

class _KadPengenalanTileState extends State<KadPengenalanTile> {
  Uint8List? frontCard;
  Uint8List? backCard;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Card(
        color: Colors.white,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: ExpansionTile(
            initiallyExpanded: true,
            backgroundColor: Colors.white,
            shape: const Border(),
            title: Row(
              children: [
                Text(
                  "Kad Pengenalan",
                  style: appTextStyle(size: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
                const Text(
                  "*",
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CardDisplay(
                        title: "Kad Pengenalan Depan",
                        img: frontCard,
                        onPicture: (bytes) {
                          setState(() => frontCard = bytes);
                          widget.onFrontCard(bytes);
                        },
                      ),
                      const SizedBox(width: 10),
                      CardDisplay(
                        title: "Kad Pengenalan Belakang",
                        img: backCard,
                        onPicture: (bytes) {
                          setState(() => backCard = bytes);
                          widget.onBackCard(bytes);
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
