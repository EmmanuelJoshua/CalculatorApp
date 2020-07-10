import 'dart:convert';
import 'package:calculatorapp/models/currencyrates.dart';
import 'package:http/http.dart';

Future<Currency> getRate(Client client, String base) async {
  const String URL_LATEST_BASE = "https://api.exchangeratesapi.io/latest?base=";
  final Response response = await client.get(URL_LATEST_BASE + base);

  if (response == null) throw new Exception('Response is null');
  if (response.statusCode < 200 || response.statusCode > 400) {
    throw Exception("test stuff"+response.body);
  } else {
    return Currency.fromJson(json.decode(response.body));
  }
}
