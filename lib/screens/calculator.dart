import 'package:calculatorapp/screens/history.dart';
import 'package:calculatorapp/widgets/buttongrid.dart';
import 'package:calculatorapp/widgets/numberdisplay.dart';
import 'package:flutter/material.dart';

import '../calculationlogic.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  bool isNewEquation = true;
  List<double> values = [];
  List<String> operations = [];
  List<String> calculations = [];
  String displayString = '';
  String resultString = '';

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
              onPressed: (){
                var router = MaterialPageRoute(builder: (BuildContext context) => CalcHistory());

                Navigator.of(context).push(router);
              },
            )
          ],
          backgroundColor: Color(0xFF4E4E4E),
          // centerTitle: true,
        ),
        backgroundColor: Color(0xFFFCFCFC),
        body: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new NumberDisplay(
              displayString: displayString,
              resultString: resultString,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Divider(
                thickness: 2.5,
                color: Color(0xFF4E4E4E),
              ),
            ),
            new ButtonGrid(
              onTap: _onPressed,
            )
          ],
        )));
  }

  void _onPressed({String buttonText}) {
    // Standard mathematical operations
    if (Calculations.OPERATIONS.contains(buttonText)) {
      return setState(() {
        operations.add(buttonText);
        displayString += "$buttonText";
        debugPrint('$displayString');
      });
    }

    // On CLEAR ALL press
    if (buttonText == Calculations.CLEARALL) {
      return setState(() {
        operations.add(Calculations.CLEARALL);
        displayString = "";
        resultString = "";
      });
    }

    // On CLEAR press
    if (buttonText == Calculations.CLEAR) {
      return setState(() {
        operations.add(Calculations.CLEAR);
        String newDisplayString = displayString;
        if(displayString.length == 0){
 
        }else{
           newDisplayString = newDisplayString.substring(0 , displayString.length - 1); 
        }
        displayString = newDisplayString;
      });
    }

    // On Equals press
    if (buttonText == Calculations.EQUAL) {
      String newCalculatorString = CalculationLogic.parseString(displayString);

      return setState(() {
        if (newCalculatorString != displayString) {
          // only add evaluated strings to calculations array
          calculations.add(displayString);
        }

        operations.add(Calculations.EQUAL);
        resultString = newCalculatorString;
        isNewEquation = false;
      });
    }

    if (buttonText == Calculations.PERIOD) {
      return setState(() {
        displayString = CalculationLogic.addPeriod(displayString);
      });
    }

    setState(() {
      if (!isNewEquation &&
          operations.length > 0 &&
          operations.last == Calculations.EQUAL) {
        displayString = buttonText;
        isNewEquation = true;
      } else {
        displayString += buttonText;
      }
    });
  }
}
