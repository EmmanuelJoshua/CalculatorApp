import 'package:flutter/material.dart';

typedef void CalculatorButtonTapCallback({String buttonText});

class CustomButton extends StatelessWidget {
  CustomButton({this.text, @required this.onTap, this.isOperation: false});

  final String text;
  final bool isOperation;
  final CalculatorButtonTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (isOperation) {
      return Container(
          child: FlatButton(
        onPressed: () => onTap(buttonText: text),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'Google',
          ),
        ),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.all(19),
        // color: Color(0xFF21292B),
        highlightColor: Colors.blueGrey[100],
        splashColor: Color(0xFF324B50),
      ));
    } else {
      return Container(
          child: FlatButton(
        onPressed: () => onTap(buttonText: text),
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'Google',
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: Color(0xFFAEAEAE)),
        ),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.all(15),
        // color: Color(0xFF324B50),
        highlightColor: Colors.blueGrey[100],
        splashColor: Color(0xFF137690),
      ));
    }
  }
}
