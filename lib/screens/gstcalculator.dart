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
  String rate1 = '5%';
  int selectValue = 0;
  List<String> gstAmounts;
  bool gstInclusive = false;

  void handleChipChange(int value) {
    setState(() {
      switch (value) {
        case 0:
          gstInclusive = false;
          break;
        case 1:
          gstInclusive = true;
          break;
      }
    });
  }

  showCustomDialog(List<String> billList) {
    String pregst = billList[0];
    String totalgst = billList[1];
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Color(0xFF270F33),
              elevation: 0,
              child: Container(
                  height: 210,
                  width: 150,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LineIcons.check_circle,
                          size: 80,
                          color: Colors.white,
                        ),
                        Padding(padding: const EdgeInsets.all(5)),
                        Text(
                          'Pre GST Amount: \$$pregst',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Google',
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                        Padding(padding: const EdgeInsets.all(5)),
                        Text(
                          'Total GST: \$$totalgst',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Google',
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )));
        });
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Container(
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
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: Row(
                        children: [
                          Expanded(
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              LineIcons.money,
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
        Padding(padding: const EdgeInsets.all(5)),
        Container(
//          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.only(left: 14),
            width: deviceSize.width - 30,
            height: 55,
            decoration: BoxDecoration(
                color: Color(0xFF720D5D),
                borderRadius: BorderRadius.all(Radius.circular(7))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: deviceSize.width - 50,
                  child: DropdownButton(
                    onChanged: (text) {
                      setState(() {
                        rate1 = text;
                      });
                    },
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    underline: Container(),
                    elevation: 1,
                    dropdownColor: Color(0xFF3C174D),
                    value: rate1,
                    items: <String>['5%', '12%', '18%', '28%', '36%']
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
                      Expanded(
                        child: ChoiceChip(
                          label: Text('Exclusive'),
                          avatar: Icon(
                            LineIcons.check_circle,
                            color: selectValue == 0
                                ? Color(0xFF270F33)
                                : Colors.white,
                          ),
                          selectedColor: Colors.white,
                          pressElevation: 0,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          backgroundColor: Color(0xFF720D5D),
                          padding: const EdgeInsets.all(12),
                          labelStyle: TextStyle(
                              color: selectValue == 0
                                  ? Color(0xFF270F33)
                                  : Colors.white,
                              fontFamily: 'Google',
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Color(0xFF720D5D)),
                              borderRadius: BorderRadius.all(Radius.circular(7))),
                          selected: selectValue == 0,
                          onSelected: (value) {
                            setState(() {
                              selectValue = value ? 0 : 0;
                              handleChipChange(selectValue);
                            });
                          },
                        ),
                      ),
                      Padding(padding: const EdgeInsets.all(5)),
                      Expanded(
                        child: ChoiceChip(
                          avatar: Icon(
                            LineIcons.check_circle,
                            color: selectValue == 1
                                ? Color(0xFF270F33)
                                : Colors.white,
                          ),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Color(0xFF720D5D)),
                              borderRadius: BorderRadius.all(Radius.circular(7))),
                          label: Text('Inclusive'),
                          selectedColor: Colors.white,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          backgroundColor: Color(0xFF720D5D),
                          padding: const EdgeInsets.all(12),
                          labelStyle: TextStyle(
                              color: selectValue == 1
                                  ? Color(0xFF270F33)
                                  : Colors.white,
                              fontFamily: 'Google',
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                          selected: selectValue == 1,
                          onSelected: (value) {
                            setState(() {
                              selectValue = value ? 1 : 1;
                              handleChipChange(selectValue);
                            });
                          },
                        ),
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
                padding: const EdgeInsets.all(3),
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
    String mainRate = rate1.substring(0, rate1.length - 1);
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
    } else if (buttonText == Calculations.EQUAL) {
      if (gstamount.text != null)
        gstAmounts = CalculationLogic.calculateGST(
            gstamount.text, mainRate, gstInclusive);
      showCustomDialog(gstAmounts);
    } else {
      return setState(() {
        gstamount.text += "$buttonText";
      });
    }
  }
}
