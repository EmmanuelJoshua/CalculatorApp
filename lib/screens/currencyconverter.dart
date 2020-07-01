import 'package:calculatorapp/models/currencyrates.dart';
import 'package:calculatorapp/utils/calculationlogic.dart';
import 'package:calculatorapp/utils/constants.dart';
import 'package:calculatorapp/utils/networkutil.dart';
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
  Future<Currency> customerData;
  Currency currencyData;

  void loadRates(String country) async {
    try{
      currencyData = await getRate(country);
    }catch(e){
      print('Exc');
    }
    setState(() {
      if (currencyData != null) {
        displayString2 = CalculationLogic.convertCurrency(
            currencyData.rates[currentSelection2].toString(), displayString1);
      } else {
        showErrorModal();
        print('check your internet');
      }
    });
  }

  showErrorModal(){
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
                  width: 120,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LineIcons.exclamation,
                          size: 80,
                          color: Colors.white,
                        ),
                        Padding(padding: const EdgeInsets.all(5)),
                        Text(
                          'No Internet Connection',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Google',
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                        Padding(padding: const EdgeInsets.all(5)),

                      ],
                    ),
                  )));
        });
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Container(
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
                        child: DropdownButton(
                          onChanged: (newSelection) {
                            setState(() {
                              currentSelection1 = newSelection;
                            });
                          },
                          icon: Icon(Icons.keyboard_arrow_down),
                          underline: Container(),
                          elevation: 1,
                          dropdownColor: Color(0xFF3C174D),
                          value: currentSelection1,
                          items: currencies
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
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          displayString1,
                          style: TextStyle(
                              color: Color(0xFF270F33),
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
                color: Color(0xFF270F33),
                child: SizedBox(
                  height: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DropdownButton(
                          onChanged: (newSelection) {
                            setState(() {
                              currentSelection2 = newSelection;
                            });
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                          underline: Container(),
                          value: currentSelection2,
                          elevation: 1,
                          dropdownColor: Color(0xFF3C174D),
                          items: currencies
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Google',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          displayString2,
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
                width: deviceSize.width,
                height: deviceSize.height,
                color: Color(0xFF270F33),
                child: ListView(
                  children: [
//                    Divider(color: Colors.white,),
                    ButtonGrid2(
                      onTap: _onPressed,
                    )
                  ],
                ),
              ))
            ],
          ),
          Container(
//            width: 100,
            margin: const EdgeInsets.only(bottom: 390),
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
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFFD46286),
                          Color(0xFF781C50),
                        ],
                        tileMode: TileMode.mirror,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
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
    );
  }

  void _onPressed({String buttonText}) {
    if (displayString1 == '0.00') {
      displayString1 = '';
    }
    if (buttonText == 'C') {
      return setState(() {
        String newDisplayString = displayString1;
        if (displayString1.length == 0) {
          displayString1 = '0.00';
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
        displayString1 += "$buttonText";
        debugPrint('$displayString1');
      });
    }
  }
}
