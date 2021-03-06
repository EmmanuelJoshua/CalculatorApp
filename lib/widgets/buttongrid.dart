import 'file:///C:/Users/DeLL/Documents/GitHub/CalculatorApp/lib/utils/calculationlogic.dart';
import 'package:flutter/material.dart';
import 'package:calculatorapp/widgets/custombuttons.dart';

class ButtonGrid extends StatelessWidget {
  const ButtonGrid({Key key, @required this.onTap}) : super(key: key);
  final CalculatorButtonTapCallback onTap;

  @override
  Widget build(BuildContext context) {
//    var deviceSize = MediaQuery.of(context).size;
    return Flexible(
      flex: 3,
      child: Container(
//      width: deviceSize.width,
//        height: deviceSize.height,
        padding: const EdgeInsets.only(top: 10),
        child: GridView.count(
          crossAxisCount: 4,
          childAspectRatio: 1.0,
          padding: const EdgeInsets.only(left: 20, right: 20),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            CustomButton(
              onTap: onTap,
              isClear: true,
            ),
            CustomButton(
              text: Calculations.CLEARALL,
              onTap: onTap,
              isOperation: true,
            ),
            CustomButton(
              text: Calculations.PERCENT,
              onTap: onTap,
              isOperation: true,
            ),
            CustomButton(
              text: Calculations.DIVIDE,
              onTap: onTap,
              isOperation: true,
            ),
            CustomButton(
              text: '7',
              onTap: onTap,
            ),
            CustomButton(
              text: '8',
              onTap: onTap,
            ),
            CustomButton(
              text: '9',
              onTap: onTap,
            ),
            CustomButton(
              text: Calculations.MULTIPLY,
              onTap: onTap,
              isOperation: true,
            ),
            CustomButton(
              text: '4',
              onTap: onTap,
            ),
            CustomButton(
              text: '5',
              onTap: onTap,
            ),
            CustomButton(
              text: '6',
              onTap: onTap,
            ),
            CustomButton(
              text: Calculations.SUBTRACT,
              onTap: onTap,
              isOperation: true,
            ),
            CustomButton(
              text: '1',
              onTap: onTap,
            ),
            CustomButton(
              text: '2',
              onTap: onTap,
            ),
            CustomButton(
              text: '3',
              onTap: onTap,
            ),
            CustomButton(
              text: Calculations.ADD,
              onTap: onTap,
              isOperation: true,
            ),
            CustomButton(
              text: '00',
              onTap: onTap,
            ),
            CustomButton(
              text: '0',
              onTap: onTap,
            ),
            CustomButton(
              text: Calculations.PERIOD,
              onTap: onTap,
            ),
            CustomButton(
              text: Calculations.EQUAL,
              onTap: onTap,
              isEqual: true,
            ),
          ],
        ),
      ),
    );
  }
}
