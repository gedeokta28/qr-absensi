import 'dart:convert';

MataKuliahResponseModel istilahResponseModelFromJson(String str) =>
    MataKuliahResponseModel.fromJson(json.decode(str));

String istilahResponseModelToJson(MataKuliahResponseModel data) =>
    json.encode(data.toJson());

class MataKuliahResponseModel {
  MataKuliahResponseModel({
    required this.data,
  });

  final List<MataKuliahItem> data;

  factory MataKuliahResponseModel.fromJson(Map<String, dynamic> json) =>
      MataKuliahResponseModel(
        data: List<MataKuliahItem>.from(
            json["data"].map((x) => MataKuliahItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {};
}

class MataKuliahItem {
  MataKuliahItem({
    required this.idMataKuliah,
    required this.namaMataKuliah,
  });

  final String idMataKuliah;
  final String namaMataKuliah;

  factory MataKuliahItem.fromJson(Map<String, dynamic> json) => MataKuliahItem(
        idMataKuliah: json["id_matakuliah"],
        namaMataKuliah: json["matakuliah"],
      );

  Map<String, dynamic> toJson() => {};
}
