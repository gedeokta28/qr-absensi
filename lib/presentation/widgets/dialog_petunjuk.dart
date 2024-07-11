import 'package:flutter/material.dart';

class DialogPetunjuk extends StatelessWidget {
  const DialogPetunjuk({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity, // Set the width here
        padding: EdgeInsets.symmetric(
            vertical: 20, horizontal: 15), // Optional: Add padding if needed
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Panduan',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Aplikasi ini terdapat beberapa pilihan untuk melakukan action yang mempunyai fungsi masing-masing: ',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 15,
                  child: Text(
                    "1.",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.0,
                ),
                Text(
                  'Kamus Istilah',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            Row(
              children: [
                Container(
                  width: 15,
                  child: Text(
                    "",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.0,
                ),
                Expanded(
                  child: Text(
                    'Pada menu ini anda dapat melihat nama-nama dalam Istilah IT lengkap dengan deskripsi.',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 15,
                  child: Text(
                    "2.",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.0,
                ),
                Text(
                  'Panduan',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            Row(
              children: [
                Container(
                  width: 15,
                  child: Text(
                    "",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.0,
                ),
                Expanded(
                  child: Text(
                    'Pada menu ini anda dapat melihat panduan dalam menggunakan aplikasi ini.',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 15,
                  child: Text(
                    "3.",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.0,
                ),
                Text(
                  'Tentang',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            Row(
              children: [
                Container(
                  width: 15,
                  child: Text(
                    "",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.0,
                ),
                Expanded(
                  child: Text(
                    'Pada menu ini berisi informasi tentang pengembang aplikasi ini.',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
