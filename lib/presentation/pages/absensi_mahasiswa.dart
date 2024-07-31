import 'package:flutter/material.dart';
import 'package:qr_absensi/data/models/absensi_list_response_model.dart';
import 'package:qr_absensi/static/colors.dart';
import 'package:qr_absensi/utility/helper.dart';
import 'package:qr_absensi/utility/injection.dart';

import '../../utility/session_helper.dart';

class AbsensiMahasiswa extends StatefulWidget {
  static const routeName = '/absensi-mahasiswa';
  final List<AbsensiListItem> absensiList;
  const AbsensiMahasiswa({super.key, required this.absensiList});

  @override
  State<AbsensiMahasiswa> createState() => _AbsensiMahasiswaState();
}

class _AbsensiMahasiswaState extends State<AbsensiMahasiswa>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<String> subjects;

  @override
  void initState() {
    super.initState();
    subjects = fetchSubjects(widget.absensiList);
    _tabController = TabController(length: subjects.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'ABSENSI',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: subjects.map((subject) => Tab(text: subject)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: subjects.map((subject) {
          final session = locator<Session>();

          if (session.sessionRole == 'siswa') {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 0, left: 15),
                  child: Text(
                    subject,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: AttendancePage(
                    subject: subject,
                    absensiList: widget.absensiList,
                  ),
                ),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 0, left: 15),
                  child: Text(
                    subject,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: AttendanceDosenPage(
                    subject: subject,
                    absensiList: widget.absensiList,
                  ),
                ),
              ],
            );
          }
        }).toList(),
      ),
    );
  }
}

class AttendancePage extends StatelessWidget {
  final String subject;
  final List<AbsensiListItem> absensiList;

  AttendancePage({required this.subject, required this.absensiList});

  @override
  Widget build(BuildContext context) {
    List<AbsensiListItem> attendanceList =
        absensiList.where((a) => a.matakuliah == subject).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        itemCount: attendanceList.length,
        itemBuilder: (context, index) {
          final attendance = attendanceList[index];
          Color bgColor;
          String attendanceText;

          switch (int.parse(attendance.idKehadiran)) {
            case 1:
              bgColor = Colors.green;
              attendanceText = 'Hadir';
              break;
            case 2:
              bgColor = Colors.orange;
              attendanceText = 'Sakit';
              break;
            case 3:
              bgColor = Colors.blue;
              attendanceText = 'Izin';
              break;
            case 4:
              bgColor = Colors.red;
              attendanceText = 'Tanpa keterangan';
              break;
            case 5:
            default:
              bgColor = Colors.grey;
              attendanceText = 'Belum tersedia';
              break;
          }
          return ListTile(
            title: Row(
              children: [
                Flexible(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 3),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      attendanceText,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Text('Tgl: ${formatDate(attendance.tanggal)}'),
                const SizedBox(
                  height: 2,
                ),
                Text('Jam masuk: ${formatTime(attendance.jamMasuk)}'),
                Divider()
              ],
            ),
          );
        },
      ),
    );
  }
}

class AttendanceDosenPage extends StatelessWidget {
  final String subject;
  final List<AbsensiListItem> absensiList;

  AttendanceDosenPage({required this.subject, required this.absensiList});

  @override
  Widget build(BuildContext context) {
    List<AbsensiListItem> attendanceList =
        absensiList.where((a) => a.matakuliah == subject).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        itemCount: attendanceList.length,
        itemBuilder: (context, index) {
          final attendance = attendanceList[index];
          Color bgColor;
          String attendanceText;

          switch (int.parse(attendance.idKehadiran)) {
            case 1:
              bgColor = Colors.green;
              attendanceText = 'Hadir';
              break;
            case 2:
              bgColor = Colors.orange;
              attendanceText = 'Sakit';
              break;
            case 3:
              bgColor = Colors.blue;
              attendanceText = 'Izin';
              break;
            case 4:
              bgColor = Colors.red;
              attendanceText = 'Tanpa keterangan';
              break;
            case 5:
            default:
              bgColor = Colors.grey;
              attendanceText = 'Belum tersedia';
              break;
          }
          return ListTile(
            title: Row(
              children: [
                Flexible(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 3),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      attendanceText,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(attendance.nama),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(attendance.nim),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text('${formatDate(attendance.tanggal)}'),
                        const SizedBox(
                          height: 2,
                        ),
                        Text('${formatTime(attendance.jamMasuk)}'),
                      ],
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
