// CalculatorHome — the StatefulWidget host that owns the
// `CalculatorEngine` and drives every rebuild through `setState`.
//
// This is the canonical d4rt-friendly state pattern (GEN-110/112):
//   • a script-defined `StatefulWidget`
//   • a script-defined `State<CalculatorHome>`
//   • every public engine mutation is wrapped in `setState(() { ... })`
//
// The engine itself is a plain class — see `engine.dart` for the
// rationale. The home wraps each engine call in a tiny lambda passed
// to `setState`, which keeps the rebuild boundary obvious.
//
// One extra wrinkle: the plan calls for `Future.microtask`-deferred
// clears. After `=` lands a result, tapping a digit shouldn't append
// to the result — it should start a fresh expression. The engine
// already enforces this via the `_justEvaluated` flag, but the
// matching "clear chrome" behaviour (dismiss any transient overlays
// before the new input runs) is deferred via `Future.microtask` so
// the framework's current frame finishes settling before we mutate
// state again. That's purely a polish step in this sample, but it
// exercises the d4rt microtask path.
import 'dart:async';

import 'package:flutter/material.dart';

import 'button_pad.dart';
import 'engine.dart';
import 'history_strip.dart';

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  final CalculatorEngine _engine = CalculatorEngine();

  void _wrap(VoidCallback action) {
    setState(action);
  }

  void _deferredClearNotice() {
    // Polish hook — runs after the current rebuild flushes. Currently
    // a no-op placeholder; if we add a transient overlay later (e.g. a
    // "result copied" snackbar), this is where it would unwind.
    Future.microtask(() {
      if (!mounted) return;
      // Reserved for future cleanup; intentionally empty.
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: scheme.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            HistoryStrip(
              entries: _engine.history,
              onClear: () => _wrap(_engine.clearHistory),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _ExpressionLine(
                      text: _engine.expression,
                      scheme: scheme,
                    ),
                    const SizedBox(height: 8),
                    _DisplayLine(
                      text: _engine.display,
                      isError: _engine.hasError,
                      scheme: scheme,
                    ),
                  ],
                ),
              ),
            ),
            CalculatorButtonPad(
              onDigit: (d) => _wrap(() => _engine.inputDigit(d)),
              onOperator: (op) => _wrap(() => _engine.inputOperator(op)),
              onDot: () => _wrap(_engine.inputDot),
              onEquals: () {
                _wrap(_engine.equals);
                _deferredClearNotice();
              },
              onClearAll: () => _wrap(_engine.clearAll),
              onNegate: () => _wrap(_engine.negate),
              onPercent: () => _wrap(_engine.percent),
              onBackspace: () => _wrap(_engine.backspace),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpressionLine extends StatelessWidget {
  final String text;
  final ColorScheme scheme;

  const _ExpressionLine({required this.text, required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        key: const ValueKey<String>('expression'),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: scheme.onSurfaceVariant,
          fontSize: 22,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _DisplayLine extends StatelessWidget {
  final String text;
  final bool isError;
  final ColorScheme scheme;

  const _DisplayLine({
    required this.text,
    required this.isError,
    required this.scheme,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerRight,
        child: Text(
          text,
          key: const ValueKey<String>('display'),
          style: TextStyle(
            color: isError ? scheme.error : scheme.onSurface,
            fontSize: 72,
            fontWeight: FontWeight.w300,
            fontFamily: 'monospace',
            letterSpacing: -1.5,
            height: 1.0,
          ),
        ),
      ),
    );
  }
}
