import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class rekomen extends StatelessWidget {
 final List rekom = [
    "1. Hindari stres",
    "2. Bijak dalam memilih makanan",
    "3. Ambil waktu untuk berolahraga setiap hari",
    "4. Kurangi konsumsi gula mulai hari ini",
    "5. Banyak minum air mineral",
    "6. Tidur yang cukup",
    "7. Perbanyak makan sayur"
  ];
 
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REKOMENDASI"),
      ),
        body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(rekom[index], style: TextStyle(fontSize: 30)),
            ),
          );
        },
        itemCount: rekom.length,
      ),
    );
  } 
}  