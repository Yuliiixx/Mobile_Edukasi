
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_edukasi/login.dart';
import 'package:mobile_edukasi/home.dart';
import 'models/model_base.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  TextEditingController txtNama = TextEditingController();
  TextEditingController txtAlamat = TextEditingController();
  TextEditingController txtNoTelpon = TextEditingController();
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  bool isLoading = false;
  Future<ModelBase?> register() async{
    try{
      isLoading = true;
      // http.Response res = await http.post(Uri.parse('http://192.30.35.126/edukasi/auth.php'),
      http.Response res = await http.post(Uri.parse('http://192.168.1.75/edukasi/uth.php'),
        body: {
          "tambah_user":"1",
          "username":txtUsername.text,
          "password":txtPassword.text,
          "nama_user":txtNama.text,
          "alamat_user":txtAlamat.text,
          "nohp_user":txtNoTelpon.text
        });
      ModelBase data = modelBaseFromJson(res.body);
      if(data.sukses){
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data.pesan)));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context)=>LoginPage()),
                (route) => false);
      }else{
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data.pesan)));
      }
    }catch(e){
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

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
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: txtNama,
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: txtAlamat,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: txtNoTelpon,
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
            SizedBox(height: 20),
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
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk pendaftaran di sini
                register();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900], // Ubah warna tombol di sini
              ),
              child: Text('Register', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // Tambahkan navigasi untuk halaman login di sini
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text(
                'Sudah punya akun? Silahkan login',
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
