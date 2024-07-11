import 'dart:math';

import 'package:dio/dio.dart';
import 'package:qr_absensi/domain/usecases/do_login.dart';
import 'package:qr_absensi/domain/usecases/get_istilah.dart';
import 'package:qr_absensi/presentation/providers/form_provider.dart';
import 'package:qr_absensi/presentation/state/login_state.dart';
import 'package:qr_absensi/utility/failures.dart';
import 'package:qr_absensi/utility/helper.dart';

class HomeProvider extends FormProvider {
  final DoLogin doLogin;

  HomeProvider({required this.doLogin});

  String _qrCode = '';
  bool _isShowQR = false;
  bool get isShowQR => _isShowQR;
  String get qrCode => _qrCode;

  Future<void> setQRCode() async {
    String strQr = generateRandomString(5);
    _qrCode = strQr;
    _isShowQR = true;
    notifyListeners();
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  Stream<LoginState> doLoginApi() async* {
    showLoading();
    yield LoginLoading();
    FormData formData =
        FormData.fromMap({'username': 'admin', 'password': 'admin'});

    final loginResult = await doLogin.call(formData);
    yield* loginResult.fold((failure) async* {
      dismissLoading();
      yield LoginFailure(failure: ServerFailure(message: failure.message));
    }, (result) async* {
      if (result.status == 'failed') {
        dismissLoading();
        yield LoginFailure(failure: const ServerFailure());
      } else {
        dismissLoading();
        yield LoginSuccess(data: result);
      }
    });
  }
}
