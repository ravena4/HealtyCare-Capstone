import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:healthy_care/model/detail_recipe_model.dart';
import 'package:healthy_care/model/http_helper.dart';
import 'package:healthy_care/screens/foods/recipe_screen.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:healthy_care/model/search_model.dart';
import 'package:healthy_care/util/filters.dart' as filters;

class SearchResultsScreen extends StatefulWidget {
  final String query;
  final List<String> filters;

  SearchResultsScreen(this.query, this.filters);

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {

  bool isConnected = false ;
  int _numOfRecipes = 10;
  int _currentOffset = 0;
  int _newOffset = 12;
  int totalResults = 0;
  HttpHelper _httpHelper;
  List<RecipeModel> recipeList;
  List<String> cuisines = [];
  List<String> diets = [];
  List<String> dishTypes = [];
  var _recipesStreamController = StreamController<List<RecipeModel>>.broadcast();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _httpHelper = HttpHelper();
    _setFiltersData(widget.filters);
    checkConnection().then((result) {
      if(result == true){
        setState(() {
          isConnected = true;
          _loadResults(_numOfRecipes, _currentOffset, widget.query, cuisines, diets, dishTypes).then((value) {
            recipeList = value.recipes;
            totalResults = value.totalResults;
            _recipesStreamController.sink.add(recipeList);
          });
        });
      }
      else{
        isConnected = false;
        print('no connection for some reason');
      }
      print(isConnected.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar:AppBar(title: Text('Your Results', style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24))),
        body: Container(
          child: (isConnected) ? mainWidget(context) : Align(alignment: Alignment.center, child: noInternet(context)),

        ));
  }


  Widget noInternet(BuildContext context){
    return Container(
        child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No internet Connection'),
              Padding(padding: EdgeInsets.only(top: 20)),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  child: Text('Try Again'),
                  onPressed: () => retryConnection())
            ],
          ),
        )

    );
  }

  Widget mainWidget(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return EasyRefresh.custom(
      header: BezierCircleHeader(),
      footer: BezierBounceFooter(backgroundColor: Colors.pink),
      slivers: [
        SliverToBoxAdapter(
          child: StreamBuilder(
            stream: _recipesStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 3,),

                  itemBuilder: (context, index)
                  { return GestureDetector(
                    onTap: (){
                      MaterialPageRoute route = MaterialPageRoute(builder: (context) => RecipeScreen(snapshot.data[index]));
                      Navigator.push(context, route);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          // recipe image
                          FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: (snapshot.data[index].image) == null ?
                            kTransparentImage : snapshot.data[index].image,
                            fit: BoxFit.fill,
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(top: 5,left:5,right: 5),
                                child: AutoSizeText(
                                  snapshot.data[index].title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  maxFontSize: 14,
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  );
                  },
                );
              }
              else if (snapshot.hasError) {
                print('something went wrong');
                return Container();
              }
              // loading indicator
              return Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: screenSize.height/3),
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white)),
                  )
              );
            },
          ),

        )
      ],
      onLoad: () async {
        checkConnection().then((result) {
          if (result == true) {
            print(totalResults);
              if(recipeList.length < totalResults){
                _currentOffset = _currentOffset + _newOffset + 3;
                setState(() {
                  _loadResults(_numOfRecipes, _currentOffset, widget.query, cuisines, diets, dishTypes).then((value) {
                    recipeList.insertAll(recipeList.length, value.recipes);
                    print(recipeList.length);
                    _recipesStreamController.sink.add(recipeList);
                  });
                });
              }
              else{
                setState(() {
                  _showSnakeBar(context,'End of Results');
                });

              }
          }
          else {
            setState(() {
              _showSnakeBar(context,'No Internet Connection');
            });
          }
        });
      },
    );
  }

  Future retryConnection() async {
    checkConnection().then((result) {
      if (result == true) {
        setState(() {
          isConnected = true;
          _loadResults(_numOfRecipes, _currentOffset, widget.query, cuisines, diets, dishTypes).then((value) {
            recipeList = value.recipes;
            _recipesStreamController.sink.add(recipeList);
          });
        });
      }
      else {
        setState(() {
          isConnected = false;
        });
      }
    });
  }

  Future<bool> checkConnection() async{
    bool result = false;
    try {
      final connectionResult = await InternetAddress.lookup('example.com');
      if (connectionResult.isNotEmpty &&
          connectionResult[0].rawAddress.isNotEmpty) {
        result = true;
      }

    } on SocketException catch (_) {
      print('still no internet connection or disconnected');
    }
    return result;
  }

  Future<SearchModel> _loadResults(int numberOfRecipes, int offset, String query, List<String> cuisines, List<String> diets, List<String> dishTypes ) async{
    SearchModel searchModel = SearchModel(0,List.empty());

    if (query == '') {
      searchModel = await _httpHelper.searchRecipesWithFilter(numberOfRecipes, offset, cuisines, diets, dishTypes);
    }
    else{
      searchModel =  await _httpHelper.searchRecipes(numberOfRecipes, offset, query);
    }

    return searchModel;
  }

  void _showSnakeBar(BuildContext context, String message){
    SnackBar(
      content: const Text('No Internet Connection'),
    );
  }

  void _setFiltersData(List<String> data)
  {
    data.forEach((item) {
      if(filters.cuisines.contains(item))
      {
        cuisines.add(item);
      }
      if(filters.diets.contains(item))
      {
        diets.add(item);
      }
      if(filters.dishTypes.contains(item))
      {
        dishTypes.add(item);
      }
    });
    print('cuisines: ${cuisines.join(',')}');
    print('diet: ${diets.join(',')}');
    print('dish: ${dishTypes.join(',')}');
  }

  @override
  void dispose() {
    super.dispose();
    _recipesStreamController.close();
  }
}
