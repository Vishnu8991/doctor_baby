import 'package:doctor_baby/view/auth/registration.dart';
import 'package:doctor_baby/view/homepage/map.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: RegPage(),
      home: MapScreen(),
    );
  }
}
