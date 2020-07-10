import 'package:calculatorapp/widgets/custombuttons2.dart';
import 'package:flutter/material.dart';

class ButtonGrid2 extends StatelessWidget {
  const ButtonGrid2({Key key, @required this.onTap}) : super(key: key);
  final ConverterButtonTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
     return Column(
       children: [
         Container(
           constraints: BoxConstraints(maxHeight: 355),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
              childAspectRatio: 1.08,
              padding: const EdgeInsets.only(left: 35, right: 35),
              mainAxisSpacing: 9.5,
              crossAxisSpacing: 13,
                children: <Widget>[
                  CustomButton2(
                    text: '1',
                    onTap: onTap,
                  ),
                  CustomButton2(
                    text: '2',
                    onTap: onTap,
                  ),
                  CustomButton2(
                    text: '3',
                    onTap: onTap,
                  ),
                  CustomButton2(
                    text: '4',
                    onTap: onTap,
                  ),
                  CustomButton2(
                    text: '5',
                    onTap: onTap,
                  ),
                  CustomButton2(
                    text: '6',
                    onTap: onTap,
                  ),
                  CustomButton2(
                    text: '7',
                    onTap: onTap,
                  ),
                  CustomButton2(
                    text: '8',
                    onTap: onTap,
                  ),
                  CustomButton2(
                    text: '9',
                    onTap: onTap,
                  ),
                  CustomButton2(
                    onTap: onTap,
                    isClear: true,
                  ),
                  CustomButton2(
                    text: '0',
                    onTap: onTap,
                  ),
                  CustomButton2(
                    onTap: onTap,
                    isEqual: true,
                  ),
                ],
              ),
    ),
       ],
     );
  }
}
