import 'package:calculatorapp/screens/calculator.dart';
import 'package:calculatorapp/screens/currencyconverter.dart';
import 'package:calculatorapp/screens/gstcalculator.dart';
import 'package:calculatorapp/screens/history.dart';
import 'package:calculatorapp/screens/tipcalculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 2;

  static List<Widget> widgetOptions = <Widget>[
    CurrencyConverter(),
    GSTCalc(),
    Calculator(),
    TipCalculator(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Calculator',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Google',
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            actions: [
              IconButton(
                icon: Icon(LineIcons.history),
                onPressed: () {
                  var router = MaterialPageRoute(
                      builder: (BuildContext context) => CalcHistory());
                  Navigator.of(context).push(router);
                },
              )
            ],
            elevation: 0,
            backgroundColor: Color(0xFF2B1137)),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(3),
          child: SafeArea(
            child: GNav(
              onTabChange: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              textStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Graphik',
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              selectedIndex: selectedIndex,
              gap: 8,
              iconSize: 24,
              activeColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              tabMargin: const EdgeInsets.all(5),
              duration: Duration(milliseconds: 800),
              tabBackgroundGradient: LinearGradient(
                  colors: [
                    Color(0xFFD46286),
                    Color(0xFF781C50),
                  ],
                  tileMode: TileMode.mirror,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              tabs: [
                GButton(
                  icon: LineIcons.refresh,
                  text: 'Convert',
                ),
                GButton(
                  icon: LineIcons.line_chart,
                  text: 'GST',
                ),
                GButton(
                  icon: LineIcons.calculator,
                  text: 'Calculate',
                ),
                GButton(
                  icon: LineIcons.money,
                  text: 'Tips',
                ),
                GButton(
                  icon: LineIcons.ticket,
                  text: 'Invoice',
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xFFF1F7FC),
        body: widgetOptions.elementAt(selectedIndex));
  }
}
