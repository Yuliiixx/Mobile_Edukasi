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
//           .get(Uri.parse('http://192.168.43.102/edukasi/read.php?data=galeri')
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
//                                     'http://192.168.43.102/edukasi/gambar/${data?.foto}',
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
