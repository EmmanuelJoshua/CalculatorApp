import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/homescreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF2B1137),
      statusBarIconBrightness: Brightness.light,
    ));

    return MaterialApp(
        title: 'CalculatorApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen());
  }
}
