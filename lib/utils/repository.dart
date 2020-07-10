import 'dart:async';
import 'dart:convert';

import 'package:calculatorapp/models/currencyrates.dart';
import 'package:calculatorapp/utils/networkutil.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  Currency _exchangeRate;

  var _encoder = JsonEncoder();
  var _decoder = JsonDecoder();

  final Future<SharedPreferences> sharedPreferences =
  SharedPreferences.getInstance();

  static const String EXCHANGE_RATES = "EXCHANGE_RATES_";

  _saveLocalExchangeRates(Currency rates) async {
    SharedPreferences pref = await sharedPreferences;
    var json = _encoder.convert(rates.toMap());
    pref.setString(EXCHANGE_RATES + rates.base, json);
  }

  _getLocalExchangeRates(String base) async {
    SharedPreferences pref = await sharedPreferences;
    var shared = pref.getString(EXCHANGE_RATES + base);
    var map = _decoder.convert(shared);
    return Currency.fromJson(map);
  }

  _getRemoteExchangeRates(String base) async {
    Completer<Null> completer = new Completer<Null>();
    getRate(Client(), base).then((obj) {
      if (obj != null) {
        print('Save method');
        _saveLocalExchangeRates(obj);
        _exchangeRate = obj;
      }
      completer.complete();
    });

    return completer.future;
  }

  getExchangeRate(String base) async {
    await _getRemoteExchangeRates(base);
    _exchangeRate = await _getLocalExchangeRates(base);
//    if (_exchangeRate == null ||
//        (_exchangeRate != null && dateIsBeforeToday(_exchangeRate.date))) {
//      print('Entered date is before today condition!');
//      await _getRemoteExchangeRates(base);
//    }
    return _exchangeRate;
  }
}
