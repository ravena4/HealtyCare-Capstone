import 'package:flutter/material.dart';
import '../constants.dart';

class BottomButton extends StatelessWidget {
  BottomButton({@required this.onTap, @required this.buttonTitle});

  final Function onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: Center(
            child: Text(
              buttonTitle,
              style: kLargeButtonTextStyle,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: kBottomContainerColour,
          ),
          width: double.infinity,
          height: kBottomContainerHeight,
        ),
      ),
    );
  }
}
