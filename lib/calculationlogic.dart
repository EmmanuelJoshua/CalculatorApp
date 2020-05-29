// import 'package:function_tree/function_tree.dart';

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

  static double add(double a, double b) => a + b;
  static double subtract(double a, double b) => a - b;
  static double divide(double a, double b) => a / b;
  static double multiply(double a, double b) => a * b;
  static double percent(double a) => a / 100;
}

class CalculationLogic {
  static String parseString(String text) {
    List<String> numbersToAdd;
    List<int> numbers = [];
    double a, b, result;
    if (text.contains(Calculations.ADD)) {
      // final expressions = [text];
      // for (final expression in expressions) {
      //   // print(" '$expression' = ${expression.interpret()} ");
      // }
       numbersToAdd = text.split(Calculations.ADD);
      a = double.parse(numbersToAdd[0]);
      b = double.parse(numbersToAdd[1]);

      result = Calculations.add(a, b);
      // print(numbers);
    } else if (text.contains(Calculations.MULTIPLY)) {
      numbersToAdd = text.split(Calculations.MULTIPLY);
      a = double.parse(numbersToAdd[0]);
      b = double.parse(numbersToAdd[1]);

      result = Calculations.multiply(a, b);
    } else if (text.contains(Calculations.DIVIDE)) {
      numbersToAdd = text.split(Calculations.DIVIDE);
      a = double.parse(numbersToAdd[0]);
      b = double.parse(numbersToAdd[1]);

      result = Calculations.divide(a, b);
    } else if (text.contains(Calculations.SUBTRACT)) {
      numbersToAdd = text.split(Calculations.SUBTRACT);
      a = double.parse(numbersToAdd[0]);
      b = double.parse(numbersToAdd[1]);

      result = Calculations.subtract(a, b);
    } else if (text.contains(Calculations.PERCENT)) {
      numbersToAdd = text.split(Calculations.PERCENT);
      a = double.parse(
          numbersToAdd[0].substring(0, numbersToAdd[0].length - 1));

      result = Calculations.percent(a);
      print(result);
    } else {
      return text;
    }

    try {
      double parsedNumber = double.parse(result.toString());

      if ((parsedNumber != double.infinity) &&
          text.contains(Calculations.MULTIPLY)) {
        // parsedNumber.;
        return parsedNumber.truncate().toString();
      } else if ((parsedNumber != double.infinity) &&
          text.contains(Calculations.DIVIDE)) {
        if (parsedNumber == parsedNumber.floor()) {
          return parsedNumber.truncate().toString();
        } else {
          return parsedNumber.toString();
        }
      } else if ((parsedNumber != double.infinity) &&
          text.contains(Calculations.ADD)) {
        if (parsedNumber == parsedNumber.floor()) {
          return parsedNumber.truncate().toString();
        } else {
          return parsedNumber.toString();
        }
      } else if ((parsedNumber != double.infinity) &&
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
