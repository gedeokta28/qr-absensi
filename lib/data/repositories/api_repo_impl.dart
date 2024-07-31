import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qr_absensi/data/datasources/api_data_source.dart';
import 'package:qr_absensi/data/models/absen_response_model.dart';
import 'package:qr_absensi/data/models/absensi_list_response_model.dart';
import 'package:qr_absensi/data/models/login_response_model.dart';
import 'package:qr_absensi/data/models/matkul_response_model.dart';
import 'package:qr_absensi/data/models/qr_code_response_model.dart';
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
  Future<Either<Failure, bool>> doUpdatePassword(FormData formData) async {
    try {
      final data = await dataSource.doUpdatePassword(formData);
      return Right(data);
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, QRcodeResponseModel>> fetchQRcode(
      FormData formData) async {
    try {
      final data = await dataSource.fetchQRcode(formData);
      return Right(data);
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, MataKuliahResponseModel>> fetchMatkul() async {
    try {
      final data = await dataSource.fetchMatkul();
      return Right(data);
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, AbsenResponseModel>> doAbsen(FormData formData) async {
    try {
      final data = await dataSource.doAbsen(formData);
      return Right(data);
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, AbsensiListResponseModel>> fetchAbsensiList(
      String id) async {
    try {
      final data = await dataSource.fetchAbsensiList(id);
      return Right(data);
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
