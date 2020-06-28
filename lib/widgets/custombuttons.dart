import 'package:flutter/material.dart';

typedef void CalculatorButtonTapCallback({String buttonText});

class CustomButton extends StatelessWidget {
  CustomButton(
      {this.text,
      @required this.onTap,
      this.isOperation: false,
      this.isEqual: false,
      this.isClear: false});

  final String text;
  final bool isOperation;
  final bool isEqual;
  final bool isClear;
  final CalculatorButtonTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (isOperation) {
      return Container(
          child: FloatingActionButton(
        onPressed: () => onTap(buttonText: text),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: 'Google',
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white12,
        splashColor: Colors.blueGrey[100],
      ));
    } else if (isClear) {
      return Container(
        child: FloatingActionButton(
          onPressed: () => onTap(buttonText: text),
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
    } else if (isEqual) {
      return Container(
        child: FloatingActionButton(
          onPressed: () => onTap(buttonText: 'C'),
          child: Text(
            text,
            style: TextStyle(
                fontFamily: 'Google',
                fontSize: 25,
                fontWeight: FontWeight.w400,
                color: Color(0xFFAEAEAE)),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          splashColor: Colors.blueGrey[100],
        ),
      );
    } else {
      return Container(
          child: FloatingActionButton(
        onPressed: () => onTap(buttonText: text),
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'Google',
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: Color(0xFFAEAEAE)),
        ),
        elevation: 0,
        backgroundColor: Colors.white12,
        splashColor: Colors.blueGrey[100],
      ));
    }
  }
}
