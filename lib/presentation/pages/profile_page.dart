import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_absensi/presentation/providers/home_provider.dart';
import 'package:qr_absensi/presentation/state/update_password_state.dart';
import 'package:qr_absensi/presentation/widgets/custom_simple_dialog.dart';
import 'package:qr_absensi/presentation/widgets/custom_text_field.dart';
import 'package:qr_absensi/presentation/widgets/rounded_button.dart';
import 'package:qr_absensi/static/colors.dart';
import 'package:qr_absensi/utility/helper.dart';
import 'package:qr_absensi/utility/injection.dart';
import 'package:qr_absensi/utility/session_helper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const routeName = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final session = locator<Session>();

    return ChangeNotifierProvider(
      create: (context) => locator<HomeProvider>()..setProfileData(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0.2,
            centerTitle: true,
            title: Text(
              'Profil',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          body: Consumer<HomeProvider>(builder: (context, provider, _) {
            if (session.sessionRole == 'siswa') {
              return SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Form(
                        key: provider.formKey,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Column(children: [
                              CustomTextField(
                                title: "NIM",
                                border: true,
                                enabled: false,
                                controller: provider.usernameController,
                                inputType: TextInputType.text,
                                fieldValidator: null,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                title: "Nama",
                                border: true,
                                enabled: false,
                                controller: provider.fullNameController,
                                inputType: TextInputType.text,
                                fieldValidator: null,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                title: "No. Telepon",
                                border: true,
                                enabled: false,
                                controller: provider.noHpController,
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
                                  title: "Ubah Kata Sandi",
                                  event: () {
                                    if (provider
                                            .noHpController.text.isNotEmpty &&
                                        provider.passwordController.text
                                            .isNotEmpty) {
                                      provider
                                          .doUpdatePwApi()
                                          .listen((state) async {
                                        switch (state.runtimeType) {
                                          case UpdatePasswordFailure:
                                            final result = (state
                                                as UpdatePasswordFailure);
                                            showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  CustomSimpleDialog(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                text: result.failure.message,
                                                color: Colors.black,
                                              ),
                                            );
                                            break;
                                          case UpdatePasswordSuccess:
                                            showShortToast(
                                                message:
                                                    "Kata Sandi Berhasil Diganti");

                                            Navigator.pop(context);

                                            break;
                                        }
                                      });
                                    }
                                  })
                            ])))
                  ]));
            } else {
              return SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Form(
                        key: provider.formKey,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Column(children: [
                              CustomTextField(
                                title: "NIDN",
                                border: true,
                                enabled: false,
                                controller: provider.usernameController,
                                inputType: TextInputType.text,
                                fieldValidator: null,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                title: "Nama",
                                border: true,
                                enabled: false,
                                controller: provider.fullNameController,
                                inputType: TextInputType.text,
                                fieldValidator: null,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                title: "No. Telepon",
                                border: true,
                                controller: provider.noHpController,
                                enabled: false,
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
                                  title: "Ubah Kata Sandi",
                                  event: () {
                                    if (provider
                                            .noHpController.text.isNotEmpty &&
                                        provider.passwordController.text
                                            .isNotEmpty) {
                                      provider
                                          .doUpdatePwApi()
                                          .listen((state) async {
                                        switch (state.runtimeType) {
                                          case UpdatePasswordFailure:
                                            final result = (state
                                                as UpdatePasswordFailure);
                                            showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  CustomSimpleDialog(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                text: result.failure.message,
                                                color: Colors.black,
                                              ),
                                            );
                                            break;
                                          case UpdatePasswordSuccess:
                                            showShortToast(
                                                message:
                                                    "Kata Sandi Berhasil Diganti");

                                            Navigator.pop(context);

                                            break;
                                        }
                                      });
                                    }
                                  })
                            ])))
                  ]));
            }
          })),
    );
  }
}
