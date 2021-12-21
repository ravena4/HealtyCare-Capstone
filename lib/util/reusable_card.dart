import 'package:flutter/material.dart';
import 'package:healthy_care/service/home_page_controller.dart';
import 'package:provider/provider.dart';

class BoxContainer extends StatelessWidget {
  final Color color;
  final Widget cardChild;
  final Function onPress;

  BoxContainer({@required this.color, this.cardChild, this.onPress});

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
