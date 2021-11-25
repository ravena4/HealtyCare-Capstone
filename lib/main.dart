import 'package:flutter/material.dart';
import 'package:healthy_care/splashscreen_view.dart';
import 'input_page.dart';

void main() => runApp(healthy_care());

class healthy_care extends StatelessWidget {
const healthy_care({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: SplashScreenPage(),
    );
  }
}
