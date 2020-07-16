import 'package:calculatorapp/models/currencyrates.dart';
import 'package:calculatorapp/utils/calculationlogic.dart';
import 'package:calculatorapp/utils/constants.dart';
import 'package:calculatorapp/utils/randomutils.dart';
import 'package:calculatorapp/utils/repository.dart';
import 'package:calculatorapp/widgets/buttongrid2.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  String displayString1 = '0.00';
  String displayString2 = '0.00';
  String currentSelection1 = 'USD';
  String currentSelection2 = 'EUR';
  var currencies = countryNameMap.keys.toList();
  Currency currencyData;
  TextEditingControllerWorkaround valueController =
      new TextEditingControllerWorkaround();

  @protected
  Repository repository = new Repository();

  void loadRates(String country) async {
    try {
      currencyData = await repository.getExchangeRate(country);
    } catch (e) {
      showErrorModal();
    }
    setState(() {
      if (currencyData != null) {
        displayString2 = CalculationLogic.convertCurrency(
            currencyData.rates[currentSelection2].toString(), displayString1);
      } else {}
    });
  }

  showSelectionModal(int select) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetAnimationCurve: Curves.easeIn,
            insetAnimationDuration: Duration(milliseconds: 400),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(colors: [
                  Color(0xFFD46286),
                  Color(0xFF781C50),
                ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
              ),
              height: 340,
              width: 120,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                  itemCount: currencies.length,
                  separatorBuilder: (context, position) => Divider(
                        color: Colors.white.withOpacity(0.3),
                      ),
                  itemBuilder: (BuildContext context, int position) {
                    return ListTile(
                      onTap: () {
                        setState(() {
                          switch (select) {
                            case 0:
                              currentSelection1 =
                                  countryNameMap.keys.elementAt(position);
                              loadRates(currentSelection1);
                              break;
                            case 1:
                              currentSelection2 =
                                  countryNameMap.keys.elementAt(position);
                              loadRates(currentSelection1);
                              break;
                          }
                        });
                        Navigator.of(context).pop();
                      },
                      trailing: CircleAvatar(
                        backgroundColor: Color(0xFF270F33).withOpacity(0.6),
                        child: Text(
                          currencySymbol(
                              countryNameMap.keys.elementAt(position)),
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Google',
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      title: Text(
                        countryNameMap.keys.elementAt(position),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Google',
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        countryNameMap.values.elementAt(position),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Google',
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    );
                  }),
            ),
          );
        });
  }

  showErrorModal() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              child: Container(
                  height: 160,
                  width: 120,
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
                            LineIcons.exclamation_circle,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: ListTile(
                          title: Text(
                            'No Internet Connection!',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Google',
                                fontSize: 17,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  )));
        });
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    valueController.text = "$displayString1";
    double marginTop = 75;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        color: Color(0xFF270F33),
        width: deviceSize.width,
        constraints: BoxConstraints(minHeight: deviceSize.height - 140),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: Color(0xFFFAFAFA),
                  child: SizedBox(
                    height: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            width: 200,
                            child: TextField(
                              controller: valueController,
                              style: TextStyle(
                                  color: Color(0xFF270F33),
                                  fontFamily: 'Google',
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixText:
                                    currencySymbol(currentSelection1) + ' ',
                                prefixStyle: TextStyle(
                                    color: Color(0xFF270F33).withOpacity(0.8),
                                    fontFamily: 'Google',
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400),
                              ),
                              readOnly: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () {
                              showSelectionModal(0);
                            },
                            child: Row(
                              children: [
                                Text(
                                  currentSelection1,
                                  style: TextStyle(
                                      color: Color(0xFF3C174D),
                                      fontFamily: 'Google',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                ),
                                Icon(
                                  LineIcons.arrow_circle_down,
                                  color: Color(0xFF3C174D),
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Color(0xFF270F33),
                  child: SizedBox(
                    height: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {
                              showSelectionModal(1);
                            },
                            child: Row(
                              children: [
                                Text(
                                  currentSelection2,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Google',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                ),
                                Icon(
                                  LineIcons.arrow_circle_up,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: RichText(
                            text: TextSpan(text: '', children: [
                              new TextSpan(children: [
                                TextSpan(
                                  text: currencySymbol(currentSelection2),
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontFamily: 'Google',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                    text: ' ' + displayString2,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Google',
                                        fontSize: 40,
                                        fontWeight: FontWeight.w400)),
                              ])
                            ]),
                          ),
                        ),
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
                        padding: const EdgeInsets.all(3),
                      ),
                      ButtonGrid2(
                        onTap: _onPressed,
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: marginTop),
              alignment: Alignment.topCenter,
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(35))),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFFD46286),
                            Color(0xFF781C50),
                          ],
                          tileMode: TileMode.mirror,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                  child: Icon(
                    LineIcons.refresh,
                    color: Colors.white,
                    size: 27,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressed({String buttonText}) {
    String displayStringMeth = displayString1;
    if (displayStringMeth == '0.00') {
      displayStringMeth = '';
    }
    if (buttonText == Calculations.PERIOD) {
      return setState(() {
        displayString1 = CalculationLogic.addPeriod(displayStringMeth);
      });
    } else if (buttonText == 'C') {
      return setState(() {
        String newDisplayString = displayString1;
        if (displayString1.length == 1) {
          newDisplayString = '0.00';
        } else {
          newDisplayString =
              newDisplayString.substring(0, displayString1.length - 1);
        }
        displayString1 = newDisplayString;
      });
    } else if (buttonText == '=') {
      return setState(() {
        loadRates(currentSelection1);
      });
    } else {
      return setState(() {
        displayStringMeth += "$buttonText";
        displayString1 = displayStringMeth;
      });
    }
  }
}
