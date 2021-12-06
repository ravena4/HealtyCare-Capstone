import 'package:flutter/material.dart';
import 'package:healthy_care/hasil_BMI.dart';
import 'package:healthy_care/rekomen.dart';
import 'constants.dart';
import 'reusable_card.dart';
import 'bottom_button.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage(
      {@required this.interpretation,
      @required this.bmiResult,
      @required this.resultText});

  final String bmiResult;
  final String resultText;
  final String interpretation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: BoxContainer(
              color: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                   Text(
                'Your Result',
                style: kTitleTextStyle,
              ),
                  Text(
                    resultText.toUpperCase(),
                    style: kResultTextStyle,
                  ),
                  Text(
                    bmiResult,
                    style: kBMITextStyle,
                  ),
                  Text(
                    interpretation,
                    textAlign: TextAlign.center,
                    style: kBodyTextStyle,
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            buttonTitle: 'RE-CALCULATE',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          BottomButton(
            buttonTitle: 'HASIL BMI',
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => hasil_BMI()),
              );
               },
          ),
          BottomButton( buttonTitle: "REKOMENDASI",
          onTap: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => rekomen() ),
            );
          },)
        ],
      ),
    );
  }
  }
