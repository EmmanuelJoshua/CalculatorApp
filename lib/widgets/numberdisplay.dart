import 'package:flutter/material.dart';

class NumberDisplay extends StatelessWidget {
  NumberDisplay({this.displayString: '', this.resultString: ''});

  final String displayString;
  final String resultString;

  @override
  Widget build(BuildContext context) {
    return Flexible(
//      flex: 1,
      child: Container(
          padding: const EdgeInsets.only(top: 4),
        color: Color(0xFFFAFAFA),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(top: 10.0, right: 20.0),
              child: new Text(
                displayString,
                overflow: TextOverflow.fade,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'Google',
                  color: Color(0xFF909090),
                  fontSize: 30.0,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            new Padding(
              padding: new EdgeInsets.only(right: 15.0, bottom: 15.0),
              child: new Text(
                resultString,
                overflow: TextOverflow.fade,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'Google',
                  color: Color(0xFF4E4E4E),
                  fontSize: 55.0,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
