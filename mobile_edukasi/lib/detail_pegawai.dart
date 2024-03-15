import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mobile_edukasi/bottomNavBar.dart';
import 'package:mobile_edukasi/editPegawai.dart';
import 'package:mobile_edukasi/pegawai.dart';
import 'package:mobile_edukasi/utils/api_url.dart';
// import 'package:intl/intl.dart';
import 'models/model_pegawai.dart';
import 'package:http/http.dart' as http;


class PageDetailPegawai extends StatelessWidget {

  final Datum? data;
  const PageDetailPegawai(this.data, {Key? key}) : super(key: key);

  Future<void> _hapusDataPegawai(context) async {
    final String apiUrl = '${ApiUrl().baseUrl}pegawai.php'; // Ganti dengan URL backend Anda

    final response = await http.post(Uri.parse(apiUrl), body: {
      'id_pegawai': data?.idPegawai,
      'action' : "hapus",
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data pegawai berhasil dihapus')),
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigation("pegawai")),
              (route) => false
      );
    } else {
      // Jika permintaan gagal, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus data pegawai')),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data!.namaPegawai,
          style: TextStyle(
            color: Colors.white, // Warna putih
          ),
        ),
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.white, // Warna putih
            onPressed: () {
              // Navigasi ke layar pengeditan data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditDataPegawaiScreen("1",data),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.white, // Warna putih
            onPressed: () {
              var logger = Logger();
              logger.d("id Pegawai :: ${data?.idPegawai}");
              _hapusDataPegawai(context);
              // Implementasi logika untuk menghapus data pegawai
              // Misalnya, menampilkan dialog konfirmasi penghapusan
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    'Nama Pegawai : ${data?.namaPegawai ?? ""}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  key: Key('nama_pegawai'),
                ),
                ListTile(
                  title: Text(
                    'No bp : ${data?.noBp ?? ""}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  key: Key('no_bp'),
                ),
                ListTile(
                  title: Text(
                    'No hp : ${data?.noHp ?? ""}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  key: Key('no_hp'),
                ),
                ListTile(
                  title: Text(
                    'Email : ${data?.emailPegawai ?? ""}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  key: Key('email'),
                ),
                ListTile(
                  title: Text(
                    'Created at : ${data?.created_date ?? ""}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  key: Key('created_date'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
