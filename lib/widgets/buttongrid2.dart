import 'package:calculatorapp/widgets/custombuttons2.dart';
import 'package:flutter/material.dart';

class ButtonGrid2 extends StatelessWidget {
  const ButtonGrid2({Key key}) : super(key: key);
//  final CalculatorButtonTapCallback onTap;

  @override
  Widget build(BuildContext context) {
     return Container(
          height: 370,
          width: 100,
          child: GridView.count(
            crossAxisCount: 3,
          childAspectRatio: 1.0,
          padding: const EdgeInsets.only(left: 30, right: 30),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 8.0,
            children: <Widget>[
              CustomButton2(
                text: '1',
              ),
              CustomButton2(
                text: '2',
              ),
              CustomButton2(
                text: '3',
              ),
              CustomButton2(
                text: '4',
              ),
              CustomButton2(
                text: '5',
              ),
              CustomButton2(
                text: '6',
              ),
              CustomButton2(
                text: '7',
              ),
              CustomButton2(
                text: '8',
              ),
              CustomButton2(
                text: '9',
              ),
              CustomButton2(
                text: '.',
              ),
              CustomButton2(
                text: '0',
              ),
              CustomButton2(
                text: '9',
              ),
            ],
          ),
    );
  }
}
