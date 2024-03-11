import 'package:flutter/material.dart';
import 'package:mobile_edukasi/home.dart';
import 'package:mobile_edukasi/register.dart';

class LoginPage extends StatelessWidget {
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
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk login di sini
                // Tambahkan navigasi untuk halaman home di sini
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900], // Ubah warna tombol di sini
              ),
              child: Text('Login', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 10),
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
