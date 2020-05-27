import 'package:flutter/material.dart';

class NumberDisplay extends StatelessWidget {
  const NumberDisplay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.only(top: 100.0, right: 20.0),
          child: new Text(
            "5 + 5",
            overflow: TextOverflow.fade,
            maxLines: 1,
            style: TextStyle(
              color: Color(0xFFD8E5ED),
              fontSize: 30.0,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.end,
          ),
        ),
        new Padding(
          padding: new EdgeInsets.only(right: 15.0, bottom: 15.0),
          child: new Text(
            "100",
            overflow: TextOverflow.fade,
            maxLines: 1,
            style: TextStyle(
              fontSize: 55.0,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
