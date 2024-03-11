import 'package:flutter/material.dart';
import 'package:mobile_edukasi/login.dart';
import 'dart:async';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentImageIndex = 0;
  List<String> _imageList = [
    'images/SplashScreen.png',
    'images/SplashScreen2.png',
    'images/SplashScreen3.png',
  ];

  void _changeImage() {
    setState(() {
      if (_currentImageIndex < _imageList.length - 1) {
        _currentImageIndex++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _changeImage,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_imageList[_currentImageIndex]),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              "",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

