import 'package:flutter/material.dart';

class TambahDataPegawai extends StatefulWidget {
  @override
  _TambahDataPegawaiState createState() => _TambahDataPegawaiState();
}

class _TambahDataPegawaiState extends State<TambahDataPegawai> {
  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerNoBP = TextEditingController();
  TextEditingController _controllerNoHP = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

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
              onPressed: () {
                // Aksi untuk menyimpan data, misalnya menyimpan ke database atau melakukan tindakan lainnya
                String nama = _controllerNama.text;
                String noBP = _controllerNoBP.text;
                String noHP = _controllerNoHP.text;
                String email = _controllerEmail.text;

                // Di sini Anda dapat menambahkan logika untuk menyimpan data
                print('Nama: $nama');
                print('Nomor BP: $noBP');
                print('Nomor HP: $noHP');
                print('Email: $email');

                // Bersihkan input setelah menyimpan data
                _controllerNama.clear();
                _controllerNoBP.clear();
                _controllerNoHP.clear();
                _controllerEmail.clear();

                // Beritahu pengguna bahwa data telah ditambahkan
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Data pegawai berhasil ditambahkan')),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue[900], // Mengatur warna teks menjadi putih
              ),
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
