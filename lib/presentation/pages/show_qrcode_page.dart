import 'package:flutter/material.dart';
import 'package:qr_absensi/static/colors.dart';

class ShowQRcodePage extends StatefulWidget {
  static const routeName = '/show-qr';
  final String urlQrCode;
  const ShowQRcodePage({super.key, required this.urlQrCode});

  @override
  State<ShowQRcodePage> createState() => _ShowQRcodePageState();
}

class _ShowQRcodePageState extends State<ShowQRcodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.2,
        centerTitle: true,
        title: Text(
          'QR-Code',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
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
            child: Image.network(
              widget.urlQrCode,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child; // The image is fully loaded.
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
