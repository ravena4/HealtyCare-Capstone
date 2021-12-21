import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healthy_care/model/historyitem.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePageController extends ChangeNotifier {

  int _height = 120;
  int _weight = 50;
  int _age = 20;
  bool isMale = true;
  int get getHeight => _height;

  int get getWeight => _weight;
  String _getGender() {
    if (isMale) {
      notifyListeners();
      return 'Male';
    }
    notifyListeners();
    return 'Female';
  }

  String get getGender => _getGender();

  int get getAge => _age;
  void changeGender() {
    if (isMale == true) {
      isMale = false;
      notifyListeners();
    } else {
      isMale = true;
      notifyListeners();
    }
  }

  int getBmi() {
    double bmi = _weight / pow(_height / 100, 2);
    notifyListeners();
    return bmi.round();
  }

  heightFunction(int newHeight) {
    _height = newHeight;
    notifyListeners();
  }

  weightFunction(int newWeight) {
    _weight = newWeight;

    notifyListeners();
  }

  ageFunction(int newAge) {
    _age = newAge;
    notifyListeners();
  }

  void increaseWeight() {
    _weight++;

    notifyListeners();
  }

  void decreaseWeight() {
    if (_weight > 0) {
      _weight--;

      notifyListeners();
    }
  }

  void increaseAge() {
    _age++;
    notifyListeners();
  }

  decreaseAge() {
    if (_age > 0) {
      _age--;
      notifyListeners();
    }
  }

  String getResult() {
    if (getBmi() >= 25) {
      return 'Overweight';
    } else if (getBmi() > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String getInterpretation() {
    if (getBmi() >= 25) {
      return 'You have a higher than Body Mass Index than a normal Person ';
    } else if (getBmi() >= 18.5) {
      return 'You have a normal body mass Index ';
    } else {
      return 'You have a lower Body Mass Index ';
    }
  }

  void result() {
    final historyItem = HistoryItem()
      ..title = _height.toString()
      ..subtitle = _weight.toString()
      ..trailing = getBmi().toString();
    Hive.box<HistoryItem>('history').add(historyItem);
  }
  notifyListeners();



}
