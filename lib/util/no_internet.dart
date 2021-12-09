import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 19.0,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "You are not connected to the Internet, Please turn on your mobile data or WiFi",
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
