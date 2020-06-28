import 'dart:convert';
import 'package:calculatorapp/models/currencyrates.dart';
import 'package:http/http.dart';

Future<Currency> getRate(String base) async {
  const String URL_LATEST_BASE = "https://api.exchangeratesapi.io/latest?base=";

  final Response response = await get(URL_LATEST_BASE+base);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load customer data');
  }
}
