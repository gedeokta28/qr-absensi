import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qr_absensi/data/datasources/api_data_source.dart';
import 'package:qr_absensi/data/models/istilah_response_model.dart';
import 'package:qr_absensi/data/models/login_response_model.dart';
import 'package:qr_absensi/data/models/register_response_model.dart';
import 'package:qr_absensi/domain/repositories/api_repository.dart';
import 'package:qr_absensi/utility/failures.dart';

class ApiRepoImpl implements ApiRepository {
  final ApiDataSource dataSource;

  ApiRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, LoginResponseModel>> doLogin(FormData formData) async {
    try {
      final data = await dataSource.doLogin(formData);
      return Right(data);
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, RegisterResponseModel>> doRegister(
      FormData formData) async {
    try {
      final data = await dataSource.doRegister(formData);
      return Right(data);
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, IstilahResponseModel>> getDaftarIstilah() async {
    try {
      final data = await dataSource.getDaftarIstilah();
      return Right(data);
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
