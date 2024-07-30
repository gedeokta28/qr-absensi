import 'package:dio/dio.dart';
import 'package:qr_absensi/data/models/login_response_model.dart';
import 'package:qr_absensi/data/models/qr_code_response_model.dart';
import 'package:qr_absensi/utility/injection.dart';
import 'package:qr_absensi/utility/session_helper.dart';

abstract class ApiDataSource {
  Future<LoginResponseModel> doLogin(FormData data);
  Future<bool> doUpdatePassword(FormData data);
  Future<QRcodeResponseModel> fetchQRcode(FormData data);
}

class ApiDataSourceImplementation implements ApiDataSource {
  final Dio dio;

  ApiDataSourceImplementation({required this.dio});

  @override
  Future<LoginResponseModel> doLogin(FormData data) async {
    String url = 'api/login';

    try {
      final response = await dio.post(
        url,
        data: data,
      );
      final model = LoginResponseModel.fromJson(response.data);
      return model;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> doUpdatePassword(FormData data) async {
    final session = locator<Session>();
    String url;
    if (session.sessionRole == 'siswa') {
      url = 'api/update-siswa';
    } else {
      url = 'api/update-guru';
    }
    try {
      final response = await dio.post(
        url,
        data: data,
      );
      return response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<QRcodeResponseModel> fetchQRcode(FormData data) async {
    String url = 'api/generate/qr-siswa';

    try {
      final response = await dio.post(
        url,
        data: data,
      );
      final model = QRcodeResponseModel.fromJson(response.data);
      return model;
    } catch (e) {
      rethrow;
    }
  }
}
