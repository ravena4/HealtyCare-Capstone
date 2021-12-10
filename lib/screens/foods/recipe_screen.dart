import 'package:auto_size_text/auto_size_text.dart';
import 'package:healthy_care/util/bottom_button.dart';
import 'package:healthy_care/screens/foods/ingredient_screen.dart';
import 'package:healthy_care/screens/foods/steps_screen.dart';
import 'package:html/parser.dart';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:healthy_care/model/ingredients_model.dart';
import 'package:healthy_care/model/detail_recipe_model.dart';

class RecipeScreen extends StatelessWidget {

  final RecipeModel _recipeModel;
  RecipeScreen(this._recipeModel);
  String _summery = '';
  String _servings = '';
  String _readyInMin = '';
  String _cuisine = '';
  String _diets = '';
  String _dishTypes = '';

  @override
  Widget build(BuildContext context) {
    _setValuesFromObject(_recipeModel);
    return SafeArea(
      child: Scaffold(
          body: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 260,
                  ),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        children: [
                          //recipe image
                          Align(
                            alignment: Alignment.topCenter,
                            child:ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: (_recipeModel.image) == null ?
                                kTransparentImage : _recipeModel.image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          // recipe title
                          Padding(
                            padding: EdgeInsets.only(top: 190,left: 10, right: 10),
                            child: AutoSizeText(
                              _recipeModel.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  backgroundColor: Colors.pink,
                                  fontSize: 26),
                              maxLines: 2,
                            ),
                          )
                        ],
                      )
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Wrap(
                            children: [
                              Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                        child: Text('Description: ', style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.pink,
                                            fontSize: 24)
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: AutoSizeText(
                                        _summery,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                            fontSize: 18),

                                      ),
                                    ),

                                  ],
                                ),
                              )

                            ],
                          ),
                          Wrap(
                            children: [
                              Card(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(padding: EdgeInsets.only(left:5)),
                                              Text('Servings: ', style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.pink,
                                                  fontSize: 20)),
                                              Text(_servings, style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white,
                                                  fontSize: 18)),
                                            ],
                                          ),
                                          Padding(padding: EdgeInsets.symmetric(vertical:5)),
                                          Row(
                                            children: [
                                              Padding(padding: EdgeInsets.only(left:5)),
                                              Text('Ready In Minutes: ', style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.pink,
                                                  fontSize: 20)),
                                              Text(_readyInMin, style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white,
                                                  fontSize: 18)),
                                            ],
                                          ),
                                          Padding(padding: EdgeInsets.symmetric(vertical:5)),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(padding: EdgeInsets.only(left:5)),
                                              Text('Cuisines: ', style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.pink,
                                                  fontSize: 20)),

                                              Flexible(
                                                child: Text(_cuisine, style: TextStyle(
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                    fontSize: 18),),
                                              )
                                            ],
                                          ),
                                          Padding(padding: EdgeInsets.symmetric(vertical:5)),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(padding: EdgeInsets.only(left:5)),
                                              Text('Dish Types: ', style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.pink,
                                                  fontSize: 20)),
                                              Flexible(
                                                child: Text(_dishTypes, style: TextStyle(
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                    fontSize: 18),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(padding: EdgeInsets.symmetric(vertical:5)),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(padding: EdgeInsets.only(left:5)),
                                              Text('Diets: ', style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.pink,
                                                  fontSize: 20)),
                                              Flexible(
                                                child: Text(_diets, style: TextStyle(
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                    fontSize: 18)),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                  )
                              ),
                            ],
                          ),
                          BottomButton(
                            buttonTitle: 'Ingredients',
                            onTap: () {
                              List<IngredientModel> ingredients = _recipeModel.ingredients;
                              MaterialPageRoute route = MaterialPageRoute(builder: (context) => IngredientsScreen(ingredients));
                              Navigator.push(context, route);
                            },
                          ),
                          BottomButton(
                            buttonTitle: 'Steps',
                            onTap: () {
                              List<Steps> steps = _recipeModel.analyzedInstruction[0].steps;
                              MaterialPageRoute route = MaterialPageRoute(builder: (context) => StepsScreen(steps));
                              Navigator.push(context, route);
                            },
                          ),
                        ],
                      ),
                    )
                ),
              ]
          )
      ),
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  void _setValuesFromObject(RecipeModel recipeModel)
  {
    if (recipeModel.summary != null || recipeModel.summary.isNotEmpty) {
      _summery = _parseHtmlString(recipeModel.summary);
    } else{
      _summery = 'No Information Found';
    }

    if (recipeModel.servings != null) {
      _servings = recipeModel.servings.toString();
    } else{
      _servings = 'No Information Found';
    }

    if (recipeModel.readyInMinutes != null) {
      _readyInMin = recipeModel.readyInMinutes.toString();
    } else{
      _readyInMin = 'No Information Found';
    }
    if (recipeModel.cuisines.length != 0) {
      _cuisine = recipeModel.cuisines.join(", ");
    } else{
      _cuisine = 'No Information Found';
    }
    if (recipeModel.diets.length != 0) {
      _diets = _recipeModel.diets.join(", ");
    } else{
      _diets = 'No Information Found';
    }
    if (recipeModel.dishTypes.length != 0) {
      _dishTypes = recipeModel.dishTypes.join(", ");
    } else{
      _dishTypes = 'No Information Found';
    }

  }
}
