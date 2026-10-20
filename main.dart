import 'package:flutter/material.dart';
import 'package:tugas3/bmi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kalkulator BMI',
      home: BMI(),
      debugShowCheckedModeBanner: false,
    );
  }
}