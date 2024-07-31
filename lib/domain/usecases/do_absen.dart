import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qr_absensi/data/models/absen_response_model.dart';
import 'package:qr_absensi/domain/repositories/api_repository.dart';
import 'package:qr_absensi/utility/failures.dart';

abstract class AbsenUseCase<Type> {
  Future<Either<Failure, AbsenResponseModel>> call(FormData data);
}

class DoAbsen implements AbsenUseCase<String> {
  final ApiRepository repository;

  DoAbsen({required this.repository});

  @override
  Future<Either<Failure, AbsenResponseModel>> call(FormData data) async {
    final result = await repository.doAbsen(data);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
