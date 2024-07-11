import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.data,
    required this.status,
  });

  LoginData? data;
  final String status;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
          data: json["user"] != null ? LoginData.fromJson(json["user"]) : null,
          status: json["status"]);

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "status": status,
      };
}

class LoginData {
  LoginData({
    required this.id,
    required this.fullname,
    required this.username,
  });

  final String id;
  final String fullname;
  final String username;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        id: json["id"],
        fullname: json["fullname"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "username": username,
      };
}
