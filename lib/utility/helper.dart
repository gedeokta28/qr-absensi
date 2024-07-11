import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_absensi/static/colors.dart';
import 'package:qr_absensi/utility/injection.dart';
import 'package:qr_absensi/utility/session_helper.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

showLoading() {
  SmartDialog.showLoading(
    backDismiss: false,
    builder: (context) => const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor)),
  );
}

dismissLoading() {
  SmartDialog.dismiss();
}

void showShortToast({required String message, Color? color}) {
  Fluttertoast.showToast(
      backgroundColor: color ?? Colors.black,
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 1);
}

Future<void> sessionLogOut() async {
  final session = locator<Session>();
  await session.clearSession();
}
