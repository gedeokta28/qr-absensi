import 'package:dio/dio.dart';
import 'package:qr_absensi/data/models/istilah_response_model.dart';
import 'package:qr_absensi/data/models/login_response_model.dart';
import 'package:qr_absensi/data/models/register_response_model.dart';

abstract class ApiDataSource {
  Future<LoginResponseModel> doLogin(FormData data);
  Future<RegisterResponseModel> doRegister(FormData data);
  Future<IstilahResponseModel> getDaftarIstilah();
}

class ApiDataSourceImplementation implements ApiDataSource {
  final Dio dio;

  ApiDataSourceImplementation({required this.dio});

  @override
  Future<LoginResponseModel> doLogin(FormData data) async {
    String url = 'login/apicek_login';

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
  Future<RegisterResponseModel> doRegister(FormData data) async {
    String url = 'register/regis';

    try {
      final response = await dio.post(
        url,
        data: data,
      );
      final model = RegisterResponseModel.fromJson(response.data);
      return model;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<IstilahResponseModel> getDaftarIstilah() async {
    String url = 'Kegiatan/api_kegiatan';

    try {
      final response = await dio.get(
        url,
      );
      final model = IstilahResponseModel.fromJson(response.data);
      return model;
    } catch (e) {
      rethrow;
    }
  }
}
