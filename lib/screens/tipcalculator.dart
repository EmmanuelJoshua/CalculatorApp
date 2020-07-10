import 'package:calculatorapp/utils/calculationlogic.dart';
import 'package:calculatorapp/utils/randomutils.dart';
import 'package:calculatorapp/widgets/buttongrid2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class TipCalculator extends StatefulWidget {
  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  static TextEditingControllerWorkaround amount =
      new TextEditingControllerWorkaround();
  static TextEditingControllerWorkaround tipPercent =
      new TextEditingControllerWorkaround();
  static TextEditingControllerWorkaround noOfPeople =
      new TextEditingControllerWorkaround();
  int focusedIndex = 0;
  List<TextEditingController> textfieldOptions = <TextEditingController>[
    amount,
    tipPercent,
    noOfPeople
  ];

  List<String> tips;
  int amountFocused = 0;

  showCustomDialog(List<String> billList) {
    String totalBill = billList[0];
    String totalTip = billList[1];
    String tipPerPerson = billList[2];
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              child: Container(
                  height: 310,
                  width: 150,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xFFD46286),
                                  Color(0xFF781C50),
                                ],
                                tileMode: TileMode.mirror,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10))),
                        width: double.infinity,
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Icon(
                            LineIcons.check_circle,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                'Tips per person: ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Google',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                              trailing: Text(
                                '\$$tipPerPerson',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Google',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Divider(),
                            ListTile(
                              title: Text(
                                'Total tip: ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Google',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                              trailing: Text(
                                '\$$totalTip',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Google',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Divider(),
                            ListTile(
                              title: Text(
                                'Total bill: ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Google',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                              trailing: Text(
                                '\$$totalBill',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Google',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )));
        });
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
          width: deviceSize.width,
          constraints: BoxConstraints(minHeight: deviceSize.height - 140),
          padding: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: Color(0xFF270F33),
          ),
          child: Column(children: [
            Container(
              child: SizedBox(
                width: deviceSize.width,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: Container(
                            width: deviceSize.width - 30,
                            height: 55,
                            padding: const EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                                color: Color(0xFF720D5D),
                                border: focusedIndex == 0
                                    ? Border.all(
                                        width: 1,
                                        color: Colors.white,
                                      )
                                    : Border.all(
                                        width: 1,
                                        color: Color(0xFF720D5D),
                                      ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: amount,
                                    readOnly: true,
                                    onTap: () {
                                      setState(() {
                                        focusedIndex = 0;
                                      });
                                    },
                                    autofocus: true,
                                    showCursor: true,
                                    cursorColor: Colors.white.withOpacity(0.6),
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Icon(
                                    LineIcons.money,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ))),
                  ],
                ),
              ),
            ),
            Container(
              child: SizedBox(
                width: deviceSize.width,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: Container(
                          width: deviceSize.width - 30,
                          height: 55,
                          padding: const EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                              color: Color(0xFF720D5D),
                              border: focusedIndex == 1
                                  ? Border.all(
                                      width: 1,
                                      color: Colors.white,
                                    )
                                  : Border.all(
                                      width: 1,
                                      color: Color(0xFF720D5D),
                                    ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  onTap: () {
                                    setState(() {
                                      focusedIndex = 1;
                                    });
                                  },
                                  controller: tipPercent,
                                  readOnly: true,
                                  showCursor: true,
                                  cursorColor: Colors.white.withOpacity(0.6),
                                  decoration: InputDecoration.collapsed(
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Google',
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                      hintText: 'Tips in %'),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Google',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  '%',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Google',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Container(
              child: SizedBox(
                width: deviceSize.width,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: Container(
                          width: deviceSize.width - 30,
                          height: 55,
                          padding: const EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                              color: Color(0xFF720D5D),
                              border: focusedIndex == 2
                                  ? Border.all(
                                      width: 1,
                                      color: Colors.white,
                                    )
                                  : Border.all(
                                      width: 1,
                                      color: Color(0xFF720D5D),
                                    ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: noOfPeople,
                                  readOnly: true,
                                  onTap: () {
                                    setState(() {
                                      focusedIndex = 2;
                                    });
                                  },
                                  showCursor: true,
                                  cursorColor: Colors.white.withOpacity(0.6),
                                  decoration: InputDecoration.collapsed(
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Google',
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                      hintText: 'No of people'),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Google',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  LineIcons.user,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Container(
              width: deviceSize.width,
              constraints: BoxConstraints(maxHeight: 375),
              color: Color(0xFF270F33),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6),
                  ),
                  ButtonGrid2(
                    onTap: _onPressed,
                  )
                ],
              ),
            )
          ])),
    );
  }

  void _onPressed({String buttonText}) {
    String amount1 = textfieldOptions.elementAt(0).text;
    String rate1 = textfieldOptions.elementAt(1).text;
    String noPerson = textfieldOptions.elementAt(2).text;
    if (buttonText == Calculations.PERIOD) {
      return setState(() {
        String newDisplayString = '';
        if (focusedIndex == 0) {
          newDisplayString = amount1;
          amount.text = CalculationLogic.addPeriod(newDisplayString);
        } else if (focusedIndex == 1) {
          newDisplayString = rate1;
          tipPercent.text = CalculationLogic.addPeriod(newDisplayString);
        } else if (focusedIndex == 2) {
          newDisplayString = noPerson;
          noOfPeople.text = CalculationLogic.addPeriod(newDisplayString);
        }
      });
    } else if (buttonText == 'C') {
      return setState(() {
        String newDisplayString = '';
        if (focusedIndex == 0) {
          newDisplayString = amount1;
          if (amount1.length == 0) {
          } else {
            newDisplayString =
                newDisplayString.substring(0, amount1.length - 1);
          }
          amount.text = newDisplayString;
        } else if (focusedIndex == 1) {
          newDisplayString = rate1;
          if (rate1.length == 0) {
          } else {
            newDisplayString = newDisplayString.substring(0, rate1.length - 1);
          }
          tipPercent.text = newDisplayString;
        } else if (focusedIndex == 2) {
          newDisplayString = noPerson;
          if (noPerson.length == 0) {
          } else {
            newDisplayString =
                newDisplayString.substring(0, noPerson.length - 1);
          }
          noOfPeople.text = newDisplayString;
        }
      });
    } else if (buttonText == Calculations.EQUAL) {
      tips = CalculationLogic.calculateTip(
          textfieldOptions.elementAt(0).text,
          textfieldOptions.elementAt(1).text,
          textfieldOptions.elementAt(2).text);
      showCustomDialog(tips);
    } else {
      return setState(() {
        if (focusedIndex == 0)
          textfieldOptions.elementAt(focusedIndex).text += "$buttonText";
        else if (focusedIndex == 1)
          textfieldOptions.elementAt(focusedIndex).text += "$buttonText";
        else if (focusedIndex == 2)
          textfieldOptions.elementAt(focusedIndex).text += "$buttonText";
      });
    }
  }
}
