import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:qr_absensi/utility/app_setting.dart';

import 'app_interceptor.dart';

class DioClient {
  static late Dio _dio;
  final AppInterceptor appInterceptor = AppInterceptor();
  addInterception() {
    _dio.interceptors.addAll([
      appInterceptor,
      dioLoggerInterceptor,
    ]);
  }

  DioClient({String base = baseUrl}) {
    _dio = Dio(BaseOptions(
        baseUrl: base,
        validateStatus: (status) => (status! >= 200) && (status < 400),
        connectTimeout: 60 * 1000));
    addInterception();
  }

  Dio get dio => _dio;
}
