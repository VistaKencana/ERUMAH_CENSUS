enum AppImages {
  dbklLogo(path: "assets/images/dbkl_logo.png"),
  icId(path: "assets/images/icon_id.png"),
  icLock(path: "assets/images/icon_lock.png"),
  icLogMasuk(path: "assets/images/log_masuk.png"),
  bg(path: "assets/images/background.png"),
  apartment(path: "assets/images/apartment.png"),
  //
  insertCard(path: "assets/images/inseert_card.png"),
  successCard(path: "assets/images/success_card.png"),
  failedCard(path: "assets/images/failed_card.png"),
  removeCard(path: "assets/images/remove_card.png"),
  //
  scanFP(path: "assets/images/fp_scan.png"),
  successFP(path: "assets/images/fp_success.png"),
  failedFP(path: "assets/images/fp_failed.png"),
  custService(path: "assets/images/customer_service.png"),
  ;

  final String path;
  const AppImages({required this.path});
}
