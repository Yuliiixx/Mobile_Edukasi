import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_edukasi/bottomNavBar.dart';
import 'package:mobile_edukasi/utils/api_url.dart';

class TambahDataPegawai extends StatefulWidget {
  @override
  _TambahDataPegawaiState createState() => _TambahDataPegawaiState();
}

class _TambahDataPegawaiState extends State<TambahDataPegawai> {
  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerNoBP = TextEditingController();
  TextEditingController _controllerNoHP = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

  Future<void> _tambahDataPegawai() async {
    final String apiUrl = '${ApiUrl().baseUrl}pegawai.php'; // Ganti dengan URL backend Anda

    final response = await http.post(Uri.parse(apiUrl), body: {
      'action' : "tambah",
      'nama': _controllerNama.text,
      'no_bp': _controllerNoBP.text,
      'no_hp': _controllerNoHP.text,
      'email': _controllerEmail.text,
    });

    if (response.statusCode == 200) {
      // Jika permintaan berhasil, bersihkan input dan tampilkan pesan sukses
      _controllerNama.clear();
      _controllerNoBP.clear();
      _controllerNoHP.clear();
      _controllerEmail.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data pegawai berhasil ditambahkan')),
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigation("pegawai")),
              (route) => false
      );

    } else {
      // Jika permintaan gagal, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan data pegawai')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Data Pegawai',
          style: TextStyle(
            color: Colors.white,
          ), // Ubah warna teks menjadi putih
        ),
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controllerNama,
              decoration: InputDecoration(labelText: 'Nama Pegawai'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _controllerNoBP,
              decoration: InputDecoration(labelText: 'Nomor BP'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _controllerNoHP,
              decoration: InputDecoration(labelText: 'Nomor HP'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _controllerEmail,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 5.0),
            ElevatedButton(
              onPressed: _tambahDataPegawai,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue[900],
              ),
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
