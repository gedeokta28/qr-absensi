import 'package:equatable/equatable.dart';
import 'package:qr_absensi/data/models/qr_code_response_model.dart';
import 'package:qr_absensi/utility/failures.dart';

abstract class FetchQRState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchQRLoading extends FetchQRState {}

class FetchQRSuccess extends FetchQRState {
  final QRcodeResponseModel data;
  FetchQRSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchQRFailure extends FetchQRState {
  final ServerFailure failure;

  FetchQRFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
