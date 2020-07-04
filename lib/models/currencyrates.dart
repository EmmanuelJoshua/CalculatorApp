class Currency {
  final String baseValue;
  final String base;
  final String date;
  final Map<String, dynamic> rates;

  Currency(
      {this.baseValue, this.base, this.rates, this.date});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      base: json['base'],
      baseValue: json['baseValue'],
      rates: json['rates'],
      date: json["date"],
    );
  }

  Map<dynamic, dynamic> toMap() => {
    'base': base,
    'baseValue': baseValue,
    'rates': rates,
    'date' : date
  };
}

