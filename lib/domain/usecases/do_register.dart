import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qr_absensi/data/models/register_response_model.dart';
import 'package:qr_absensi/domain/repositories/api_repository.dart';
import 'package:qr_absensi/utility/failures.dart';

abstract class RegisterUseCase<Type> {
  Future<Either<Failure, RegisterResponseModel>> call(FormData data);
}

class DoRegister implements RegisterUseCase<String> {
  final ApiRepository repository;

  DoRegister({required this.repository});

  @override
  Future<Either<Failure, RegisterResponseModel>> call(FormData data) async {
    final result = await repository.doRegister(data);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
