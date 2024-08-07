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

enum ReaderStatus {
  insert(
      title: "Please insert card",
      imgSrc: "assets/images/insert_card.png",
      query: "insert card"),
  cardSuccess(
      title: "Read card successful",
      imgSrc: "assets/images/success_card.png",
      query: "card successful"),
  cardFailed(
      title: "Remove card and try again",
      imgSrc: "assets/images/failed_card.png",
      query: "try again"),
  remove(
      title: "Remove card",
      imgSrc: "assets/images/remove_card.png",
      query: "remove card"),
  insertFP(
      title: "Please place your fingerprint at the scanner",
      imgSrc: "assets/images/fp_scan.png",
      query: "place your fingerprint"),
  successFP(
      title: "User verification successful",
      imgSrc: "assets/images/fp_success.png",
      query: "verification successful"),
  failedFP(
      title: "Error: Please try again in 3 second",
      imgSrc: "assets/images/fp_failed.png",
      query: "3 second"),
  loading(title: "Loading ...", imgSrc: "", query: "loading"),
  loadingFP(
      title: "Verifying Fingerprint...",
      imgSrc: "",
      query: "verifying fingerprint"),
  ;

  final String title;
  final String imgSrc;
  final String query;

  bool get isLoading =>
      this == ReaderStatus.loading || this == ReaderStatus.loadingFP;

  bool get isNotBlink =>
      this == ReaderStatus.cardSuccess || this == ReaderStatus.successFP;

  const ReaderStatus(
      {required this.title, required this.imgSrc, required this.query});
}
