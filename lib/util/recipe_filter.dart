import 'package:flutter/material.dart';
import 'package:healthy_care/screens/foods/search_results_screen.dart';
import 'filters.dart' as filters;

class FilterDialog{
  Widget buildFilterDialog(){
    return AlertDialog(
      content: RecipeFilter(),
    );
  }
}

class RecipeFilter extends StatefulWidget {
  @override
  _RecipeFilterState createState() => _RecipeFilterState();
}

class _RecipeFilterState extends State<RecipeFilter> {
  List<String> selectedFilter = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer("Cuisines:"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: <Widget>[
                        createFilterChip(filters.cuisines[0]),
                        createFilterChip(filters.cuisines[1]),
                        createFilterChip(filters.cuisines[2]),
                        createFilterChip(filters.cuisines[3]),
                        createFilterChip(filters.cuisines[4]),
                        createFilterChip(filters.cuisines[5]),
                        createFilterChip(filters.cuisines[6]),
                        createFilterChip(filters.cuisines[7]),
                        createFilterChip(filters.cuisines[8]),
                        createFilterChip(filters.cuisines[9]),
                        createFilterChip(filters.cuisines[10]),
                      ],
                    )
                ),
              ),
            ),
            Divider(color: Colors.white, height: 10.0,),
            // diets
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer("Diet:"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: <Widget>[
                        createFilterChip(filters.diets[0]),
                        createFilterChip(filters.diets[1]),
                        createFilterChip(filters.diets[2]),
                        createFilterChip(filters.diets[3]),
                        createFilterChip(filters.diets[4]),
                        createFilterChip(filters.diets[5]),

                      ],
                    )
                ),
              ),
            ),
            Divider(color: Colors.white, height: 10.0,),
            //dish type
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer("Dish Types:"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: <Widget>[
                        createFilterChip(filters.dishTypes[0]),
                        createFilterChip(filters.dishTypes[1]),
                        createFilterChip(filters.dishTypes[2]),
                        createFilterChip(filters.dishTypes[3]),
                        createFilterChip(filters.dishTypes[4]),
                        createFilterChip(filters.dishTypes[5]),
                        createFilterChip(filters.dishTypes[6]),
                      ],
                    )
                ),
              ),
            ),
            Divider(color: Colors.white, height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  child: Text(
                    'cancel', style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Navigator.pop(context);
                  }),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                    child: Text('ok', style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),),
                    onPressed: () {
                      MaterialPageRoute route = MaterialPageRoute(builder: (context) => SearchResultsScreen('', selectedFilter));
                      Navigator.push(context, route);               // Navigator.pop(context);

                    }),
              ],
            )
          ],
        ),

    );
  }
  Widget _titleContainer(String myTitle) {
    return Text(
      myTitle,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18),
    );
  }

  Widget createFilterChip(String name){
   return FilterChip(
        label: Text(name),
        labelStyle: TextStyle(
       color: selectedFilter.contains(name)
           ? Colors.white
           : Colors.white,
       fontWeight: FontWeight.bold,
       fontSize: 16),

        shape: StadiumBorder (
             side: BorderSide (
             color: selectedFilter.contains(name)
                 ? Colors.transparent
                 : Colors.pink,
              width: 1.0,
              ),
              ),
        backgroundColor: Colors.transparent,
        selectedColor: Colors.pink,
        checkmarkColor: Colors.white,
        selected: selectedFilter.contains(name),
        onSelected: (selected){
          setState(() {
            if(selected)
              {
                selectedFilter.add(name);
              }
            else{
              selectedFilter.remove(name);
            }

          });
        });
  }

}
