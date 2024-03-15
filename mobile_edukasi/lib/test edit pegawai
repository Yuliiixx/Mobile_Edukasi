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

  Future<void> _editDataPegawai() async {
    final String apiUrl = '${ApiUrl().baseUrl}pegawai.php'; // Ganti dengan URL backend Anda

    final response = await http.post(Uri.parse(apiUrl), body: {
      'id_pegawai' : idPegawai,
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
  Future<ModelBase> updateDataPegawai() async {
    final response = await http.put(
      Uri.parse('${ApiUrl().baseUrl}pegawai.php/${widget.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nama': namaController.text,
        'no_bp': noBpController.text,
        'no_hp': noHpController.text,
        'email': emailController.text,
      }),
    );

    if (response.statusCode == 200) {
      return ModelBase.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update data');
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama Pegawai'),
            ),
            TextField(
              controller: noBpController,
              decoration: InputDecoration(labelText: 'Nomor BP'),
            ),
            TextField(
              controller: noHpController,
              decoration: InputDecoration(labelText: 'Nomor HP'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _editDataPegawai();
              },
              child: Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}

