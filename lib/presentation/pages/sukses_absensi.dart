import 'package:flutter/material.dart';
import 'package:qr_absensi/presentation/pages/login_page.dart';
import 'package:qr_absensi/presentation/widgets/rounded_button.dart';
import 'package:qr_absensi/static/assets.dart';
import 'package:qr_absensi/utility/helper.dart';

class SuksesAbsensiPage extends StatefulWidget {
  const SuksesAbsensiPage({super.key});
  static const routeName = '/sukses-absensi';

  @override
  State<SuksesAbsensiPage> createState() => _SuksesAbsensiPageState();
}

class _SuksesAbsensiPageState extends State<SuksesAbsensiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Text(
              'ABSENSI ANDA BERHASIL',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Image.asset(
              suksesIcon,
              width: 150,
              height: 150,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
            child: RoundedButton(
              title: 'KELUAR',
              event: () async {
                await sessionLogOut().then((_) => Navigator.of(context)
                    .pushNamedAndRemoveUntil(
                        LoginPage.routeName, (route) => false));
              },
              size: 50,
            ),
          )
        ],
      ),
    );
  }
}
