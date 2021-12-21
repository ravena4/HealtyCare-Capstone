import 'package:flutter/material.dart';
import 'package:healthy_care/model/historyitem.dart';
import 'package:hive/hive.dart';


class History extends StatelessWidget {
  History({Key key}) : super(key: key);
  final List<HistoryItem> result = Hive.box<HistoryItem>('history')
      .values
      .toList()
      .reversed
      .toList()
      .cast<HistoryItem>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('HISTORY'),
        actions: [
          IconButton(
            onPressed: () {
              Hive.box<HistoryItem>('history').clear();
              Navigator.pop(context);
              final snackBar = SnackBar(
                  content: Text(
                      'Deleted',
                      style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                        fontSize: 20, )
                  )
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            icon: Icon(Icons.auto_delete_outlined),
          ),
        ],
      ),
      body: result.isEmpty
          ? Center(
        child: Text(
          'Empty!',
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(fontSize: 12.0),
        ),
      )
          : ListView.separated(
        padding: EdgeInsets.all(10.0),
        itemCount: result.length,
        separatorBuilder: (BuildContext context, int index) =>
        const SizedBox(height: 10),
        itemBuilder: (BuildContext context, int i) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(result[i].title + ' cm'),
            subtitle: Text(result[i].subtitle + ' kg'),
            trailing: Text('BMI: ' + result[i].trailing),
          );
        },
      ),
    );
  }
}
