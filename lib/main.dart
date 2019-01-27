import 'package:flutter/material.dart';
import 'package:bloc_test/Screens/Authentication.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Flutter App',
      home: Authentication()
    );
  }
}
