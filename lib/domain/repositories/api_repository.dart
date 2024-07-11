import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qr_absensi/data/models/istilah_response_model.dart';
import 'package:qr_absensi/data/models/login_response_model.dart';
import 'package:qr_absensi/data/models/register_response_model.dart';
import 'package:qr_absensi/utility/failures.dart';

abstract class ApiRepository {
  Future<Either<Failure, LoginResponseModel>> doLogin(FormData data);
  Future<Either<Failure, RegisterResponseModel>> doRegister(FormData data);
  Future<Either<Failure, IstilahResponseModel>> getDaftarIstilah();
}
