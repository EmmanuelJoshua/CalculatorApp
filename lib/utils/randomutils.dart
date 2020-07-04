import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextEditingControllerWorkaround extends TextEditingController {
  TextEditingControllerWorkaround({String text}) : super(text: text);

  void setTextAndPosition(String newText, {int caretPosition}) {
    int offset = caretPosition != null ? caretPosition : newText.length;
    value = value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: offset),
        composing: TextRange.empty);
  }

  set text(String newText) {
    setTextAndPosition(newText);
  }
}

String formatCurrency(String country, double number) =>
    NumberFormat.simpleCurrency(name: country, decimalDigits: 2).format(number);

String formatDecimal(double number) =>
    NumberFormat('#########0.0').format(number);

String currencySymbol(String currencyCode) =>
    NumberFormat().simpleCurrencySymbol(currencyCode);

double parseTextAndReplace(String text) =>
    double.parse(text.replaceAll(",", "."));

bool dateIsBeforeToday(String date) {
  DateFormat format = new DateFormat("yyyy-MM-dd");
  var today = format.parse(format.format(DateTime.now()));
  var check = format.parse(date);
  return check.isBefore(today);
}