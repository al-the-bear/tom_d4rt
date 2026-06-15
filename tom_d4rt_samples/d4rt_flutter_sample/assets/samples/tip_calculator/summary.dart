// Read-only summary panel for the tip_calculator sample.
//
// Three rows: tip total, grand total, per-person amount. All amounts
// are formatted through `formatAmount` so the symbol and separator
// match the active currency.
//
// Each row uses a stable `Key` (`row-tip`, `row-grand`, `row-each`)
// so tests can assert against the rendered value without depending
// on the surrounding label text.
import 'package:flutter/material.dart';

import 'currency.dart';

class TipSummary extends StatelessWidget {
  final double bill;
  final double tipPct;
  final int party;
  final Currency currency;

  const TipSummary({
    super.key,
    required this.bill,
    required this.tipPct,
    required this.party,
    required this.currency,
  });

  double get _tipAmount => bill * tipPct / 100.0;
  double get _grandTotal => bill + _tipAmount;
  double get _perPerson => party <= 0 ? _grandTotal : _grandTotal / party;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      key: const Key('summary'),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _Row(
            keyName: 'row-tip',
            label: 'Tip',
            value: formatAmount(_tipAmount, currency),
            style: theme.bodyLarge,
          ),
          _Row(
            keyName: 'row-grand',
            label: 'Total',
            value: formatAmount(_grandTotal, currency),
            style: theme.titleMedium,
          ),
          _Row(
            keyName: 'row-each',
            label: 'Per person',
            value: formatAmount(_perPerson, currency),
            style: theme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String keyName;
  final String label;
  final String value;
  final TextStyle? style;

  const _Row({
    required this.keyName,
    required this.label,
    required this.value,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label, style: style)),
          Text(value, key: Key(keyName), style: style),
        ],
      ),
    );
  }
}
