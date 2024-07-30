import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_absensi/presentation/pages/login_page.dart';
import 'package:qr_absensi/presentation/providers/home_provider.dart';
import 'package:qr_absensi/presentation/widgets/custom_dialog_logout.dart';
import 'package:qr_absensi/static/colors.dart';
import 'package:qr_absensi/utility/helper.dart';
import 'package:qr_absensi/utility/injection.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomePageDosen extends StatefulWidget {
  const HomePageDosen({super.key});
  static const routeName = '/home-dosen';

  @override
  State<HomePageDosen> createState() => _HomePageDosenState();
}

class _HomePageDosenState extends State<HomePageDosen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

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
          if (result != null) {
            // controller!.dispose();
            // provider.doLoginApi().listen((state) async {
            //   switch (state.runtimeType) {
            //     case LoginFailure:
            //       showDialog(
            //         context: context,
            //         builder: (_) => CustomSimpleDialog(
            //           onTap: () {
            //             Navigator.pop(context);
            //           },
            //           text: 'Pastikan Username dan Password Benar !',
            //           color: Colors.black,
            //         ),
            //       );
            //       break;
            //     case LoginSuccess:
            //       Navigator.of(context).pushNamedAndRemoveUntil(
            //           SuksesAbsensiPage.routeName,
            //           (Route<dynamic> route) => false);
            //       break;
            //   }
            // });
          }
          return Column(
            children: <Widget>[
              Expanded(flex: 3, child: _buildQrView(context)),
              Expanded(
                flex: 1,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 38),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                              onPressed: () async {
                                await controller?.toggleFlash();
                                setState(() {});
                              },
                              icon: FutureBuilder(
                                future: controller?.getFlashStatus(),
                                builder: (context, snapshot) {
                                  if (snapshot.data == null) {
                                    return Icon(
                                      Icons.flash_off,
                                      size: 35,
                                      color: primaryColor,
                                    );
                                  } else if (snapshot.data!) {
                                    return Icon(
                                      size: 35,
                                      Icons.flash_on,
                                      color: primaryColor,
                                    );
                                  } else {
                                    return Icon(
                                      size: 35,
                                      Icons.flash_off,
                                      color: primaryColor,
                                    );
                                  }
                                },
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          IconButton(
                              onPressed: () async {
                                await controller?.flipCamera();
                                setState(() {});
                              },
                              icon: FutureBuilder(
                                future: controller?.getCameraInfo(),
                                builder: (context, snapshot) {
                                  if (snapshot.data == null) {
                                    return Container();
                                  } else {
                                    return Icon(
                                      size: 35,
                                      Icons.flip_camera_ios_outlined,
                                      color: primaryColor,
                                    );
                                  }
                                },
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      child: Text(
                        'SILAHKAN MELAKUKAN SCAN QR CODE\nDARI DOSEN UNTUK ABSENSI',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
