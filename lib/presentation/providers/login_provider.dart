import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qr_absensi/domain/usecases/do_login.dart';
import 'package:qr_absensi/presentation/providers/form_provider.dart';
import 'package:qr_absensi/presentation/state/login_state.dart';
import 'package:qr_absensi/utility/failures.dart';
import 'package:qr_absensi/utility/helper.dart';
import 'package:qr_absensi/utility/injection.dart';
import 'package:qr_absensi/utility/session_helper.dart';

class LoginProvider extends FormProvider {
  final DoLogin doLogin;
  final session = locator<Session>();

  LoginProvider({required this.doLogin});

  Stream<LoginState> doLoginApi() async* {
    showLoading();
    yield LoginLoading();
    FormData formData = FormData.fromMap(
        {'id': usernameController.text, 'password': passwordController.text});

    final loginResult = await doLogin.call(formData);
    yield* loginResult.fold((failure) async* {
      dismissLoading();
      yield LoginFailure(failure: ServerFailure(message: failure.message));
    }, (result) async* {
      if (result.status == 'failed') {
        dismissLoading();
        yield LoginFailure(failure: const ServerFailure());
      } else {
        session.setLoggedIn = true;
        session.setRole = result.role!;
        // session.setId = result.data!.id;
        // session.setUsername = result.data!.username;
        // session.setFullname = result.data!.fullname;
        dismissLoading();
        yield LoginSuccess(data: result);
      }
    });
  }
}
