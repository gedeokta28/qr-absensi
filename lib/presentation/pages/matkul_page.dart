import 'package:flutter/material.dart';
import 'package:qr_absensi/data/models/matkul_response_model.dart';
import 'package:qr_absensi/presentation/pages/absen_page.dart';
import 'package:qr_absensi/presentation/widgets/custom_search_bar.dart';
import 'package:qr_absensi/static/colors.dart';

class MatkulPage extends StatefulWidget {
  static const routeName = '/matkul';
  final List<MataKuliahItem> listMatkul;
  const MatkulPage({super.key, required this.listMatkul});

  @override
  State<MatkulPage> createState() => _MatkulPageState();
}

class _MatkulPageState extends State<MatkulPage> {
  List<MataKuliahItem> _matkulList = [];
  List<MataKuliahItem> _foundMatkul = [];
  @override
  initState() {
    _matkulList = widget.listMatkul;
    _foundMatkul = _matkulList;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<MataKuliahItem> results = [];
    if (enteredKeyword.isEmpty) {
      results = _matkulList;
    } else {
      results = _matkulList
          .where((data) => data.namaMataKuliah
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundMatkul = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.2,
        centerTitle: true,
        title: Text(
          'Daftar Mata Kuliah',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            CustomSearchBar(
              hint: 'Cari Mata Kuliah..',
              enabled: true,
              onChanged: (value) => _runFilter(value),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundMatkul.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: _foundMatkul.length,
                      itemBuilder: (context, index) => InkWell(
                        key: ValueKey(_foundMatkul[index].idMataKuliah),
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          Navigator.pushNamed(context, AbsenPage.routeName,
                              arguments: _foundMatkul[index].idMataKuliah);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                _foundMatkul[index].namaMataKuliah,
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const Text(
                      'Mata Kuliah tidak ditemukan',
                      style: TextStyle(fontSize: 13),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
