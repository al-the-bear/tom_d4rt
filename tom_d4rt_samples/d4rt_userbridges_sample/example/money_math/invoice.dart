// Helper file for the money_math example.
//
// Loaded into the same in-memory source map as main.dart, so the relative
// `import 'invoice.dart'` below resolves without touching the filesystem. It
// mixes a *script-defined* type (LineItem) with the *bridged native* Money,
// and leans on Money's user-bridged `operator+` and `operator*`.

import 'package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart';

/// One row of an invoice: a label, a unit [price], and a [qty].
class LineItem {
  final String label;
  final Money price;
  final int qty;

  LineItem(this.label, this.price, this.qty);

  /// Line total — exercises Money's user-bridged `operator*`.
  Money get total => price * qty;
}

/// Sum the totals of [items] — exercises Money's user-bridged `operator+`.
Money sumTotals(List<LineItem> items) {
  var running = const Money(0);
  for (final item in items) {
    running = running + item.total;
  }
  return running;
}
