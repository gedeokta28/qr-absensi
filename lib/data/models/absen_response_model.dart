import 'dart:convert';

AbsenResponseModel absenResponseModelFromJson(String str) =>
    AbsenResponseModel.fromJson(json.decode(str));

String absenResponseModelToJson(AbsenResponseModel data) =>
    json.encode(data.toJson());

class AbsenResponseModel {
  AbsenResponseModel({
    required this.message,
    required this.data,
  });

  final DataAbsen? data;
  final String? message;

  factory AbsenResponseModel.fromJson(Map<String, dynamic> json) =>
      AbsenResponseModel(
        message: json["message"],
        data: json["data"] != null ? DataAbsen.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {};
}

class DataAbsen {
  DataAbsen({
    required this.namaSiswa,
  });

  final String namaSiswa;

  factory DataAbsen.fromJson(Map<String, dynamic> json) => DataAbsen(
        namaSiswa: json["nama_siswa"],
      );

  Map<String, dynamic> toJson() => {};
}
