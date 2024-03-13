// To parse this JSON data, do
//
//     final modelBerita = modelBeritaFromJson(jsonString);

import 'dart:convert';

ModelBerita modelBeritaFromJson(String str) => ModelBerita.fromJson(json.decode(str));

String modelBeritaToJson(ModelBerita data) => json.encode(data.toJson());

class ModelBerita {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelBerita({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelBerita.fromJson(Map<String, dynamic> json) => ModelBerita(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id_berita;
  String judul_berita;
  String konten_berita;
  String gambar_berita;


  Datum({
    required this.id_berita,
    required this.judul_berita,
    required this.konten_berita,
    required this.gambar_berita,
    
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id_berita: json["id_berita"],
    judul_berita: json["judul_berita"],
    konten_berita: json["konten_berita"],
    gambar_berita: json["gambar_berita"],
  );

  Map<String, dynamic> toJson() => {
    "id_berita": id_berita,
    "judul": judul_berita,
    "konten_berita": konten_berita,
    "gambar_berita": gambar_berita,
  };
}
