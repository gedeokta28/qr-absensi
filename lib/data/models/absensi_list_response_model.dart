import 'dart:convert';

AbsensiListResponseModel absensiListResponseModelFromJson(String str) =>
    AbsensiListResponseModel.fromJson(json.decode(str));

String absensiListResponseModelToJson(AbsensiListResponseModel data) =>
    json.encode(data.toJson());

class AbsensiListResponseModel {
  AbsensiListResponseModel({
    required this.data,
  });

  final List<AbsensiListItem> data;

  factory AbsensiListResponseModel.fromJson(Map<String, dynamic> json) =>
      AbsensiListResponseModel(
        data: List<AbsensiListItem>.from(
            json["data"].map((x) => AbsensiListItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {};
}

class AbsensiListItem {
  AbsensiListItem({
    required this.idPresensi,
    required this.idSiswa,
    required this.idKelas,
    required this.tanggal,
    required this.jamMasuk,
    this.jamKeluar,
    required this.idKehadiran,
    required this.keterangan,
    required this.idMatakuliah,
    required this.idGuru,
    required this.matakuliah,
    required this.nama,
    required this.nim,
  });

  final String idPresensi;
  final String idSiswa;
  final String idKelas;
  final String tanggal;
  final String jamMasuk;
  final String? jamKeluar;
  final String idKehadiran;
  final String keterangan;
  final String idMatakuliah;
  final String idGuru;
  final String matakuliah;
  final String nama;
  final String nim;

  factory AbsensiListItem.fromJson(Map<String, dynamic> json) =>
      AbsensiListItem(
        idPresensi: json['id_presensi'],
        idSiswa: json['id_siswa'],
        idKelas: json['id_kelas'],
        tanggal: json['tanggal'],
        jamMasuk: json['jam_masuk'],
        jamKeluar: json['jam_keluar'],
        idKehadiran: json['id_kehadiran'],
        keterangan: json['keterangan'],
        idMatakuliah: json['id_matakuliah'],
        idGuru: json['id_guru'],
        matakuliah: json['matakuliah'],
        nama: json['nama_siswa'],
        nim: json['nis'],
      );

  Map<String, dynamic> toJson() => {};
}
