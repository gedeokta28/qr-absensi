import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    required this.status,
    required this.role,
    required this.data,
  });

  final String? status;
  final String? role;
  final LoginData? data;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
          data: json["data"] != null
              ? LoginData.fromJson(json["data"], json["role"])
              : null,
          role: json["role"],
          status: json["status"]);

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "status": status,
      };
}

class LoginData {
  LoginData({
    required this.id,
    required this.userId,
    required this.nama,
    required this.noHp,
  });

  final String id;
  final String userId;
  final String nama;
  final String noHp;

  factory LoginData.fromJson(Map<String, dynamic> json, String role) {
    if (role == 'siswa') {
      return LoginData(
        id: json["id_siswa"],
        userId: json["nis"],
        nama: json["nama_siswa"],
        noHp: json["no_hp"],
      );
    } else {
      return LoginData(
        id: json["id_guru"],
        userId: json["nuptk"],
        nama: json["nama_guru"],
        noHp: json["no_hp"],
      );
    }
  }

  Map<String, dynamic> toJson() => {};
}
