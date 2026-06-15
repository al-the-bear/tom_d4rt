// Currency model + pure-Dart formatter for the tip_calculator sample.
//
// `NumberFormat` from `package:intl` is not part of the bridged
// surface in `tom_d4rt_flutter_ast`, so we hand-roll a four-currency
// formatter that does the right thing for the locales the picker
// exposes. Format rules:
//   * Symbol position is currency-specific (prefix for $/£/¥,
//     prefix-with-space for €).
//   * Decimal/thousand separators follow the canonical convention
//     for each locale.
//   * JPY rounds to whole units; the others keep two decimals.
//
// The picker label is the symbol + ISO code (e.g. "$ USD") so the
// `DropdownButton` shows a compact two-token glyph and tests can
// target the option text without depending on flag glyphs.

/// A supported currency choice for the picker.
enum Currency {
  usd,
  eur,
  gbp,
  jpy,
}

/// Metadata describing how a [Currency] is formatted on screen.
class CurrencyFormat {
  final String code;        // "USD", "EUR", ...
  final String symbol;      // "$", "€", ...
  final String decimalSep;  // "." or ","
  final String thousandSep; // "," or "." or " " or ""
  final int decimals;       // 2 for most, 0 for JPY
  final bool symbolBeforeAmount;
  final bool spaceAfterSymbol;

  const CurrencyFormat({
    required this.code,
    required this.symbol,
    required this.decimalSep,
    required this.thousandSep,
    required this.decimals,
    required this.symbolBeforeAmount,
    required this.spaceAfterSymbol,
  });

  /// Compact "$ USD"-style label used by the dropdown.
  String get pickerLabel => '$symbol $code';
}

const Map<Currency, CurrencyFormat> kCurrencyFormats = <Currency, CurrencyFormat>{
  Currency.usd: CurrencyFormat(
    code: 'USD',
    symbol: r'$',
    decimalSep: '.',
    thousandSep: ',',
    decimals: 2,
    symbolBeforeAmount: true,
    spaceAfterSymbol: false,
  ),
  Currency.eur: CurrencyFormat(
    code: 'EUR',
    symbol: '\u20AC',
    decimalSep: ',',
    thousandSep: '.',
    decimals: 2,
    symbolBeforeAmount: true,
    spaceAfterSymbol: true,
  ),
  Currency.gbp: CurrencyFormat(
    code: 'GBP',
    symbol: '\u00A3',
    decimalSep: '.',
    thousandSep: ',',
    decimals: 2,
    symbolBeforeAmount: true,
    spaceAfterSymbol: false,
  ),
  Currency.jpy: CurrencyFormat(
    code: 'JPY',
    symbol: '\u00A5',
    decimalSep: '.',
    thousandSep: ',',
    decimals: 0,
    symbolBeforeAmount: true,
    spaceAfterSymbol: false,
  ),
};

/// Format an amount using the canonical pattern for the supplied
/// currency. Negative values are formatted with a leading "-" before
/// the symbol so the test harness can match a prefix.
String formatAmount(double amount, Currency currency) {
  final fmt = kCurrencyFormats[currency]!;
  final sign = amount < 0 ? '-' : '';
  final abs = amount.abs();
  final asFixed = abs.toStringAsFixed(fmt.decimals);
  // toStringAsFixed always uses '.' as decimal separator; split and
  // re-glue with the locale separators.
  final dotIdx = asFixed.indexOf('.');
  final intPart = dotIdx >= 0 ? asFixed.substring(0, dotIdx) : asFixed;
  final fracPart = dotIdx >= 0 ? asFixed.substring(dotIdx + 1) : '';
  // Group integer part into thousands (right-to-left).
  final buf = StringBuffer();
  final n = intPart.length;
  for (var i = 0; i < n; i++) {
    if (i > 0 && (n - i) % 3 == 0) buf.write(fmt.thousandSep);
    buf.write(intPart[i]);
  }
  final intGrouped = buf.toString();
  final number = fmt.decimals == 0
      ? intGrouped
      : '$intGrouped${fmt.decimalSep}$fracPart';
  final sep = fmt.spaceAfterSymbol ? ' ' : '';
  if (fmt.symbolBeforeAmount) {
    return '$sign${fmt.symbol}$sep$number';
  }
  return '$sign$number$sep${fmt.symbol}';
}

/// Parse a user-typed bill amount into a non-negative double. Accepts
/// either decimal separator (`.` or `,`) and strips thousands
/// separators that match the supplied currency. Returns `null` for
/// malformed input.
double? parseAmount(String raw, Currency currency) {
  final fmt = kCurrencyFormats[currency]!;
  var s = raw.trim();
  if (s.isEmpty) return null;
  // Strip thousands separators (we already know what they are).
  if (fmt.thousandSep.isNotEmpty) {
    s = s.replaceAll(fmt.thousandSep, '');
  }
  // Normalise decimal separator to '.'.
  if (fmt.decimalSep != '.') {
    s = s.replaceAll(fmt.decimalSep, '.');
  }
  // Also accept the "other" decimal separator so users can type
  // `12.50` even when the locale is EUR.
  if (fmt.decimalSep == '.' && s.contains(',')) {
    s = s.replaceAll(',', '.');
  }
  final v = double.tryParse(s);
  if (v == null) return null;
  if (v.isNaN || v.isInfinite || v < 0.0) return null;
  return v;
}
