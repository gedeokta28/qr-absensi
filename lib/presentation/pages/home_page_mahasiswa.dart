import 'package:flutter/material.dart';
import 'package:qr_absensi/presentation/pages/login_page.dart';
import 'package:qr_absensi/presentation/pages/profile_page.dart';
import 'package:qr_absensi/presentation/providers/home_provider.dart';
import 'package:qr_absensi/presentation/widgets/custom_dialog_logout.dart';
import 'package:qr_absensi/presentation/widgets/rounded_button.dart';
import 'package:qr_absensi/static/assets.dart';
import 'package:qr_absensi/static/colors.dart';
import 'package:qr_absensi/utility/helper.dart';
import 'package:qr_absensi/utility/injection.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePageMahasiswa extends StatefulWidget {
  const HomePageMahasiswa({super.key});
  static const routeName = '/home-mahasiswa';

  @override
  State<HomePageMahasiswa> createState() => _HomePageMahasiswaState();
}

class _HomePageMahasiswaState extends State<HomePageMahasiswa> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => locator<HomeProvider>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0.2,
          centerTitle: true,
          title: Text(
            'ABSENSI QR-CODE',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          actions: [
            InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => CustomLogoutDialog(
                      positiveAction: () async {
                        await sessionLogOut().then((_) => Navigator.of(context)
                            .pushNamedAndRemoveUntil(
                                LoginPage.routeName, (route) => false));
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(Icons.logout_outlined),
                ))
          ],
        ),
        body: Consumer<HomeProvider>(builder: (context, provider, _) {
          if (provider.isShowQR) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  child: Text(
                    'SILAHKAN MELAKUKAN\nSCAN QR CODE  DI BAWAH INI',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: QrImageView(
                    data: provider.qrCode,
                    size: 250,
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: const Size(
                        100,
                        100,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const GridMenuWidget();
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Text(
                  'Tekan Button di bawah untuk menampilkan QR Code',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                RoundedButton(
                  title: 'QR-CODE',
                  event: () async {
                    showLoading();
                    Future.delayed(const Duration(seconds: 2), () async {
                      await provider.setQRCode();
                      dismissLoading();
                    });
                  },
                  size: 60,
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

class GridMenuWidget extends StatelessWidget {
  const GridMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<_MenuItem> menuList = [
      _MenuItem(appLogo, 'QR-Code'),
      _MenuItem(appLogo, 'Lihat Absensi'),
      _MenuItem(appLogo, 'Profil'),
    ];
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: GridView.builder(
            itemCount: menuList.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 1.1),
            itemBuilder: (context, position) {
              return GestureDetector(
                onTap: () {
                  if (position == 2) {
                    Navigator.pushNamed(context, ProfilePage.routeName);
                  }
                },
                child: Column(
                  children: [
                    Image.asset(
                      menuList[position].icon,
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      menuList[position].title,
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              );
            }));
  }
}

class _MenuItem {
  final String icon;
  final String title;

  _MenuItem(this.icon, this.title);
}
