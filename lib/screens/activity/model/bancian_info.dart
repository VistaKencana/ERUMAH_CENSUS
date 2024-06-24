class BancianInfo {
  final String title;
  final String value;

  BancianInfo({required this.title, required this.value});

  static List<BancianInfo> getExampleData() {
    return [
      BancianInfo(title: "Zon:", value: "Zon 1"),
      BancianInfo(title: "Kawasan:", value: "PPR Sri Selangor"),
      BancianInfo(title: "Blok:", value: "20"),
      BancianInfo(title: "Tingkat:", value: "20"),
      BancianInfo(title: "Jumlah Unit Belum Dibanci:", value: "20"),
      BancianInfo(title: "Jumlah Unit Selesai Dibanci:", value: "0"),
    ];
  }
}
