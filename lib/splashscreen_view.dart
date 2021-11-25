import 'dart:async';
import 'package:flutter/material.dart';
import 'package:healthy_care/input_page.dart';
class SplashScreenPage extends StatefulWidget {
 
  const SplashScreenPage({ Key key, }) : super(key: key);
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}
class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    openSplashScreen();
  }
  openSplashScreen() async {
    var durasiSplash = const Duration(seconds: 4);
    return Timer(durasiSplash, () {
     
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return InputPage();
        })
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child: Image.asset(
          "assets/loogo.jpg",
          width: 2000,
          height: 2000,
        ),
      ),
    );
  }
}