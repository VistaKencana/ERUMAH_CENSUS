import 'package:flutter/material.dart';

import 'anak_tanggung_form.dart';
import 'pasangan_form.dart';
import 'pendapatan_form.dart';
import 'penguni_form.dart';

enum BancianForms {
  penghuni(title: "Maklumat Penghuni", screen: PenguniForm()),
  pasangan(title: "Maklumat Pasangan", screen: PasanganForm()),
  pendapatan(title: "Maklumat Pendapatan", screen: PendapatanForm()),
  anak(title: "Maklumat Anak & Tanggungan", screen: AnakTanggungForm()),
  ;

  final String title;
  final Widget screen;

  const BancianForms({required this.title, required this.screen});
}