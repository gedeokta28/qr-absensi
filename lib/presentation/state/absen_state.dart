import 'package:equatable/equatable.dart';
import 'package:qr_absensi/data/models/absen_response_model.dart';
import 'package:qr_absensi/utility/failures.dart';

abstract class AbsenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AbsenLoading extends AbsenState {}

class AbsenSuccess extends AbsenState {
  final AbsenResponseModel data;
  AbsenSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class AbsenFailure extends AbsenState {
  final ServerFailure failure;

  AbsenFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
