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
  late TextEditingController _searchController;
  late Future<List<Datum>?> _futureBerita;
  List<Datum>? _searchResult;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _futureBerita = getBerita();
    _searchController.addListener(() {
      searchBerita(_searchController.text);
    });
  }

  Future<List<Datum>?> getBerita() async {
    try {
      http.Response res = await http
          .get(Uri.parse('http://192.30.35.126/edukasi/read.php?data=berita'));
      logger.d("data di dapat :: ${modelBeritaFromJson(res.body).data}");
      return modelBeritaFromJson(res.body).data;
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  Future<void> searchBerita(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResult = null;
      });
      return;
    }
    List<Datum>? berita = await getBerita();
    if (berita != null) {
      List<Datum> result = berita
          .where((datum) =>
              datum.judulBerita!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        _searchResult = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Berita',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari berita...',
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          searchBerita('');
                        },
                      )
                    : null,
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _futureBerita,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Datum>?> snapshot) {
                  logger.d("hash data :: ${snapshot.hasData}");
                  if (snapshot.hasData || _searchResult != null) {
                    final data = _searchResult ?? snapshot.data;
                    return ListView.builder(
                      itemCount: data?.length,
                      itemBuilder: (context, index) {
                        Datum? dataItem = data?[index];
                        return Padding(
                          padding: EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PageDetailBerita(dataItem),
                                ),
                              );
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
                                        'http://192.30.35.126/edukasi/gambar/${dataItem?.gambarBerita}',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      "${dataItem?.judulBerita}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${dataItem?.kontenBerita}",
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
