import 'package:flutter/material.dart';
import 'package:healthy_care/model/detail_recipe_model.dart';

class StepsScreen extends StatelessWidget {

  final List<Steps> steps;
  StepsScreen(this.steps);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Steps', style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24)
      )),

      body: ListView.builder(
          itemCount: steps.length,
          itemBuilder: (context, index){
            return Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ListTile(
                      leading: Text('Step ${steps[index].number.toString()}: ', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                          fontSize: 20)),
                      title: Text(steps[index].step, style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20)),
                    ),
                  ),
                )
              ],
            );
      }),
    );
  }
}
