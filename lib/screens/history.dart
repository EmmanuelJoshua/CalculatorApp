import 'package:calculatorapp/models/historymodel.dart';
import 'package:flutter/material.dart';
import 'package:calculatorapp/controlhistory.dart';

class CalcHistory extends StatefulWidget {
  @override
  _CalcHistoryState createState() => _CalcHistoryState();
}

class _CalcHistoryState extends State<CalcHistory> {

  ControlHistory controlHistory = ControlHistory();
  HistoryModel historySave = HistoryModel();
  HistoryModel historyLoad = HistoryModel();

  @override
  void initState() {
    historySave.expression = '5+5';
    historySave.image = 'img';
    historySave.notes = 'Maths';
    controlHistory.saveHistory('Hi', historySave);
    historyLoad = HistoryModel.fromJson( controlHistory.viewHistory('Hi'));
    print(historyLoad.expression);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('History', style: TextStyle(
            color: Colors.white,
            fontFamily: 'Google',
            fontSize: 20,
            fontWeight: FontWeight.w400),
        ),
          backgroundColor: Color(0xFF4E4E4E),
      ),
      body: Container(),
    );
  }
}
