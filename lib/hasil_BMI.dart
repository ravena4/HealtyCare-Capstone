import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_care/rekomen.dart';

class hasil_BMI extends StatelessWidget {
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
