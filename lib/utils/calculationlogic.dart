import 'package:calculatorapp/models/historymodel.dart';
import 'package:calculatorapp/utils/dbhelper.dart';
import 'package:function_tree/function_tree.dart';

class Calculations {
  static const PERIOD = '.';
  static const MULTIPLY = '*';
  static const SUBTRACT = '-';
  static const ADD = '+';
  static const DIVIDE = '/';
  static const PERCENT = '%';
  static const CLEARALL = 'CE';
  static const CLEAR = 'C';
  static const EQUAL = '=';
  static const OPERATIONS = [
    Calculations.ADD,
    Calculations.MULTIPLY,
    Calculations.SUBTRACT,
    Calculations.DIVIDE,
    Calculations.PERCENT
  ];

  static double percent(double a) => a / 100;
}

class CalculationLogic {
  static addExpression(String ex) async {
    HistoryModel historyModel = HistoryModel(expression: ex);
    await DatabaseHelper.dbhelp.saveExpression(historyModel);
  }

  static String parseString(String text) {
    List<String> numbersToAdd;
    double a, result;
    double res;
    if (text.contains(Calculations.ADD) ||
        text.contains(Calculations.MULTIPLY) ||
        text.contains(Calculations.DIVIDE) ||
        text.contains(Calculations.SUBTRACT)) {
      final expressions = [text];
      for (final expression in expressions) {
        res = double.parse(expression.interpret().toString());
        String express = " $expression = ${expression.interpret()} ";
        addExpression(express);
      }
      result = res;
    } else if (text.contains(Calculations.PERCENT)) {
      numbersToAdd = text.split(Calculations.PERCENT);
      a = double.parse(numbersToAdd[0]);
      result = Calculations.percent(a);

      String aT = a.truncate().toString();
      String express = " $aT% = $result";
      addExpression(express);
    } else {
      return text;
    }

    try {
      double parsedNumber = double.parse(result.toString());

      if ((parsedNumber != double.infinity) &&
              text.contains(Calculations.ADD) ||
          text.contains(Calculations.MULTIPLY) ||
          text.contains(Calculations.DIVIDE) ||
          text.contains(Calculations.SUBTRACT)) {
        if (parsedNumber == parsedNumber.floor()) {
          return parsedNumber.truncate().toString();
        } else {
          return parsedNumber.toString();
        }
      } else if ((parsedNumber != double.infinity)) {
        return parsedNumber.toString();
      }

      return text;
    } catch (err) {
      return text;
    }
  }

  static String addPeriod(String calculatorString) {
    if (calculatorString.isEmpty) {
      return calculatorString = '0${Calculations.PERIOD}';
    }

    RegExp exp = new RegExp(r"\d\.");
    Iterable<Match> matches = exp.allMatches(calculatorString);
    int maxMatches =
        CalculationLogic.includesOperation(calculatorString) ? 2 : 1;

    return matches.length == maxMatches
        ? calculatorString
        : calculatorString += Calculations.PERIOD;
  }

  static bool includesOperation(String calculatorString) {
    for (var operation in Calculations.OPERATIONS) {
      if (calculatorString.contains(operation)) {
        return true;
      }
    }

    return false;
  }

  static String calculateTip(String price, String percent, String noPeople) {
    int price1 = int.parse(price);
    int percent1 = int.parse(percent);
    int noPeople1 = int.parse(noPeople);

    double percentage = (100 + percent1) / 100;
    double tip = (percentage * price1) / noPeople1;
    String tips = tip.toStringAsFixed(2);
    return tips;
  }

  static void calculateGST(String price, String rate, bool gstInclusive){
    int price1 = int.parse(price);
    int rate1 = int.parse(rate);
    double netprice;
    String gst;
    if(gstInclusive){
      double gstamount = price1 - (price1*(100/(100 + rate1)));
      netprice = price1 - gstamount;
      gst = netprice.toStringAsFixed(2);

    }else{
      double gstamount = (price1*rate1)/100;
      netprice = price1 + gstamount;
      gst = netprice.toStringAsFixed(2);
    }
    print(gst);
  }

  static String convertCurrency(String rate, String amount){
    double rate1 = double.parse(rate);
    double amount1 = double.parse(amount);
    double output1 = rate1 * amount1;
    String output2 = output1.toStringAsFixed(2);
    return output2;
  }
}
