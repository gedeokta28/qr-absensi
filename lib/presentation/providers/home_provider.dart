import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qr_absensi/domain/usecases/do_absen.dart';
import 'package:qr_absensi/domain/usecases/do_fetch_matkul.dart';
import 'package:qr_absensi/domain/usecases/do_fetch_qr.dart';
import 'package:qr_absensi/domain/usecases/do_update_password.dart';
import 'package:qr_absensi/presentation/pages/matkul_page.dart';
import 'package:qr_absensi/presentation/pages/show_qrcode_page.dart';
import 'package:qr_absensi/presentation/providers/form_provider.dart';
import 'package:qr_absensi/presentation/state/absen_state.dart';
import 'package:qr_absensi/presentation/state/fetch_matkul_state.dart';
import 'package:qr_absensi/presentation/state/fetch_qr_state.dart';
import 'package:qr_absensi/presentation/state/update_password_state.dart';
import 'package:qr_absensi/utility/failures.dart';
import 'package:qr_absensi/utility/helper.dart';
import 'package:qr_absensi/utility/injection.dart';
import 'package:qr_absensi/utility/session_helper.dart';

class HomeProvider extends FormProvider {
  final DoUpdatePassword doUpdatePassword;
  final DoMatkul doMatkul;
  final DoQrcode doQrcode;
  final DoAbsen doAbsen;

  HomeProvider(
      {required this.doUpdatePassword,
      required this.doQrcode,
      required this.doAbsen,
      required this.doMatkul});

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

  Stream<FetchQRState> fetchQRCode(BuildContext context) async* {
    final session = locator<Session>();
    showLoading();
    yield FetchQRLoading();
    FormData formData = FormData.fromMap({'id': session.sessionId});

    final result = await doQrcode.call(formData);
    yield* result.fold((failure) async* {
      dismissLoading();
      yield FetchQRFailure(failure: ServerFailure(message: failure.message));
    }, (result) async* {
      if (result.status == 'failed') {
        dismissLoading();
        yield FetchQRFailure(failure: const ServerFailure());
      } else {
        dismissLoading();
        Navigator.pushNamed(context, ShowQRcodePage.routeName,
            arguments: result.url);
        yield FetchQRSuccess(data: result);
      }
    });
  }

  Stream<FetchMatkulState> fetchMatkul(BuildContext context) async* {
    showLoading();
    yield FetchMatkulLoading();

    final result = await doMatkul.call();
    yield* result.fold((failure) async* {
      dismissLoading();
      yield FetchMatkulFailure(
          failure: ServerFailure(message: failure.message));
    }, (result) async* {
      dismissLoading();
      Navigator.pushNamed(context, MatkulPage.routeName,
          arguments: result.data);
      yield FetchMatkulSuccess(data: result.data);
    });
  }

  setProfileData() async {
    final session = locator<Session>();
    usernameController.text = session.sessionUsername;
    noHpController.text = session.sessionNoHp;
    fullNameController.text = session.sessionFullname;
    notifyListeners();
  }

  Stream<UpdatePasswordState> doUpdatePwApi() async* {
    final session = locator<Session>();
    showLoading();
    yield UpdatePasswordLoading();
    FormData formData = FormData.fromMap({
      'id': session.sessionId,
      'no_hp': noHpController.text,
      'password': passwordController.text
    });

    final result = await doUpdatePassword.call(formData);
    yield* result.fold((failure) async* {
      dismissLoading();
      yield UpdatePasswordFailure(
          failure: ServerFailure(message: failure.message));
    }, (result) async* {
      if (result) {
        dismissLoading();
        yield UpdatePasswordSuccess(data: result);
      } else {
        dismissLoading();
        yield UpdatePasswordFailure(failure: const ServerFailure());
      }
    });
  }

  Stream<AbsenState> doAbsenApi(String idMatkul, String code) async* {
    showLoading();
    await Future.delayed(const Duration(milliseconds: 1000));

    final session = locator<Session>();
    yield AbsenLoading();
    FormData formData = FormData.fromMap({
      'unique_code': code,
      'waktu': 'masuk',
      'matakuliah': idMatkul,
      'id_dosen': session.sessionId
    });

    final result = await doAbsen.call(formData);
    yield* result.fold((failure) async* {
      dismissLoading();
      yield AbsenFailure(failure: ServerFailure(message: failure.message));
    }, (result) async* {
      dismissLoading();
      yield AbsenSuccess(data: result);
    });
  }
}
