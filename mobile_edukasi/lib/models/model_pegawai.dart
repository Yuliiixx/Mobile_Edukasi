import 'dart:convert';

ModelPegawai modelPegawaiFromJson(String str) => ModelPegawai.fromJson(json.decode(str));

String modelPegawaiToJson(ModelPegawai data) => json.encode(data.toJson());

class ModelPegawai {
  bool sukses;
  int status;
  String pesan;
  List<Datum> data;

  ModelPegawai({
    required this.sukses,
    required this.status,
    required this.pesan,
    required this.data,
  });

  factory ModelPegawai.fromJson(Map<String, dynamic> json) => ModelPegawai(
    sukses: json["sukses"],
    status: json["status"],
    pesan: json["pesan"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sukses": sukses,
    "status": status,
    "pesan": pesan,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String idPegawai;
  String namaPegawai;
  String noBp;
  String noHp;
  String emailPegawai;
  DateTime created_date;

  Datum({
    required this.idPegawai,
    required this.namaPegawai,
    required this.noBp,
    required this.noHp,
    required this.emailPegawai,
    required this.created_date,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idPegawai: json["id_pegawai"],
    namaPegawai: json["nama"],
    noBp: json["no_bp"],
    noHp: json["no_hp"],
    emailPegawai: json["email"],
    created_date: DateTime.parse(json["created_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id_pegawai": idPegawai,
    "nama": namaPegawai,
    "no_bp": noBp,
    "no_hp": noHp,
    "email": emailPegawai,
    "created_date": created_date.toIso8601String(),
  };
}