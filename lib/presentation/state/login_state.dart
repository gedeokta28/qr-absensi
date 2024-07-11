import 'package:equatable/equatable.dart';
import 'package:qr_absensi/data/models/login_response_model.dart';
import 'package:qr_absensi/utility/failures.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponseModel data;
  LoginSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class LoginFailure extends LoginState {
  final ServerFailure failure;

  LoginFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
