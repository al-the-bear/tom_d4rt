// Button pad — the 5×4 calculator keypad rendered with `GridView.count`.
//
// Every cell is an `InkWell` so taps get the standard Material ink
// splash; the backspace cell is additionally wrapped in a
// `GestureDetector` that exercises `LongPressGestureRecognizer`
// semantics. On long press it kicks off a `Timer.periodic` that
// repeatedly fires `onBackspace`, giving the calculator a feel-good
// "hold to delete" behaviour. The repeat timer cancels cleanly on
// finger-up.
//
// The pad is a `StatelessWidget` — all state lives in the host's
// `State<CalculatorHome>`. Each button just forwards to one of the
// typed callbacks; the host's handler calls the matching engine
// method and then `setState`s.
//
// Why explicit `ValueKey<String>(...)` everywhere?
//   d4rt's generic-constructor inference currently resolves
//   `ValueKey('btn-7')` to `ValueKey<dynamic>` (GEN-113 history),
//   which the framework still accepts but the test harness asserts
//   on key types. Spelling the type out keeps the sample readable
//   under whichever version of the interpreter is in use.
import 'dart:async';

import 'package:flutter/material.dart';

class CalculatorButtonPad extends StatelessWidget {
  final void Function(String digit) onDigit;
  final void Function(String op) onOperator;
  final VoidCallback onDot;
  final VoidCallback onEquals;
  final VoidCallback onClearAll;
  final VoidCallback onNegate;
  final VoidCallback onPercent;
  final VoidCallback onBackspace;

  const CalculatorButtonPad({
    super.key,
    required this.onDigit,
    required this.onOperator,
    required this.onDot,
    required this.onEquals,
    required this.onClearAll,
    required this.onNegate,
    required this.onPercent,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    // Visual style profiles.
    final digitStyle = _ButtonStyleSpec(
      background: scheme.surfaceContainerHighest,
      foreground: scheme.onSurface,
    );
    final actionStyle = _ButtonStyleSpec(
      background: scheme.secondaryContainer,
      foreground: scheme.onSecondaryContainer,
    );
    final opStyle = _ButtonStyleSpec(
      background: scheme.tertiaryContainer,
      foreground: scheme.onTertiaryContainer,
    );
    final equalsStyle = _ButtonStyleSpec(
      background: scheme.primary,
      foreground: scheme.onPrimary,
    );

    // 5 rows × 4 cols. Order matters — GridView.count fills row-major.
    final cells = <Widget>[
      // Row 1 — clear / backspace / percent / divide
      _PadButton(
        keyId: 'ac',
        label: 'AC',
        style: actionStyle,
        onTap: onClearAll,
      ),
      _RepeatingBackspaceButton(
        keyId: 'backspace',
        style: actionStyle,
        onTap: onBackspace,
      ),
      _PadButton(
        keyId: 'percent',
        label: '%',
        style: actionStyle,
        onTap: onPercent,
      ),
      _PadButton(
        keyId: 'op-div',
        label: '\u00f7', // ÷
        style: opStyle,
        onTap: () => onOperator('/'),
      ),

      // Row 2 — 7 8 9 ×
      _PadButton(
        keyId: 'digit-7',
        label: '7',
        style: digitStyle,
        onTap: () => onDigit('7'),
      ),
      _PadButton(
        keyId: 'digit-8',
        label: '8',
        style: digitStyle,
        onTap: () => onDigit('8'),
      ),
      _PadButton(
        keyId: 'digit-9',
        label: '9',
        style: digitStyle,
        onTap: () => onDigit('9'),
      ),
      _PadButton(
        keyId: 'op-mul',
        label: '\u00d7', // ×
        style: opStyle,
        onTap: () => onOperator('*'),
      ),

      // Row 3 — 4 5 6 −
      _PadButton(
        keyId: 'digit-4',
        label: '4',
        style: digitStyle,
        onTap: () => onDigit('4'),
      ),
      _PadButton(
        keyId: 'digit-5',
        label: '5',
        style: digitStyle,
        onTap: () => onDigit('5'),
      ),
      _PadButton(
        keyId: 'digit-6',
        label: '6',
        style: digitStyle,
        onTap: () => onDigit('6'),
      ),
      _PadButton(
        keyId: 'op-sub',
        label: '\u2212', // −
        style: opStyle,
        onTap: () => onOperator('-'),
      ),

      // Row 4 — 1 2 3 +
      _PadButton(
        keyId: 'digit-1',
        label: '1',
        style: digitStyle,
        onTap: () => onDigit('1'),
      ),
      _PadButton(
        keyId: 'digit-2',
        label: '2',
        style: digitStyle,
        onTap: () => onDigit('2'),
      ),
      _PadButton(
        keyId: 'digit-3',
        label: '3',
        style: digitStyle,
        onTap: () => onDigit('3'),
      ),
      _PadButton(
        keyId: 'op-add',
        label: '+',
        style: opStyle,
        onTap: () => onOperator('+'),
      ),

      // Row 5 — ± 0 . =
      _PadButton(
        keyId: 'negate',
        label: '\u00b1', // ±
        style: actionStyle,
        onTap: onNegate,
      ),
      _PadButton(
        keyId: 'digit-0',
        label: '0',
        style: digitStyle,
        onTap: () => onDigit('0'),
      ),
      _PadButton(
        keyId: 'dot',
        label: '.',
        style: digitStyle,
        onTap: onDot,
      ),
      _PadButton(
        keyId: 'equals',
        label: '=',
        style: equalsStyle,
        onTap: onEquals,
      ),
    ];

    // Cap the pad to a phone-portrait-ish footprint and center it
    // horizontally so wide desktop windows don't make the pad balloon
    // vertically and overflow the parent column. The prior unbounded
    // shrinkWrap layout grew the pad to 5 × (width/4 / 1.1) px tall,
    // which hit ~1250 px on wide windows.
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420, maxHeight: 480),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: GridView.count(
            key: const ValueKey<String>('button-pad'),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.1,
            children: cells,
          ),
        ),
      ),
    );
  }
}

class _ButtonStyleSpec {
  final Color background;
  final Color foreground;

  const _ButtonStyleSpec({
    required this.background,
    required this.foreground,
  });
}

/// A standard tap-once button.
class _PadButton extends StatelessWidget {
  final String keyId;
  final String label;
  final _ButtonStyleSpec style;
  final VoidCallback onTap;

  const _PadButton({
    required this.keyId,
    required this.label,
    required this.style,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      key: ValueKey<String>('btn-$keyId'),
      color: style.background,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: style.foreground,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

/// Backspace button — single tap fires once; long-press starts a
/// repeat timer that keeps firing until finger-up.
///
/// Implemented as a stateful widget because the repeat timer is
/// inherently stateful and shouldn't bleed into the host's State.
class _RepeatingBackspaceButton extends StatefulWidget {
  final String keyId;
  final _ButtonStyleSpec style;
  final VoidCallback onTap;

  const _RepeatingBackspaceButton({
    required this.keyId,
    required this.style,
    required this.onTap,
  });

  @override
  State<_RepeatingBackspaceButton> createState() =>
      _RepeatingBackspaceButtonState();
}

class _RepeatingBackspaceButtonState extends State<_RepeatingBackspaceButton> {
  Timer? _repeatTimer;

  static const Duration _initialDelay = Duration(milliseconds: 350);
  static const Duration _repeatInterval = Duration(milliseconds: 90);

  void _startRepeating() {
    // Fire one immediately so long-press feels responsive.
    widget.onTap();
    // After a short hold, switch to the high-frequency repeat.
    _repeatTimer = Timer(_initialDelay, () {
      _repeatTimer = Timer.periodic(_repeatInterval, (_) {
        widget.onTap();
      });
    });
  }

  void _stopRepeating() {
    _repeatTimer?.cancel();
    _repeatTimer = null;
  }

  @override
  void dispose() {
    _stopRepeating();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      key: ValueKey<String>('btn-${widget.keyId}'),
      color: widget.style.background,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPressStart: (_) => _startRepeating(),
        onLongPressEnd: (_) => _stopRepeating(),
        onLongPressCancel: _stopRepeating,
        child: InkWell(
          onTap: widget.onTap,
          child: Center(
            child: Icon(
              Icons.backspace_outlined,
              color: widget.style.foreground,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}
