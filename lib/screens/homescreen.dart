import 'package:calculatorapp/screens/calculator.dart';
import 'package:calculatorapp/screens/currencyconverter.dart';
import 'package:calculatorapp/screens/history.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

 TabController tabController = new TabController(length: 5, vsync: ScaffoldState());

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
            icon: Icon(Icons.history),
            onPressed: () {
              var router = MaterialPageRoute(
                  builder: (BuildContext context) => CalcHistory());
              Navigator.of(context).push(router);
            },
          )
        ],
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
          unselectedLabelColor: Colors.white70,
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
                child: Text('Calculator',
                    style: TextStyle(fontSize: 15, fontFamily: 'Google'))),
            Tab(
                child: Text('Converter',
                    style: TextStyle(fontSize: 15, fontFamily: 'Google'))),
            Tab(
                child: Text('Tips',
                    style: TextStyle(fontSize: 15, fontFamily: 'Google'))),
            Tab(
                child: Text('GST',
                    style: TextStyle(fontSize: 15, fontFamily: 'Google'))),
            Tab(
                child: Text('Invoice',
                    style: TextStyle(fontSize: 15, fontFamily: 'Google')))
          ],
        ),
        backgroundColor: Color(0xFF4E4E4E),
        // centerTitle: true,
      ),
      backgroundColor: Color(0xFFFCFCFC),
      body: TabBarView(
        controller: tabController,
          children: [
        Calculator(),
        CurrencyConverter(),
        Container(),
        Container(),
        Container(),
      ]),
    );
  }
}
