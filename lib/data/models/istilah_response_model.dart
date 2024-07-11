import 'dart:convert';

IstilahResponseModel istilahResponseModelFromJson(String str) =>
    IstilahResponseModel.fromJson(json.decode(str));

String istilahResponseModelToJson(IstilahResponseModel data) =>
    json.encode(data.toJson());

class IstilahResponseModel {
  IstilahResponseModel({
    required this.data,
  });

  final List<IstilahData> data;

  factory IstilahResponseModel.fromJson(Map<String, dynamic> json) =>
      IstilahResponseModel(
        data: List<IstilahData>.from(
            json["data"].map((x) => IstilahData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {};
}

class IstilahData {
  IstilahData({
    required this.idistilah,
    required this.namaIstilah,
    required this.deskripsi,
  });

  final String idistilah;
  final String namaIstilah;
  final String deskripsi;

  factory IstilahData.fromJson(Map<String, dynamic> json) => IstilahData(
        idistilah: json["idistilah"],
        namaIstilah: json["nama_istilah"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {};
}
