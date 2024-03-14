

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mobile_edukasi/bottomNavBar.dart';
import 'package:mobile_edukasi/home.dart';
import 'package:mobile_edukasi/models/model_login.dart';
import 'package:mobile_edukasi/register.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_edukasi/utils/sesion_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => __LoginPageState();
}

class __LoginPageState extends State<LoginPage>{

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   sessionManager.getSession();
  //   logger.d(sessionManager.value);
  // }
  var logger = Logger();
  TextEditingController txtUsername = TextEditingController();
  Future<ModelLogin?> login() async {
    logger.d(txtPassword.text);
    try{
      isLoading = true;
      // http.Response res = await http.post(Uri.parse('http://192.30.35.126/edukasi/auth.php'),
       http.Response res = await http.post(Uri.parse('http://192.168.43.102/edukasi/auth.php'),
        body: {
          "login"     : "1",
          "username"  : txtUsername.text,
          "password"  : txtPassword.text,
        });

      ModelLogin data = modelLoginFromJson(res.body);
      logger.d("data :: ${data.pesan}");

      if(data.sukses){
        setState(() {
          isLoading=false;

          sessionManager.saveSession(
              data.sukses,
              data.data.idUser,
              data.data.username,
              data.data.namaUser,
              data.data.alamatUser,
              data.data.nohpUser
          );
          sessionManager.getSession();
          sessionManager.getSession().then((value) {
            logger.d("nama :: ${sessionManager.userName}");
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${data.pesan}')));
          Navigator.pushAndRemoveUntil(
              context,
                MaterialPageRoute(builder: (context) => BottomNavigation()),
              (route) => false
          );
        });

      }else{
        setState(() {
          isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${data.pesan}')));
      }
    }catch(e){
      setState(() {
        isLoading=false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('eror : ${e.toString()}')));
    }
  }
  TextEditingController txtPassword = TextEditingController();


  // GlobalKey<FormState> keyForm =
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Image.asset(
              'images/logo.png', // Ganti dengan path gambar logo Anda
              height: 150,
              width: 150,
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: txtUsername,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                obscureText: true,
                controller: txtPassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
                child: isLoading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )

                : MaterialButton(
                  minWidth: 150,
                  height: 45,
                  onPressed: () {
                    logger.d("data");

                    // Tambahkan logika untuk login di sini
                    // Tambahkan navigasi untuk halaman home di sini
                    login();
                  },
                  color: Colors.blue[900],
                  child: Text('Login', style: TextStyle(color: Colors.white)),
                ),
            ),
            GestureDetector(
              onTap: () {
                // Tambahkan navigasi untuk halaman pendaftaran di sini
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text(
                'Belum punya akun? Silahkan daftar',
                style: TextStyle(
                  color: Colors.blue[900],
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
