import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:healthy_care/screens/foods/list_screen.dart';
import 'package:healthy_care/util/no_internet.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

  bool _connection ;
  ConnectivityResult _connectionStatus;
  Future _futureConnection;

  @override
    void initState() {
      super.initState();
      _connection = false;
      _futureConnection = initConnectivity();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  FutureBuilder(
        future: _futureConnection,
        builder: (context, snapshot){
          if (snapshot.connectionState != null) {
            if (snapshot.hasData) {
              return HomeScreen();
            } else if (snapshot.hasError) {
              // error widget
              return Center(child: Text(snapshot.error.toString()),
              );
            } else {
              // loading widget
              return Center(child: CircularProgressIndicator());
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<bool> initConnectivity() async {
    ConnectivityResult connectionStatus;
    try {
        connectionStatus = await Connectivity().checkConnectivity();
        if (_connectionStatus == ConnectivityResult.mobile ||  connectionStatus == ConnectivityResult.wifi) {
          _connection = true;
        }
    }
    catch (error) {
      print(error.toString());
    }
    return _connection;
  }

}






