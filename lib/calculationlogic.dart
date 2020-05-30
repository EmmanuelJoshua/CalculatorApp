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
        print(" '$expression' = ${expression.interpret()} ");
      }
      result = res;
    } else if (text.contains(Calculations.PERCENT)) {
      numbersToAdd = text.split(Calculations.PERCENT);
      a = double.parse(numbersToAdd[0]);

      result = Calculations.percent(a);
      print(result);
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
}
