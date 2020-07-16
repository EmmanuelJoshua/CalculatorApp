import 'package:calculatorapp/utils/calculationlogic.dart';
import 'package:calculatorapp/utils/randomutils.dart';
import 'package:calculatorapp/widgets/buttongrid2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class GSTCalc extends StatefulWidget {
  @override
  _GSTCalcState createState() => _GSTCalcState();
}

class _GSTCalcState extends State<GSTCalc> {
  TextEditingControllerWorkaround gstamount =
      new TextEditingControllerWorkaround();
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
              elevation: 0,
              child: Container(
                  height: 235,
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
                                'Pre GST Amount ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Google',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                              trailing: Text(
                                  formatCurrency("INR", double.parse(pregst)),
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
                                'Total GST: ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Google',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                              trailing: Text(
                                formatCurrency("INR", double.parse(totalgst)),
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
      physics: BouncingScrollPhysics(),
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
                            border: Border.all(
                              width: 1,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: gstamount,
                                readOnly: true,
                                showCursor: true,
                                autofocus: true,
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
                  border: Border.all(
                    width: 1,
                    color: Colors.white,
                  ),
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
          Padding(padding: const EdgeInsets.all(7)),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 16, right: 15),
                    width: deviceSize.width - 31,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ChoiceChip(
                          label: Text('Exclusive'),
                          avatar: selectValue == 0
                              ? Icon(
                                  LineIcons.check_circle,
                                  color: selectValue == 0
                                      ? Color(0xFF270F33)
                                      : Colors.white,
                                )
                              : null,
                          selectedColor: Colors.white,
                          pressElevation: 0,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          backgroundColor: Color(0xFF720D5D),
                          padding: const EdgeInsets.all(14),
                          labelStyle: TextStyle(
                              color: selectValue == 0
                                  ? Color(0xFF270F33)
                                  : Colors.white,
                              fontFamily: 'Google',
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          selected: selectValue == 0,
                          onSelected: (value) {
                            setState(() {
                              selectValue = value ? 0 : 0;
                              handleChipChange(selectValue);
                            });
                          },
                        ),
                        Padding(padding: const EdgeInsets.all(5)),
                        ChoiceChip(
                          avatar: selectValue == 1
                              ? Icon(
                                  LineIcons.check_circle,
                                  color: selectValue == 1
                                      ? Color(0xFF270F33)
                                      : Colors.white,
                                )
                              : null,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          label: Text('Inclusive'),
                          selectedColor: Colors.white,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          backgroundColor: Color(0xFF720D5D),
                          padding: const EdgeInsets.all(14),
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
                        )
                      ],
                    )),
              ],
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
        ]),
      ),
    );
  }

  void _onPressed({String buttonText}) {
    String displayString1 = gstamount.text.toString();
    String mainRate = rate1.substring(0, rate1.length - 1);
    if (buttonText == Calculations.PERIOD) {
      return setState(() {
        gstamount.text = CalculationLogic.addPeriod(displayString1);
      });
    } else if (buttonText == 'C') {
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
