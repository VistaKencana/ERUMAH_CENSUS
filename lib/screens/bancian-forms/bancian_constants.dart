import 'package:flutter/material.dart';

import 'anak_tanggungan/tanggungan_form.dart';
import 'pasangan/pasangan_form.dart';
import 'pendapatan/pendapatan_form.dart';
import 'penghuni/penghuni_form.dart';

enum BancianForms {
  penghuni(title: "Maklumat Penghuni", screen: PenghuniForm()),
  pasangan(title: "Maklumat Pasangan", screen: PasanganForm()),
  pendapatan(title: "Maklumat Pendapatan", screen: PendapatanForm()),
  anak(title: "Maklumat Anak & Tanggungan", screen: TanggunganForm()),
  ;

  final String title;
  final Widget screen;

  const BancianForms({required this.title, required this.screen});
}
