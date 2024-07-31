import 'package:equatable/equatable.dart';
import 'package:qr_absensi/data/models/absensi_list_response_model.dart';
import 'package:qr_absensi/utility/failures.dart';

abstract class FetchAbsensiState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAbsensiLoading extends FetchAbsensiState {}

class FetchAbsensiSuccess extends FetchAbsensiState {
  final List<AbsensiListItem> data;
  FetchAbsensiSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchAbsensiFailure extends FetchAbsensiState {
  final ServerFailure failure;

  FetchAbsensiFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
