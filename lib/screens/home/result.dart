import 'package:flutter/material.dart';
import 'package:healthy_care/service/home_page_controller.dart';
import 'package:healthy_care/screens/home/BMI_result.dart';
import 'package:healthy_care/screens/home/recommendation.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../util/reusable_card.dart';
import '../../util/bottom_button.dart';

class ResultsPage extends StatelessWidget {
  static const routeName = 'ResultPage';

  @override
  Widget build(BuildContext context) {
    final BmiProvider =
    Provider.of<HomePageController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
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
                          Consumer<HomePageController>(
                            builder: (context, val, child) {
                              return Text('${val.getGender}', style: kBodyTextStyle);
                            },
                          ),
                          Text(
                              '${context.select<HomePageController, int>((value) => value.getAge)} years old',
                              style: kBodyTextStyle),
                          Consumer<HomePageController>(
                            builder: (context, val, child) {
                              return Text('${val.getResult()}'.toUpperCase(), style: kResultTextStyle);
                            },
                          ),
                          Text(
                            '${context.select<HomePageController, int>((value) => value.getBmi())}',
                            style: kBMITextStyle,
                          ),
                          Consumer<HomePageController>(
                            builder: (context, val, child) {
                              return Text('${val.getInterpretation()}.', textAlign: TextAlign.center, style: kBodyTextStyle);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  BottomButton(
                    buttonTitle: 'SAVE TO HISTORY',
                    onTap: () {
                      BmiProvider.result();
                      final snackBar = SnackBar(
                        content: Text('Saved', textAlign: TextAlign.center, style: TextStyle(color: Colors.pink, fontSize: 20, fontWeight: FontWeight.bold)),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
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
            ),
          ),
        ],
      ),
    );
  }
  }
