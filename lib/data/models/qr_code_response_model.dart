import 'dart:convert';

QRcodeResponseModel qrCodeResponseModelFromJson(String str) =>
    QRcodeResponseModel.fromJson(json.decode(str));

String qrCodeResponseModelToJson(QRcodeResponseModel data) =>
    json.encode(data.toJson());

class QRcodeResponseModel {
  QRcodeResponseModel({
    required this.status,
    required this.url,
  });

  final String? status;
  final String? url;

  factory QRcodeResponseModel.fromJson(Map<String, dynamic> json) =>
      QRcodeResponseModel(url: json["url"], status: json["status"]);

  Map<String, dynamic> toJson() => {
        "status": status,
        "url": url,
      };
}
