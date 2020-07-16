import 'package:calculatorapp/screens/calculator.dart';
import 'package:calculatorapp/screens/currencyconverter.dart';
import 'package:calculatorapp/screens/gstcalculator.dart';
import 'package:calculatorapp/screens/history.dart';
import 'package:calculatorapp/screens/tipcalculator.dart';
import 'package:calculatorapp/widgets/customslideup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin<HomeScreen> {
  int selectedIndex = 0;

  static List<Widget> widgetOptions = <Widget>[
    CurrencyConverter(),
    GSTCalc(),
    TipCalculator(),
    Calculator()
//    Container(),
  ];

  static List<String> screenNames = <String>[
    'Currency Converter',
    'GST Calculator',
    'Tip Calculator',
    'Calculator',
  ];
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            screenNames[selectedIndex],
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
                var router1 = MaterialPageRoute(
                    builder: (BuildContext context) => CalcHistory());
                Navigator.of(context).push(router1);
              },
            ),
            IconButton(
              icon: Icon(LineIcons.qrcode),
              onPressed: () {
                Navigator.of(context).push(CustomSlideUp());
              },
            )
          ],
          elevation: 0,
          backgroundColor: Color(0xFF2B1137)),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(3),
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
          backgroundColor: Color(0xFFF1F7FC),
          iconSize: 24,
          activeColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          tabMargin: const EdgeInsets.all(5),
          duration: Duration(milliseconds: 800),
          curve: Curves.ease,
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
              icon: LineIcons.ticket,
              text: 'GST',
            ),
            GButton(
              icon: LineIcons.money,
              text: 'Tips',
            ),
            GButton(
              icon: LineIcons.calculator,
              text: 'Calculate',
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF270F33),
      body: AnimatedSwitcher(
          switchInCurve: Curves.fastOutSlowIn,
          switchOutCurve: Curves.fastOutSlowIn,
          duration: Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              FadeTransition(
                opacity: animation,
                child: child,
              ),
          child: widgetOptions.elementAt(selectedIndex)),
    );
  }
}
