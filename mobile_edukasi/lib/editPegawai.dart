import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_edukasi/models/model_pegawai.dart';
import 'models/model_base.dart';
import 'package:mobile_edukasi/utils/api_url.dart';

class EditDataPegawaiScreen extends StatefulWidget {
  final String id;

  const EditDataPegawaiScreen(Datum? data, {Key? key, required this.id}) : super(key: key);

  @override
  _EditDataPegawaiScreenState createState() => _EditDataPegawaiScreenState();
}

class _EditDataPegawaiScreenState extends State<EditDataPegawaiScreen> {
  TextEditingController namaController = TextEditingController();
  TextEditingController noBpController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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
                updateDataPegawai().then((response) {
                  if (response.sukses) {
                    // Handle success
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(response.pesan)),
                    );
                  } else {
                    // Handle error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(response.pesan)),
                    );
                  }
                }).catchError((error) {
                  // Handle error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update data')),
                  );
                });
              },
              child: Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}

