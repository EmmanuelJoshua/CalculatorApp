import 'package:calculatorapp/utils/calculationlogic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void ConverterButtonTapCallback({String buttonText});

class CustomButton2 extends StatelessWidget {
  CustomButton2(
      {this.text, this.onTap, this.isEqual: false, this.isClear: false});

  String text;
  final ConverterButtonTapCallback onTap;
  final bool isEqual;
  final bool isClear;

  @override
  Widget build(BuildContext context) {
    if (isClear)
      return Container(
        child: FloatingActionButton(
          heroTag: null,
          onPressed: () => onTap(buttonText: 'C'),
          child: Icon(
            Icons.backspace,
            color: Color(0xFFAEAEAE),
            size: 24,
          ),
          elevation: 0,
          backgroundColor: Colors.white12,
          splashColor: Colors.blueGrey[100],
        ),
      );
    else if (!isEqual)
      return Container(
        child: InkWell(
          onLongPress: (){
            if(text == '0')onTap(buttonText: Calculations.PERIOD);
            else onTap(buttonText: text);
          },
          child: FloatingActionButton(
            heroTag: null,
            focusColor: Colors.blueGrey[100],
            onPressed: () => onTap(buttonText: text),

            child: Text(
            text == '0' ? '0.' : text,
              style: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFAEAEAE)),
            ),
            backgroundColor: Colors.white12,
            elevation: 0,
            splashColor: Colors.blueGrey[100],
          ),
        ),
      );
    else
      return Container(
        child: FloatingActionButton(
          heroTag: null,
          onPressed: () => onTap(buttonText: Calculations.EQUAL),
          child: Icon(
            Icons.check,
            color: Color(0xFF4E4E4E),
            size: 24,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          splashColor: Colors.blueGrey[100],
        ),
      );
  }
}
