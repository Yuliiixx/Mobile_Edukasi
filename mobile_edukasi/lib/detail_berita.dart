import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'models/model_berita.dart';


class PageDetailBerita extends StatelessWidget {
  final Datum? data;

  const PageDetailBerita(this.data, {super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data!.judul_berita),
        backgroundColor: Colors.cyan,
      ),

      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'http://192.168.43.102/edukasi/gambar/${data?.gambar_berita}',
                fit: BoxFit.fill,
              ),
            ),
          ),

          ListTile(
            title: Text(data?.judul_berita ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
           
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              data?.konten_berita ?? "",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }
}
