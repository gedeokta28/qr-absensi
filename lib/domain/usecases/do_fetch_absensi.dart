import 'package:dartz/dartz.dart';
import 'package:qr_absensi/data/models/absensi_list_response_model.dart';
import 'package:qr_absensi/domain/repositories/api_repository.dart';
import 'package:qr_absensi/utility/failures.dart';

abstract class AbsensiListUseCase<Type> {
  Future<Either<Failure, AbsensiListResponseModel>> call(String id);
}

class DoAbsensiList implements AbsensiListUseCase<String> {
  final ApiRepository repository;

  DoAbsensiList({required this.repository});

  @override
  Future<Either<Failure, AbsensiListResponseModel>> call(String id) async {
    final result = await repository.fetchAbsensiList(id);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
