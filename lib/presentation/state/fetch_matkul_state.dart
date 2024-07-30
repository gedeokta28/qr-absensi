import 'package:equatable/equatable.dart';
import 'package:qr_absensi/data/models/matkul_response_model.dart';
import 'package:qr_absensi/utility/failures.dart';

abstract class FetchMatkulState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchMatkulLoading extends FetchMatkulState {}

class FetchMatkulSuccess extends FetchMatkulState {
  final List<MataKuliahItem> data;
  FetchMatkulSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchMatkulFailure extends FetchMatkulState {
  final ServerFailure failure;

  FetchMatkulFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
