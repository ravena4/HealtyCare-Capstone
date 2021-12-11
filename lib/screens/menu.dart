import 'package:flutter/material.dart';
import 'package:healthy_care/screens/foods/launch_screen.dart';
import 'package:healthy_care/screens/home/input_page.dart';
import 'package:healthy_care/setting.dart';

class BottomNavPage extends StatefulWidget {
  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _selectedTabIndex = 0;

  void _onNavBarTap(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _listPage = <Widget>[
      InputPage(),
      LaunchScreen(),
      Text('Halaman Favorite'),
      SettingScreen(),
    ];

    final _bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.fastfood),
        label: 'Foods',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Favorite',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),

    ];

    final _bottomNavBar = BottomNavigationBar(
      items: _bottomNavBarItems,
      currentIndex: _selectedTabIndex,
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey,
      onTap: _onNavBarTap,
    );

    return Scaffold(
      body: Center(
        child: _listPage[_selectedTabIndex],
      ),
      bottomNavigationBar: _bottomNavBar,
    );
  }
}