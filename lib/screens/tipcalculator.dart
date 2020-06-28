import 'package:calculatorapp/widgets/buttongrid2.dart';
import 'package:flutter/material.dart';

class TipCalculator extends StatefulWidget {
  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  TextEditingController tipamount = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
          Container(
            color: Colors.white,
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: SizedBox(
                        width: 330,
                        height: 60,
                        child: TextField(
                          controller: tipamount,
                          readOnly: true,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              suffixIcon: Icon(Icons.attach_money),
                              hintText: 'Please enter your amount'),
                          style: TextStyle(
                              color: Color(0xFF4E4E4E),
                              fontFamily: 'Google',
                              fontSize: 21,
                              fontWeight: FontWeight.w400),
                        ),
                      )),
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
                    Padding(
                      padding: const EdgeInsets.all(10),
                    ),
                    ButtonGrid2(
                      onTap: _onPressed,
                    )
                  ],
                ),
              ))
        ])
    );
  }

  void _onPressed({String buttonText}) {
    String displayString1 = tipamount.text.toString();
    if (buttonText == 'C') {
      return setState(() {
        String newDisplayString = displayString1;
        if (displayString1.length == 0) {
        } else {
          newDisplayString =
              newDisplayString.substring(0, displayString1.length - 1);
        }
        tipamount.text = newDisplayString;
      });
    } else {
      return setState(() {
        tipamount.text += "$buttonText";
//        debugPrint('$displayString1');
      });
    }
  }
}
