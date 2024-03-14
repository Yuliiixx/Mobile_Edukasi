import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'models/model_pegawai.dart';

class PageDetailPegawai extends StatelessWidget {
  final Datum? data;

  const PageDetailPegawai(this.data, {Key? key}) : super(key: key);

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
