import 'package:flutter/material.dart';

typedef void CalculatorButtonTapCallback({String buttonText});

class CustomButton2 extends StatelessWidget {
  CustomButton2({this.text, this.onTap});

  final String text;
  final CalculatorButtonTapCallback onTap;

  @override
  Widget build(BuildContext context) {
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
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            padding: EdgeInsets.all(15),
            // color: Color(0xFF324B50),
            highlightColor: Colors.blueGrey[100],
            splashColor: Color(0xFF137690),
          ));

  }
}
