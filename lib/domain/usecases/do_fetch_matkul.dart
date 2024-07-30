import 'package:dartz/dartz.dart';
import 'package:qr_absensi/data/models/matkul_response_model.dart';
import 'package:qr_absensi/domain/repositories/api_repository.dart';
import 'package:qr_absensi/utility/failures.dart';

abstract class MatkulUseCase<Type> {
  Future<Either<Failure, MataKuliahResponseModel>> call();
}

class DoMatkul implements MatkulUseCase<String> {
  final ApiRepository repository;

  DoMatkul({required this.repository});

  @override
  Future<Either<Failure, MataKuliahResponseModel>> call() async {
    final result = await repository.fetchMatkul();
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
