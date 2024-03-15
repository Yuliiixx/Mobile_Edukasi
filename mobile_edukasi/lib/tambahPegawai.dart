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
  final _formKey = GlobalKey<FormState>();

  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerNoBP = TextEditingController();
  TextEditingController _controllerNoHP = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

  Future<void> _tambahDataPegawai() async {
    if (_formKey.currentState!.validate()) {
      final String apiUrl = '${ApiUrl().baseUrl}pegawai.php'; // Ganti dengan URL backend Anda

      final response = await http.post(Uri.parse(apiUrl), body: {
        'action': "tambah",
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _controllerNama,
                decoration: InputDecoration(labelText: 'Nama Pegawai'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama pegawai tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _controllerNoBP,
                decoration: InputDecoration(labelText: 'Nomor BP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor BP tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _controllerNoHP,
                decoration: InputDecoration(labelText: 'Nomor HP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor HP tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _controllerEmail,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  // Validasi email dengan regex sederhana
                  if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(value)) {
                    return 'Masukkan email yang valid';
                  }
                  return null;
                },
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
      ),
    );
  }
}
