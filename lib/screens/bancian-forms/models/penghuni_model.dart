class PenghuniModel {
  String? namaPenuh;
  int? bilanganIsiRumah;
  int? noKadPengenalan;
  String? emel;
  int? umur;
  int? noTelefon;
  String? jantina;
  String? tahapKesihatan;
  String? bangsa;
  String? kecacatan;
  String? jenisPekerjaan;
  String? statusPerkahwinan;

  PenghuniModel({
    required this.namaPenuh,
    required this.bilanganIsiRumah,
    required this.noKadPengenalan,
    required this.emel,
    required this.umur,
    required this.noTelefon,
    required this.jantina,
    required this.tahapKesihatan,
    required this.bangsa,
    required this.kecacatan,
    required this.jenisPekerjaan,
    required this.statusPerkahwinan,
  });

  PenghuniModel copyWith({
    String? namaPenuh,
    int? bilanganIsiRumah,
    int? noKadPengenalan,
    String? emel,
    int? umur,
    int? noTelefon,
    String? jantina,
    String? tahapKesihatan,
    String? bangsa,
    String? kecacatan,
    String? jenisPekerjaan,
    String? statusPerkahwinan,
  }) {
    return PenghuniModel(
      namaPenuh: namaPenuh ?? this.namaPenuh,
      bilanganIsiRumah: bilanganIsiRumah ?? this.bilanganIsiRumah,
      noKadPengenalan: noKadPengenalan ?? this.noKadPengenalan,
      emel: emel ?? this.emel,
      umur: umur ?? this.umur,
      noTelefon: noTelefon ?? this.noTelefon,
      jantina: jantina ?? this.jantina,
      tahapKesihatan: tahapKesihatan ?? this.tahapKesihatan,
      bangsa: bangsa ?? this.bangsa,
      kecacatan: kecacatan ?? this.kecacatan,
      jenisPekerjaan: jenisPekerjaan ?? this.jenisPekerjaan,
      statusPerkahwinan: statusPerkahwinan ?? this.statusPerkahwinan,
    );
  }

  List<PenghuniField> getPenghuniField() {
    return PenghuniField().getPenghuniField();
  }
}

class PenghuniField {
  String? fieldName;
  bool? readOnly;
  PenghuniField({this.fieldName, this.readOnly = false});
  List<PenghuniField> getPenghuniField() {
    List<String> field = [
      'Nama Penuh',
      'Bilangan Isi Rumah',
      'No. Kad Pengenalan',
      'Emel',
      'Umur(Tahun)',
      'No Telefon',
      'Jantina',
      'Tahap Kesihatan',
      'Bangsa',
      'Kecacatan (OKU)',
      'Jenis Pekerjaan',
      'Status Perkahwinan',
    ];
    return List.generate(
        field.length, (index) => PenghuniField(fieldName: field[index]));
  }
}
