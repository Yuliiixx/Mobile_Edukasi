import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:mobile_edukasi/detail_berita.dart';
import 'package:mobile_edukasi/bottomNavBar.dart';
import 'models/model_berita.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var logger = Logger();

  String? userName;

  Future<List<Datum>?> getBerita() async {
    try {
      http.Response res = await http
          .get(Uri.parse('http://192.168.43.102/edukasi/read.php?data=berita')
              // , headers: {'Access-Control-Allow-Origin': '*',}
              );
      logger.d("data di dapat :: ${modelBeritaFromJson(res.body).data}");
      return modelBeritaFromJson(res.body).data;
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  //untuk mendapatkan data sesi
  // Future getDataSession() async{
  //   await Future.delayed(const Duration(seconds: 5),(){
  //     sessionManager.getSession().then((value) {
  //       print('data sesi :' + value.toString());
  //       // userName = value.toString();
  //       userName = sessionManager.userName;
  //     });
  //   });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   sessionManager.getSession();
  //   print(sessionManager.getSession());
  //   getDataSession();

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berita'),
        backgroundColor: Colors.cyan,
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder(
            future: getBerita(),
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
                                      PageDetailBerita(data)));
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    'http://192.168.43.102/edukasi/gambar/${data?.gambarBerita}',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "${data?.judulBerita}",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "${data?.kontenBerita}",
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
