import 'package:flutter/material.dart';
import 'package:qr_absensi/presentation/pages/home_page_dosen.dart';
import 'package:qr_absensi/presentation/pages/home_page_mahasiswa.dart';
import 'package:qr_absensi/presentation/pages/profile_page.dart';
import 'package:qr_absensi/presentation/providers/login_provider.dart';
import 'package:qr_absensi/presentation/state/login_state.dart';
import 'package:qr_absensi/presentation/widgets/custom_simple_dialog.dart';
import 'package:qr_absensi/presentation/widgets/custom_text_field.dart';
import 'package:qr_absensi/presentation/widgets/rounded_button.dart';
import 'package:qr_absensi/static/assets.dart';
import 'package:qr_absensi/static/colors.dart';
import 'package:qr_absensi/utility/helper.dart';
import 'package:qr_absensi/utility/injection.dart';
import 'package:provider/provider.dart';
import 'package:qr_absensi/utility/session_helper.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => locator<LoginProvider>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0.2,
          centerTitle: true,
          title: Text(
            'Login',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: ListView(children: [
            Center(
              child: Image.asset(
                appLogo,
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Consumer<LoginProvider>(builder: (context, provider, _) {
              return Form(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        title: "NIM/NRP",
                        border: true,
                        placeholder: "Masukkan NIM/NRP",
                        controller: provider.usernameController,
                        inputType: TextInputType.text,
                        fieldValidator: null,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        title: "Kata sandi",
                        isSecure: true,
                        refresh: true,
                        placeholder: "Masukkan Password",
                        controller: provider.passwordController,
                        inputType: TextInputType.visiblePassword,
                        border: true,
                        fieldValidator: null,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RoundedButton(
                          title: "Masuk",
                          event: () {
                            // final session = locator<Session>();

                            // if (provider.usernameController.text.isNotEmpty &&
                            //     provider.passwordController.text.isNotEmpty) {
                            //   if (provider.formKey.currentState!.validate()) {
                            //     if (provider.usernameController.text ==
                            //             '12345' &&
                            //         provider.passwordController.text ==
                            //             'dosen') {
                            //       session.setLoggedIn = true;
                            //       session.setRole = 'dosen';
                            //       Navigator.of(context).pushNamedAndRemoveUntil(
                            //           HomePageDosen.routeName,
                            //           (Route<dynamic> route) => false);
                            //       showShortToast(message: "Login Sukses");
                            //     } else if (provider.usernameController.text ==
                            //             '12345' &&
                            //         provider.passwordController.text ==
                            //             'mahasiswa') {
                            //       session.setLoggedIn = true;
                            //       session.setRole = 'mahasiswa';
                            //       Navigator.of(context).pushNamedAndRemoveUntil(
                            //           HomePageMahasiswa.routeName,
                            //           (Route<dynamic> route) => false);
                            //       showShortToast(message: "Login Sukses");
                            //     } else {
                            //       showDialog(
                            //         context: context,
                            //         builder: (_) => CustomSimpleDialog(
                            //           onTap: () {
                            //             Navigator.pop(context);
                            //           },
                            //           text:
                            //               'Pastikan Username dan Password Benar !',
                            //           color: Colors.black,
                            //         ),
                            //       );
                            //     }
                            //   }
                            // } else {}
                            if (provider.usernameController.text.isNotEmpty &&
                                provider.passwordController.text.isNotEmpty) {
                              if (provider.formKey.currentState!.validate()) {
                                provider.doLoginApi().listen((state) async {
                                  switch (state.runtimeType) {
                                    case LoginFailure:
                                      showDialog(
                                        context: context,
                                        builder: (_) => CustomSimpleDialog(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          text:
                                              'Pastikan Username dan Password Benar !',
                                          color: Colors.black,
                                        ),
                                      );
                                      break;
                                    case LoginSuccess:
                                      final result =
                                          (state as LoginSuccess).data;
                                      if (result.role == 'siswa') {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                HomePageMahasiswa.routeName,
                                                (Route<dynamic> route) =>
                                                    false);
                                      } else {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                HomePageDosen.routeName,
                                                (Route<dynamic> route) =>
                                                    false);
                                      }
                                      showShortToast(message: "Login Sukses");
                                      Navigator.pushNamed(
                                          context, ProfilePage.routeName);

                                      break;
                                  }
                                });
                              }
                            } else {}
                          }),
                    ],
                  ));
            })
          ]),
        ),
      ),
    );
  }
}
