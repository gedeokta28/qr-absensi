import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qr_absensi/data/models/login_response_model.dart';
import 'package:qr_absensi/domain/repositories/api_repository.dart';
import 'package:qr_absensi/utility/failures.dart';
import 'package:qr_absensi/utility/session_helper.dart';

abstract class LoginUseCase<Type> {
  Future<Either<Failure, LoginResponseModel>> call(FormData data);
}

class DoLogin implements LoginUseCase<String> {
  final ApiRepository repository;
  final Session session;

  DoLogin({required this.repository, required this.session});

  @override
  Future<Either<Failure, LoginResponseModel>> call(FormData data) async {
    final result = await repository.doLogin(data);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
