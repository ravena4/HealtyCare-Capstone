import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthy_care/service/home_page_controller.dart';
import 'package:healthy_care/screens/history.dart';
import 'package:healthy_care/util/bottom_button.dart';
import 'package:healthy_care/constants.dart';
import 'package:healthy_care/util/gender_container.dart';
import 'package:healthy_care/util/reusable_card.dart';
import 'package:provider/provider.dart';
import 'result.dart';

class InputPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('BMI CALCULATOR'),
        elevation: 8.0,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(context: context, builder: (context) => History());
            },
            icon: Icon(Icons.history),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Consumer<HomePageController>(
                          builder: (context, value, child) => GenderContainer(
                            onPress: () => value.changeGender(),
                            color: value.isMale
                                ? kActiveCardColour
                                : kInactiveCardColour,
                            cardChild: IconContents(
                              icon: FontAwesomeIcons.mars,
                              character: 'MALE',
                            ),
                          ),
                        ),
                        ),
                        Expanded(
                          child: Consumer<HomePageController>(
                          builder: (context, value, child) => GenderContainer(
                            onPress: () => value.changeGender(),
                            color: !value.isMale
                                ? kActiveCardColour
                                : kInactiveCardColour,
                            cardChild: IconContents(
                              icon: FontAwesomeIcons.venus,
                              character: 'FEMALE',
                            ),
                          ),
                        ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: BoxContainer(
                      color: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'HEIGHT',
                            style: kLabelTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Selector<HomePageController, int>(
                                selector: (_, provider) => provider.getHeight,
                                builder: (BuildContext context, value, Widget child) =>
                                    Text(value.round().toString(), style: kNumberTextStyle),
                              ),
                              Text(
                                'cm',
                                style: kLabelTextStyle,
                              )
                            ],
                          ),
                          Consumer<HomePageController>(
                            builder: (BuildContext context, p, _) => SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                inactiveTrackColor: Color(0xFF8D8E98),
                                activeTrackColor: Colors.white,
                                thumbColor: Color(0xFFEB1555),
                                overlayColor: Color(0x29EB1555),
                                thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 15.0),
                                overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 30.0),
                              ),
                              child: Slider(
                                value: p.getHeight.toDouble(),
                                max: 250.0,
                                min: 80.0,
                                activeColor: kBottomContainerColour,
                                onChanged: (newHeight) {
                                  p.heightFunction(newHeight.toInt());
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: BoxContainer(
                            color: kActiveCardColour,
                            cardChild: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'WEIGHT',
                                  style: kLabelTextStyle,
                                ),
                                Selector<HomePageController, int>(
                                  selector: (_, provider) => provider.getWeight,
                                  builder: (context, value, child) => Text(
                                    value.toString(),
                                    style: kNumberTextStyle,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Consumer<HomePageController>(
                                        builder: (context, provider, child) => Container(
                                          child: FloatingActionButton(
                                            heroTag: 'decreaseWeight',
                                            mini: true,
                                            backgroundColor: Colors.grey,
                                            onPressed: () => provider.decreaseWeight(),
                                            child: Icon(FontAwesomeIcons.minus, color: Colors.white),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Consumer<HomePageController>(
                                      builder: (context, provider, child) =>
                                          FloatingActionButton(
                                            heroTag: 'increaseWeight',
                                            mini: true,
                                            backgroundColor: Colors.grey,
                                            onPressed: () => provider.increaseWeight(),
                                            child: Icon(FontAwesomeIcons.plus, color: Colors.white),
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: BoxContainer(
                            color: kActiveCardColour,
                            cardChild: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'AGE',
                                  style: kLabelTextStyle,
                                ),
                                Selector<HomePageController, int>(
                                  selector: (_, provider) => provider.getAge,
                                  builder: (context, value, child) => Text(
                                    value.toString(),
                                    style: kNumberTextStyle,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Consumer<HomePageController>(
                                        builder: (context, provider, child) => Container(
                                          child: FloatingActionButton(
                                            heroTag: 'decreaseAge',
                                            mini: true,
                                            backgroundColor: Colors.grey,
                                            onPressed: () => provider.decreaseAge(),
                                            child: Icon(FontAwesomeIcons.minus, color: Colors.white),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Consumer<HomePageController>(
                                      builder: (context, provider, child) =>
                                          FloatingActionButton(
                                            heroTag: 'increaseAge',
                                            mini: true,
                                            backgroundColor: Colors.grey,
                                            onPressed: () => provider.increaseAge(),
                                            child: Icon(FontAwesomeIcons.plus, color: Colors.white),
                                          ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BottomButton(
                    buttonTitle: 'CALCULATE',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultsPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
