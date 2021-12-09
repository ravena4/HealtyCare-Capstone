import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_care/rekomen.dart';

class hasil_BMI extends StatelessWidget {

// void main()
// { 
//   var teamA = 25; 
//   var teamB = 18.5; 
  
//   if(teamA > teamB){
//     print('Team A Menang');
//   } else if(teamB > teamA){
//     print('Team B Menang');
//   } else{
//     print('Kedua Team Seri');
//   }
// }

// String getResult() {
//     if (_bmi >= 25) {
//       return 'Overweight';
//     } else if (_bmi > 18.5) {
//       return 'Normal';
//     } else {
//       return 'Underweight';
//     }
//   }

  final List makanan = [
    "Kondisi: BMR rendah menunjukkan angka BMR yang lebih kecil dari angka normal biasanya kurang dari 1.500 kkal per hari.",
    "Resiko: Hal yang dapat disebabkan oleh ketidaksimbangan hormon, seperti rendahnya hormon tiroid akibat tidak mendapatkan cukup kalori dalam jangka waktu yang lama. Akibatnya tubuh akan beradaptasi dengan kondisi tersebut. jika anda tidak memberi tubuh cukup kalori untuk beraktifitas, tubuh akan melakukan penyesuaian. Setelahnya, tubuh akan mengurangi penggunaan energi anda untuk bertahan hidup.",
    "Saran: Anda membutuhkan 2.520 kkal per hari. Dengn melakukan aktifitas ringan, tubuh membutuhkan 2.520 kkal setiap harinya untuk mempertahankan berat badan anda saat ini."
  ];
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hasil BMI"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(makanan[index], style: TextStyle(fontSize: 30)),
            ),
          );
        },
        itemCount: makanan.length,
      ),
    );
  } 
}   
