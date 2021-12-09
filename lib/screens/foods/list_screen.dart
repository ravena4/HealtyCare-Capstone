import 'dart:async';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:healthy_care/model/detail_recipe_model.dart';
import 'package:healthy_care/model/http_helper.dart';
import 'package:healthy_care/screens/foods/recipe_screen.dart';
import 'package:healthy_care/screens/foods/search_results_screen.dart';
import 'package:healthy_care/util/recipe_filter.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String message ='';
  bool isConnected = false;
  HttpHelper _httpHelper;
  List<RecipeModel> recipeList;
  int _numOfRecipes = 10;
  Widget _searchBar = Text('Foods Recommendation');
  Icon _visibleIcon = Icon(Icons.search);
  String query = '';

  List<String> selectedCountList = [];
  var _streamController = StreamController<List>.broadcast();

  @override
  void initState() {
    _httpHelper = HttpHelper();
    checkConnection().then((result) {
      if(result == true){
        setState(() {
          isConnected = true;
          _loadRecipes(_numOfRecipes).then((value) {
            recipeList = value;
            _streamController.sink.add(recipeList);
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
      appBar: AppBar(
        elevation: 8.0,
        title: _searchBar,
        actions: [
          // search
          IconButton(
              icon: _visibleIcon,
              onPressed: (){
                setState(() {
                  if(_visibleIcon.icon == Icons.search)
                    {
                      _visibleIcon = Icon(Icons.cancel);
                      _searchBar = TextField(
                        textInputAction: TextInputAction.search,
                        cursorColor: Colors.white,
                        showCursor: true,
                        decoration: InputDecoration(fillColor: Colors.white, hintText: 'Enter your Meal Name...', hintStyle: TextStyle(
                            fontSize: 20),),
                        style: TextStyle(
                            color:Colors.white,
                            fontSize: 20),
                        onSubmitted: (text){
                          MaterialPageRoute route = MaterialPageRoute(builder: (context) => SearchResultsScreen(text,List.empty()));
                          Navigator.push(context, route);
                        },
                      );
                    }
                  else{
                    setState(() {
                      _visibleIcon = Icon(Icons.search);
                      _searchBar = Text('Foods Recommendation');
                    });
                  }
                });
              }
          ),
          // filter
          IconButton(
              icon: Icon(Icons.filter_alt_outlined),
              onPressed: (){
               showDialog(context: context, builder: (context) => FilterDialog().buildFilterDialog());
               }
          ),
        ],
      ),
      body: Container(
        child: (isConnected) ? mainWidget(context) : Align(alignment: Alignment.center),
      )
    );
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
    return EasyRefresh.custom(
      footer: BallPulseFooter(color: Colors.pink),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              StreamBuilder(
                stream: _streamController.stream,
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
                                  FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: (snapshot.data[index].image) == null ?
                                    kTransparentImage : snapshot.data[index].image,
                                    fit: BoxFit.fill,
                                  ),
                                  Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 5,left:5,right: 5),
                                        child: AutoSizeText(
                                          snapshot.data[index].title,
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          maxFontSize: 12,
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
                  return Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 150),
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white)),
                      )
                  );
                },
              ),
            ],
          ),
        )
      ],
      onLoad: () async {
        checkConnection().then((result) {
          if (result == true) {
            setState(() {
              _loadRecipes(_numOfRecipes).then((value) {
                recipeList.insertAll(recipeList.length, value);
                print(recipeList.length);
                _streamController.sink.add(recipeList);
              });
            });
          }
          else {
            setState(() {
              _showSnakeBar(context);
            });
          }
        });
      },
    );
  }


  Future<List<RecipeModel>> _loadRecipes(int numberOfRecipes) async{
    List<RecipeModel> recipes =  await _httpHelper.getRandomRecipes(numberOfRecipes);
    return recipes;
  }

  Future retryConnection() async {
    checkConnection().then((result) {
      if (result == true) {
        setState(() {
          isConnected = true;
          _loadRecipes(_numOfRecipes).then((value) {
            recipeList = value;
            _streamController.sink.add(recipeList);
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

  void _showSnakeBar(BuildContext context){
    SnackBar(
      content: const Text('No Internet Connection'),
    );
  }

  @override
  void dispose() {
        super.dispose();
        _streamController.close();
  }

}

