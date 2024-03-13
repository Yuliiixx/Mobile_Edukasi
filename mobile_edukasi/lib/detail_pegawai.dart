import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'models/model_pegawai.dart';


class PageDetailPegawai extends StatelessWidget {
  final Datum? data;

  const PageDetailPegawai(this.data, {super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data!.namaPegawai),
        backgroundColor: Colors.blue,
      ),

      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              // child: Image.network(
              //   'http://192.168.43.102/edukasi/gambar/${data?.gambarBerita}',
              //   fit: BoxFit.fill,
              // ),
            ),
          ),

          ListTile(
            title: Text(data?.namaPegawai ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
           
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: 
            Text(
              data?.noBp ?? "",
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
