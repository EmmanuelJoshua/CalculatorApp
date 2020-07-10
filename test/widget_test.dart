import 'package:calculatorapp/utils/randomutils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Group test', (){
    test('Test formatCurrency', () {
      var test1 = formatCurrency("EUR", 12.25);
      var test2 = formatCurrency("USD", 25.56);

      expect(test1, "€12.25");
      expect(test2, "\$25.56");
    });

    test('Test Date', () {
      var test1 = dateIsBeforeToday('2020-07-03');

      expect(test1, true);
    });
  });

}
