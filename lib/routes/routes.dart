import 'package:flutter/material.dart';
import 'package:qr_absensi/data/models/matkul_response_model.dart';
import 'package:qr_absensi/presentation/pages/home_page_dosen.dart';
import 'package:qr_absensi/presentation/pages/home_page_mahasiswa.dart';
import 'package:qr_absensi/presentation/pages/login_page.dart';
import 'package:qr_absensi/presentation/pages/matkul_page.dart';
import 'package:qr_absensi/presentation/pages/profile_page.dart';
import 'package:qr_absensi/presentation/pages/show_qrcode_page.dart';
import 'package:qr_absensi/presentation/pages/splash_page.dart';
import 'package:qr_absensi/presentation/pages/sukses_absensi.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashPage.routeName:
      return MaterialPageRoute(builder: (_) => const SplashPage());
    case LoginPage.routeName:
      return MaterialPageRoute(builder: (_) => const LoginPage());
    case HomePageDosen.routeName:
      return MaterialPageRoute(builder: (_) => const HomePageDosen());
    case HomePageMahasiswa.routeName:
      return MaterialPageRoute(builder: (_) => const HomePageMahasiswa());
    case SuksesAbsensiPage.routeName:
      return MaterialPageRoute(builder: (_) => const SuksesAbsensiPage());
    case ProfilePage.routeName:
      return MaterialPageRoute(builder: (_) => const ProfilePage());
    case ShowQRcodePage.routeName:
      final url = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => ShowQRcodePage(urlQrCode: url));
    case MatkulPage.routeName:
      final listMatkul = settings.arguments as List<MataKuliahItem>;
      return MaterialPageRoute(
          builder: (_) => MatkulPage(listMatkul: listMatkul));
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
