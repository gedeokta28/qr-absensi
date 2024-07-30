import 'package:flutter/material.dart';
import 'package:qr_absensi/presentation/pages/home_page_dosen.dart';
import 'package:qr_absensi/presentation/pages/home_page_mahasiswa.dart';
import 'package:qr_absensi/presentation/pages/login_page.dart';
import 'package:qr_absensi/static/assets.dart';
import 'package:qr_absensi/utility/injection.dart';
import 'package:qr_absensi/utility/session_helper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const routeName = '/splash';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    final session = locator<Session>();

    Future.delayed(const Duration(seconds: 2), () async {
      if (session.isLoggedIn && session.sessionRole == 'siswa') {
        Navigator.pushReplacementNamed(context, HomePageMahasiswa.routeName);
      } else if (session.isLoggedIn && session.sessionRole == 'guru') {
        Navigator.pushReplacementNamed(context, HomePageDosen.routeName);
      } else {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
      // Navigator.pushReplacementNamed(context, HomePageDosen.routeName);
      // } else {
      //   Navigator.pushReplacementNamed(context, LoginPage.routeName);
      // }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white54,
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Image.asset(
            appLogo,
            width: 250,
            height: 250,
          ),
        ),
      ),
    );
  }
}
