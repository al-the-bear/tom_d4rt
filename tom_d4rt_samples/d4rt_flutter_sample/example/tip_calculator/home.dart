// Home page for the tip_calculator sample (example #12).
//
// State model:
//   * `_bill`           - parsed bill amount (double). 0.0 until the
//                         user enters something valid.
//   * `_billController` - `TextEditingController` for the bill field.
//                         Owned here (not in `TipInputs`) so the text
//                         survives currency-switch rebuilds.
//   * `_tipPct`         - tip percent (0..30, double).
//   * `_party`          - party size (>= 1, int).
//   * `_currency`       - active `Currency` for formatting + parsing.
//
// Each user mutation emits one `tip.*` trail line:
//   * `tip.init`     - on boot, with the defaults.
//   * `tip.bill`     - valid bill submission.
//   * `tip.bill.invalid` - rejected input.
//   * `tip.pct`      - slider change (debounced through dispatch).
//   * `tip.party`    - stepper press.
//   * `tip.currency` - dropdown change.
//   * `tip.compute`  - emitted after every state mutation so tests
//                      can assert the derived totals without having
//                      to scrape Text widgets.
//
// ignore_for_file: avoid_print - print lines are the test trail.
import 'package:flutter/material.dart';

import 'currency.dart';
import 'inputs.dart';
import 'locale_dropdown.dart';
import 'summary.dart';

class TipCalculatorHome extends StatefulWidget {
  const TipCalculatorHome({super.key});

  @override
  State<TipCalculatorHome> createState() => _TipCalculatorHomeState();
}

class _TipCalculatorHomeState extends State<TipCalculatorHome> {
  late TextEditingController _billController;
  double _bill = 0.0;
  double _tipPct = 15.0;
  int _party = 1;
  Currency _currency = Currency.usd;

  @override
  void initState() {
    super.initState();
    _billController = TextEditingController();
    print('tip.init bill=${_bill.toStringAsFixed(2)} '
        'tip=${_tipPct.round()} party=$_party '
        'currency=${kCurrencyFormats[_currency]!.code}');
    _logCompute();
  }

  @override
  void dispose() {
    _billController.dispose();
    super.dispose();
  }

  void _logCompute() {
    final tip = _bill * _tipPct / 100.0;
    final grand = _bill + tip;
    final each = _party <= 0 ? grand : grand / _party;
    print('tip.compute bill=${_bill.toStringAsFixed(2)} '
        'tip=${tip.toStringAsFixed(2)} '
        'grand=${grand.toStringAsFixed(2)} '
        'each=${each.toStringAsFixed(2)} '
        'currency=${kCurrencyFormats[_currency]!.code}');
  }

  // Live recompute as the user types — the bill must update without
  // waiting for an explicit submit, otherwise the tip never reflects
  // the typed amount. Intermediate, not-yet-parseable input (e.g.
  // "12.") is ignored until it becomes a valid number.
  void _onBillChanged(String raw) {
    final parsed = parseAmount(raw, _currency);
    if (parsed == null) {
      print('tip.bill.invalid raw=$raw');
      return;
    }
    if (parsed == _bill) return;
    setState(() {
      _bill = parsed;
    });
    print('tip.bill raw=$raw parsed=${parsed.toStringAsFixed(2)}');
    _logCompute();
  }

  void _onBillSubmitted() {
    final raw = _billController.text;
    final parsed = parseAmount(raw, _currency);
    if (parsed == null) {
      print('tip.bill.invalid raw=$raw');
      return;
    }
    if (parsed == _bill) {
      // No state change — still emit a compute line so the trail
      // makes it clear we re-evaluated.
      print('tip.bill raw=$raw parsed=${parsed.toStringAsFixed(2)} '
          'unchanged=true');
      return;
    }
    setState(() {
      _bill = parsed;
    });
    print('tip.bill raw=$raw parsed=${parsed.toStringAsFixed(2)}');
    _logCompute();
  }

  void _onTipChanged(double value) {
    final rounded = value.roundToDouble();
    if (rounded == _tipPct) return;
    setState(() {
      _tipPct = rounded;
    });
    print('tip.pct value=${rounded.round()}');
    _logCompute();
  }

  void _onPartyChanged(int value) {
    final clamped = value < 1 ? 1 : value;
    if (clamped == _party) return;
    setState(() {
      _party = clamped;
    });
    print('tip.party value=$clamped');
    _logCompute();
  }

  void _onCurrencyChanged(Currency next) {
    if (next == _currency) return;
    setState(() {
      _currency = next;
    });
    print('tip.currency value=${kCurrencyFormats[next]!.code}');
    _logCompute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tip Calculator')),
      body: SingleChildScrollView(
        key: const Key('tip-scroll'),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            LocaleDropdown(
              value: _currency,
              onChanged: _onCurrencyChanged,
            ),
            const SizedBox(height: 12.0),
            TipInputs(
              billController: _billController,
              tipPct: _tipPct,
              party: _party,
              onTipChanged: _onTipChanged,
              onPartyChanged: _onPartyChanged,
              onBillChanged: _onBillChanged,
              onBillSubmitted: _onBillSubmitted,
            ),
            const SizedBox(height: 16.0),
            TipSummary(
              bill: _bill,
              tipPct: _tipPct,
              party: _party,
              currency: _currency,
            ),
          ],
        ),
      ),
    );
  }
}
