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
  String rate1 = 'USD';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
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
                          onChanged: (text) {},
                          icon: Icon(Icons.keyboard_arrow_down),
                          underline: Container(),
                          elevation: 1,
                          value: rate1,
                          items: <String>['USD', 'CAD']
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
                          onChanged: (text) {},
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                          underline: Container(),
                          value: rate1,
                          elevation: 1,
                          dropdownColor: Color(0xFF4E4E4E),
                          items: <String>['USD', 'CAD']
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
                width: double.infinity,
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
    } else if (buttonText == 'C') {
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
    } else if (buttonText == 'Equal') {
      return setState(() {
        displayString2 = displayString1;
      });
    } else {
      return setState(() {
        displayString1 += "$buttonText";
        debugPrint('$displayString1');
      });
    }
  }
}
