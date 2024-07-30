import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qr_absensi/data/models/qr_code_response_model.dart';
import 'package:qr_absensi/domain/repositories/api_repository.dart';
import 'package:qr_absensi/utility/failures.dart';
import 'package:qr_absensi/utility/session_helper.dart';

abstract class QrcodeUseCase<Type> {
  Future<Either<Failure, QRcodeResponseModel>> call(FormData data);
}

class DoQrcode implements QrcodeUseCase<String> {
  final ApiRepository repository;
  final Session session;

  DoQrcode({required this.repository, required this.session});

  @override
  Future<Either<Failure, QRcodeResponseModel>> call(FormData data) async {
    final result = await repository.fetchQRcode(data);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
