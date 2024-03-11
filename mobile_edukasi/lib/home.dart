import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/model_berita.dart';


class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<String> _contentData = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchContentData();
  }

  Future<void> _fetchContentData() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('http://192.168.43.102/edukasi/read.php?data=berita'));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _contentData = List<String>.from(data['content']);
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load content data');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    var _beritaList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Berita'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.blueGrey[100],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _beritaList.isNotEmpty ? _beritaList[_selectedIndex].judul_berita : 'No Data',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _beritaList.isNotEmpty ? _beritaList[_selectedIndex].konten_berita : 'No Data',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Image.network(
                      _beritaList.isNotEmpty ? _beritaList[_selectedIndex].gambar_berita : '',
                      height: 200,
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue[900], // Warna ikon yang dipilih
        unselectedItemColor: Colors.grey, // Warna ikon yang tidak dipilih
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Galeri',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Pegawai',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class Berita {
  final String judul_berita;
  final String konten_berita;
  final String gambar_berita;

  Berita({
    required this.judul_berita,
    required this.konten_berita,
    required this.gambar_berita,
  });

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      judul_berita: json['judul'] ?? '',
      konten_berita: json['konten'] ?? '',
      gambar_berita: json['gambar'] ?? '',
    );
  }
}