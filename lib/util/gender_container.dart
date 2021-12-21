import 'package:flutter/material.dart';
import 'package:healthy_care/service/home_page_controller.dart';
import 'package:provider/provider.dart';

class GenderContainer extends StatelessWidget {
  final String gender;
  final Color color;
  final Widget cardChild;
  final Function onPress;

  GenderContainer({this.color, this.cardChild, this.onPress, this.gender});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageController>(
      builder: (context, value, child) => GestureDetector(
        onTap: onPress,
        child: Container(
          child: cardChild,
          margin: EdgeInsets.all(15.0),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}

class IconContents extends StatelessWidget {
  final String character;
  final IconData icon;
  IconContents({this.character, this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          character,
          style: TextStyle(
            fontSize: 18.0,
            color: Color(0xFF8D8E98),
          ),
        ),
      ],
    );
  }
}
