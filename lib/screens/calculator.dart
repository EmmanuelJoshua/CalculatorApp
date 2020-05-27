import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Calculator',
            style: TextStyle(
                fontFamily: 'PTSans',
                fontSize: 19,
                fontWeight: FontWeight.w500),
          ),
          // elevation: 1,
          backgroundColor: Color(0xFF161514),
          centerTitle: true,
        ),
        backgroundColor: Color(0xFF151412),
        body: Column(
          children: <Widget>[
            //Number Display
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.only(top: 100.0, right: 20.0),
                  child: new Text(
                    "5 + 5",
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    style: TextStyle(
                      color: Color(0xFFD8E5ED),
                      fontSize: 30.0,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.only(right: 15.0, bottom: 15.0),
                  child: new Text(
                    "100",
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 60.0,
                      color: Color(0xFF84CCD9),
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ));
  }
}
