import 'package:calculatorapp/widgets/buttongrid2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GSTCalc extends StatefulWidget {
  @override
  _GSTCalcState createState() => _GSTCalcState();
}

class _GSTCalcState extends State<GSTCalc> {
  TextEditingController gstamount = new TextEditingController();
  String rate1 = '28%';
  int radioValue = 0;

  void handleRadioChange(int value) {
    setState(() {
      radioValue = value;
      switch (radioValue) {
        case 0:
          print('Exclusive');
          break;
        case 1:
          print('Inclusive');
          break;
      }
    });
  }

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
                        controller: gstamount,
                        readOnly: true,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
//                            icon:
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
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 14),
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 320,
                    child: DropdownButton(
                      onChanged: (text) {},
                      isExpanded: true,

                      icon: Icon(Icons.keyboard_arrow_down),
//                      underline:,
                      elevation: 1,
                      value: rate1,
                      items: <String>['5%', '12%', '18%', '28%']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                color: Color(0xFF4E4E4E),
                                fontFamily: 'Google',
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: 300,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Radio<int>(
                          activeColor: Colors.brown,
                          value: 0,
                          groupValue: radioValue,
                          onChanged: handleRadioChange),
                      new Text(
                        "Exclusive",
                        style: TextStyle(
                            color: Color(0xFF4E4E4E),
                            fontFamily: 'Google',
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                      new Radio<int>(
                          activeColor: Colors.red,
                          value: 1,
                          groupValue: radioValue,
                          onChanged: handleRadioChange),
                      new Text(
                        "Inclusive",
                        style: TextStyle(
                            color: Color(0xFF4E4E4E),
                            fontFamily: 'Google',
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        Expanded(
            child: Container(
          width: double.infinity,
          color: Color(0xFF270F33),
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
      ]),
    );
  }

  void _onPressed({String buttonText}) {
    String displayString1 = gstamount.text.toString();
    if (buttonText == 'C') {
      return setState(() {
        String newDisplayString = displayString1;
        if (displayString1.length == 0) {
        } else {
          newDisplayString =
              newDisplayString.substring(0, displayString1.length - 1);
        }
        gstamount.text = newDisplayString;
      });
    } else {
      return setState(() {
        gstamount.text += "$buttonText";
//        debugPrint('$displayString1');
      });
    }
  }
}
