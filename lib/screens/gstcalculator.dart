import 'package:calculatorapp/utils/calculationlogic.dart';
import 'package:calculatorapp/widgets/buttongrid2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class GSTCalc extends StatefulWidget {
  @override
  _GSTCalcState createState() => _GSTCalcState();
}

class _GSTCalcState extends State<GSTCalc> {
  TextEditingController gstamount = new TextEditingController();
  String rate1 = '28%';
  int selectValue = -1;

  void handleRadioChange(int value) {
    setState(() {
//      radioValue = value;
//      switch (radioValue) {
//        case 0:
//          print('Exclusive');
//          break;
//        case 1:
//          print('Inclusive');
//          break;
//      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: Color(0xFF270F33),
      ),
      child: Column(children: [
        Container(
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Container(
                      width: 330,
                      height: 55,
                      padding: const EdgeInsets.only(top: 15, left: 12),
                      decoration: BoxDecoration(
                          color: Color(0xFF720D5D),
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: TextField(
                        controller: gstamount,
                        readOnly: true,
                        decoration: InputDecoration.collapsed(
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Google',
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                            hintText: 'Amount'),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Google',
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
              ],
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.all(5)),
        Container(
//          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.only(left: 14),
            width: 330,
            height: 55,
            decoration: BoxDecoration(
                color: Color(0xFF720D5D),
                borderRadius: BorderRadius.all(Radius.circular(7))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 300,
                  child: DropdownButton(
                    onChanged: (text) {},
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    underline: Container(),
                    elevation: 1,
                    dropdownColor: Color(0xFF3C174D),
                    value: rate1,
//                    isDense: true,
                    items: <String>['5%', '12%', '18%', '28%']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Google',
                              fontSize: 17,
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
        Padding(padding: const EdgeInsets.all(5)),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 300,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ChoiceChip(
                        label: Text('Exclusive'),
                        avatar: Icon(
                          LineIcons.check_circle,
                          color: Colors.white,
                        ),
                        pressElevation: 0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        backgroundColor: Color(0xFF720D5D),
                        padding: const EdgeInsets.all(12),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Google',
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xFF720D5D)),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        selected: selectValue == 0,
                        onSelected: (value) {
                          setState(() {
                            selectValue = value ? 0 : -1;
                          });
                        },
                      ),
                      Padding(padding: const EdgeInsets.all(5)),
                      ChoiceChip(
                        avatar: Icon(
                          LineIcons.check_circle,
                          color: Colors.white,
                        ),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xFF720D5D)),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        label: Text('Inclusive'),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        backgroundColor: Color(0xFF720D5D),
                        padding: const EdgeInsets.all(12),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Google',
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                        selected: selectValue == 1,
                        onSelected: (value) {
                          setState(() {
                            selectValue = value ? 1 : -1;
                          });
                        },
                      )
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
    } else if(buttonText == Calculations.EQUAL) {
      CalculationLogic.calculateGST('100', '5', false);
    }else{
      return setState(() {
        gstamount.text += "$buttonText";
      });
    }
  }
}
