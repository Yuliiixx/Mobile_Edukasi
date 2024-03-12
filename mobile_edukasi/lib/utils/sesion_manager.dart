import 'package:shared_preferences/shared_preferences.dart';

class SessionManager{
  int? value;
  String? idUser;
  String? userName;
  String? fullname;
  String? alamat;
  String? nohp;

  //simpan sesi
  Future<void> saveSession(int val, String id, String userName, String fullName, String alamat, String nohp) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("value", val);
    pref.setString("id", id);
    pref.setString("username", userName);
    pref.setString("fullname", fullName);
    pref.setString("alamat", alamat);
    pref.setString("nohp", nohp);
  }

  Future getSession() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    value = pref.getInt("value");
    idUser = pref.getString("id");
    userName = pref.getString("username");
    fullname = pref.getString("fullname");
    alamat =  pref.getString("alamat");
    nohp = pref.getString("nohp");
  }
  //remove --> logout
  Future clearSession() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

}

//instance class biar d panggil
SessionManager sessionManager = SessionManager();