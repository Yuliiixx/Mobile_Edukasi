import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:mobile_edukasi/detail_pegawai.dart';
import 'package:mobile_edukasi/bottomNavBar.dart';
import 'models/model_pegawai.dart';

class PegawaiPage extends StatefulWidget {
  const PegawaiPage({super.key});

  @override
  State<PegawaiPage> createState() => _PegawaiPageState();
}

class _PegawaiPageState extends State<PegawaiPage> {
  var logger = Logger();

  String? userName;

  Future<List<Datum>?> getPegawai() async {
    try {
      http.Response res = await http
          .get(Uri.parse('http://192.30.35.126/edukasi/read.php?data=pegawai')
              // , headers: {'Access-Control-Allow-Origin': '*',}
              );
      logger.d("data di dapat :: ${modelPegawaiFromJson(res.body).data}");
      return modelPegawaiFromJson(res.body).data;
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pegawai'),
        backgroundColor: Colors.blue,
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder(
            future: getPegawai(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
              logger.d("hash data :: ${snapshot.hasData}");
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    Datum? data = snapshot.data?[index];
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PageDetailPegawai(data)));
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  // child: Image.network(
                                  //   'http://192.30.35.126/edukasi/gambar/${data?.gambarBerita}',
                                  //   fit: BoxFit.fill,
                                  // ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "${data?.namaPegawai}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "${data?.noBp}",
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black54),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
