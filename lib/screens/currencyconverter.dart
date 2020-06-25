import 'package:calculatorapp/widgets/buttongrid2.dart';
import 'package:calculatorapp/widgets/custombuttons.dart';
import 'package:flutter/material.dart';

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                color: Colors.white,
                child: SizedBox(
                  height: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          '0.00',
                          style: TextStyle(
                              color: Color(0xFF4E4E4E),
                              fontFamily: 'Google',
                              fontSize: 40,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                color: Color(0xFF4E4E4E),
                child: SizedBox(
                  height: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          '0.00',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Google',
                              fontSize: 40,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                color: Color(0xFF4E4E4E),
                child: ListView(
                  children: [
//                    Divider(color: Colors.white,),
                    ButtonGrid2()
                  ],
                ),
              ))
            ],
          ),
          Container(
//            width: 100,
            margin: const EdgeInsets.only(bottom: 400),
            alignment: Alignment.center,
            child: Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(35))),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Color(0xFF4E4E4E),
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
                child: Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                  size: 27,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
