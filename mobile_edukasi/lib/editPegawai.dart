import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_edukasi/bottomNavBar.dart';
import 'package:mobile_edukasi/models/model_pegawai.dart';
import 'models/model_base.dart';
import 'package:mobile_edukasi/utils/api_url.dart';

class EditDataPegawaiScreen extends StatefulWidget {
  final String id;
  final Datum? data;
  const EditDataPegawaiScreen(this.id, this.data, {Key? key}) : super(key: key);
  @override
  _EditDataPegawaiScreenState createState() => _EditDataPegawaiScreenState();
}

class _EditDataPegawaiScreenState extends State<EditDataPegawaiScreen> {
  String idPegawai = "";
  TextEditingController namaController = TextEditingController();
  TextEditingController noBpController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // GlobalKey untuk Form

  Future<void> _editDataPegawai() async {
    // Pemeriksaan validitas Form
    if (_formKey.currentState!.validate()) {
      final String apiUrl = '${ApiUrl().baseUrl}pegawai.php'; // Ganti dengan URL backend Anda
      final response = await http.post(Uri.parse(apiUrl), body: {
        'id_pegawai': idPegawai,
        'nama': namaController.text,
        'no_bp': noBpController.text,
        'no_hp': noHpController.text,
        'email': emailController.text,
        'action': 'edit',
      });

      if (response.statusCode == 200) {
        // Jika permintaan berhasil, bersihkan input dan tampilkan pesan sukses
        namaController.clear();
        noBpController.clear();
        noHpController.clear();
        emailController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data pegawai berhasil diupdate')),
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
  void initState() {
    super.initState();
    // Memeriksa apakah data tidak null
    if (widget.data != null) {
      idPegawai = widget.data!.idPegawai;
      // Mengisi nilai awal dari TextEditingController dengan data dari objek Datum
      namaController.text = widget.data!.namaPegawai ?? "";
      noBpController.text = widget.data!.noBp ?? "";
      noHpController.text = widget.data!.noHp ?? "";
      emailController.text = widget.data!.emailPegawai ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data Pegawai'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form( // Wrap Column dengan Form
          key: _formKey, // Assign GlobalKey<Form>
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField( // Menggunakan TextFormField untuk validasi
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama Pegawai'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama pegawai tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: noBpController,
                decoration: InputDecoration(labelText: 'Nomor BP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor BP tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: noHpController,
                decoration: InputDecoration(labelText: 'Nomor HP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor HP tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  // Anda juga dapat menambahkan validasi email jika diinginkan
                  // Contoh validasi email:
                  // if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  //   return 'Email tidak valid';
                  // }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () {
              //     _editDataPegawai();
                  
              //   },
              //   child: Text('Simpan Perubahan'),
              // ),
              ElevatedButton(
                onPressed: _editDataPegawai,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue[900],
                ),
                child: Text('Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
