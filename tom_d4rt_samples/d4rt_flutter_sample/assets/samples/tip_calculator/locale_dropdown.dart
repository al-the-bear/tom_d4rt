// Currency picker for the tip_calculator sample.
//
// `DropdownButton<Currency>` listing the four supported currencies.
// Each item carries a stable `Key('currency-<code>')` so the test
// harness can target the menu entry without depending on the symbol
// glyph (which would otherwise drag in font/Unicode rendering
// assumptions that the test bindings don't always honour).
import 'package:flutter/material.dart';

import 'currency.dart';

class LocaleDropdown extends StatelessWidget {
  final Currency value;
  final ValueChanged<Currency> onChanged;

  const LocaleDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final items = <DropdownMenuItem<Currency>>[];
    for (final c in Currency.values) {
      final fmt = kCurrencyFormats[c]!;
      items.add(
        DropdownMenuItem<Currency>(
          key: Key('currency-${fmt.code}'),
          value: c,
          child: Text(fmt.pickerLabel),
        ),
      );
    }
    return Row(
      children: <Widget>[
        const Text('Currency:'),
        const SizedBox(width: 12.0),
        DropdownButton<Currency>(
          key: const Key('currency-dropdown'),
          value: value,
          items: items,
          onChanged: (Currency? next) {
            if (next == null) return;
            onChanged(next);
          },
        ),
      ],
    );
  }
}
