import 'package:equatable/equatable.dart';
import 'package:qr_absensi/utility/failures.dart';

abstract class UpdatePasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdatePasswordLoading extends UpdatePasswordState {}

class UpdatePasswordSuccess extends UpdatePasswordState {
  final bool data;
  UpdatePasswordSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class UpdatePasswordFailure extends UpdatePasswordState {
  final ServerFailure failure;

  UpdatePasswordFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
