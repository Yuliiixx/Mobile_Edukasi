// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:logger/logger.dart';
// import 'models/model_galeri.dart';



// class GaleriPage extends StatefulWidget {
//   const GaleriPage({super.key});

//   @override
//   State<GaleriPage> createState() => _GaleriPageState();
// }

// class _GaleriPageState extends State<GaleriPage> {
//   var logger = Logger();

//   String? userName;

//   Future<List<Datum>?> getGaleri() async {
//     try {
//       http.Response res = await http
//           .get(Uri.parse('http://192.30.35.126/edukasi/read.php?data=galeri')
//               // , headers: {'Access-Control-Allow-Origin': '*',}
//               );
//       logger.d("data di dapat :: ${modelGaleriFromJson(res.body).data}");
//       return modelGaleriFromJson(res.body).data;
//     } catch (e) {
//       setState(() {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text(e.toString())));
//       });
//     }
//   }

 

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Galeri'),
//         backgroundColor: Colors.blue[900],
        
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           child: FutureBuilder(
//             future: getGaleri(),
//             builder:
//                 (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
//               logger.d("hash data :: ${snapshot.hasData}");
//               if (snapshot.hasData) {
//                 return ListView.builder(
//                   itemCount: snapshot.data?.length,
//                   itemBuilder: (context, index) {
//                     Datum? data = snapshot.data?[index];
//                     return Padding(
//                       padding: EdgeInsets.all(8),
//                       child: GestureDetector(
                        
//                         child: Card(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.all(8),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: Image.network(
//                                     'http://192.30.35.126/edukasi/gambar/${data?.foto}',
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                               ),
                              
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Text(snapshot.error.toString()),
//                 );
//               } else {
//                 return const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.orange,
//                   ),
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_edukasi/models/model_galeri.dart';
import 'package:mobile_edukasi/utils/api_url.dart'; // Sesuaikan dengan lokasi file model_galeri.dart

class GaleriPage extends StatefulWidget {
  @override
  _GaleriPageState createState() => _GaleriPageState();
}

class _GaleriPageState extends State<GaleriPage> {
  Future<List<Datum>?> getGaleri() async {
    // Endpoint API galeri
    String apiUrl = '${ApiUrl().baseUrl}read.php?data=galeri'; // Ganti dengan URL API yang sesuai
    
    try {
      // Melakukan request HTTP GET ke API
      final response = await http.get(Uri.parse(apiUrl));
      
      // Cek status kode response
      if (response.statusCode == 200) {
        // Parsing data JSON ke dalam objek ModelGaleri menggunakan modelGaleriFromJson
        List<Datum> galeriList = modelGaleriFromJson(response.body).data;
        
        // Mengembalikan data galeri
        return galeriList;
      } else {
        // Jika request gagal, lempar sebuah Exception
        throw Exception('Failed to load galeri');
      }
    } catch (e) {
      // Tangani jika terjadi error
      print('Error: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Galery',
          style:
              TextStyle(color: Colors.white), // Ubah warna teks menjadi putih
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: FutureBuilder<List<Datum>?>(
        future: getGaleri(),
        builder: (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
          // Tampilkan indikator loading jika future belum selesai
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          
          // Tampilkan pesan jika terjadi error
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          
          // Tampilkan data galeri jika future selesai
          if (snapshot.hasData && snapshot.data != null) {
            List<Datum> galeri = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: galeri.length,
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  '${ApiUrl().baseUrl}gambar/${galeri[index].foto}',
                  fit: BoxFit.cover,
                );
              },
            );
          }
          
          // Tampilkan pesan jika tidak ada data galeri
          return Center(child: Text('No data available'));
        },
      ),
    );
  }
}
