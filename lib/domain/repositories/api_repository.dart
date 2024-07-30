import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qr_absensi/data/models/login_response_model.dart';
import 'package:qr_absensi/data/models/matkul_response_model.dart';
import 'package:qr_absensi/data/models/qr_code_response_model.dart';
import 'package:qr_absensi/utility/failures.dart';

abstract class ApiRepository {
  Future<Either<Failure, LoginResponseModel>> doLogin(FormData data);
  Future<Either<Failure, bool>> doUpdatePassword(FormData data);
  Future<Either<Failure, QRcodeResponseModel>> fetchQRcode(FormData data);
  Future<Either<Failure, MataKuliahResponseModel>> fetchMatkul();
}
