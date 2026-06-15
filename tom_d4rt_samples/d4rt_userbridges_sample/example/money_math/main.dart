// money_math — the README's focus example.
//
// Every Money operator below (`+`, `-`, `*`, unary `-`) runs through
// MoneyUserBridge, and every `format()` call runs through the overridden
// method — while `majorUnits`, `isNegative` and the constructors come from the
// generator. The script cannot tell which members are hand-written and which
// are generated; they share one bridged class.

import 'package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart';

import 'invoice.dart';

void main(List<String> args) {
  final items = [
    LineItem('Widget', Money.amount(9.99), 3),
    LineItem('Gadget', Money.amount(19.50), 2),
    LineItem('Refund', Money.amount(-5.00), 1),
  ];

  print('Line items:');
  for (final item in items) {
    // .format() is the user-bridge override; .total uses operator*.
    print('  ${item.label.padRight(8)} '
        '${item.price.format()} x${item.qty} = ${item.total.format()}');
  }

  final subtotal = sumTotals(items); // operator+
  final tax = subtotal * 0.08; // operator*
  final grand = subtotal + tax; // operator+

  print('');
  print('Subtotal:    ${subtotal.format()}');
  print('Tax (8%):    ${tax.format()}');
  print('Grand total: ${grand.format()}');

  // Unary minus + the sign-aware format() override → accounting parentheses.
  final credit = -grand;
  print('As a credit: ${credit.format()}  (negative: ${credit.isNegative})');
}
