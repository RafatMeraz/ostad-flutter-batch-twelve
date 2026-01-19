import 'package:flutter/material.dart';
import 'package:live_class_app/my_location_screen.dart';

// State - two type
// Local, Shared/Application

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyLocationScreen());
  }
}
