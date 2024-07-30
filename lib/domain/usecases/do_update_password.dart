import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qr_absensi/domain/repositories/api_repository.dart';
import 'package:qr_absensi/utility/failures.dart';
import 'package:qr_absensi/utility/session_helper.dart';

abstract class UpdatePasswordUseCase<Type> {
  Future<Either<Failure, bool>> call(FormData data);
}

class DoUpdatePassword implements UpdatePasswordUseCase<String> {
  final ApiRepository repository;
  final Session session;

  DoUpdatePassword({required this.repository, required this.session});

  @override
  Future<Either<Failure, bool>> call(FormData data) async {
    final result = await repository.doUpdatePassword(data);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
