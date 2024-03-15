import 'package:flutter/material.dart';
import 'package:mobile_edukasi/models/model_pegawai.dart';

class EditDataPegawai extends StatelessWidget {
  final Datum? data;

  const EditDataPegawai(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerNama =
        TextEditingController(text: data?.namaPegawai);
    TextEditingController _controllerNoBP =
        TextEditingController(text: data?.noBp);
    TextEditingController _controllerNoHP =
        TextEditingController(text: data?.noHp);
    TextEditingController _controllerEmail =
        TextEditingController(text: data?.emailPegawai);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Data Pegawai',
          style: TextStyle(
            color: Colors.white,
          ), // Ubah warna teks menjadi putih
        ),
        backgroundColor: Colors.blue[900],
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
            SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () {
                // Mendapatkan nilai yang diubah dari setiap field
                String editedNama = _controllerNama.text;
                String editedNoBP = _controllerNoBP.text;
                String editedNoHP = _controllerNoHP.text;
                String editedEmail = _controllerEmail.text;

                // Implementasi logika penyuntingan data pegawai
                // Anda dapat menambahkan logika penyimpanan ke database atau tempat penyimpanan lainnya di sini
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue[900], // Warna teks putih
              ),
              child: Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
