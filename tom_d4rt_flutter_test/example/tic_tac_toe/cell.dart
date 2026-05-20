// ignore_for_file: avoid_print
//
// Tappable cell that renders the current mark (X / O) with a
// fade + scale entrance via `AnimatedSwitcher`. Empty cells render as
// SizedBox.shrink and accept taps; filled cells suppress taps.
import 'package:flutter/material.dart';

class TicTacToeCell extends StatelessWidget {
  /// 0..8 — used to derive a stable [ValueKey] on the native `InkWell`
  /// so `WidgetTester.tap(find.byKey(ValueKey('cell-N')))` can target
  /// it from the host.
  final int id;

  /// 'X', 'O', or null when the cell is empty.
  final String? value;

  /// When false, the cell ignores taps (already filled or game over).
  final bool enabled;

  /// Fired on tap. Always provided; the parent decides whether it
  /// actually mutates state.
  final VoidCallback onTap;

  const TicTacToeCell({
    super.key,
    required this.id,
    required this.value,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    print('[tictactoe.cell] build id=$id value=$value enabled=$enabled');
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      // Key lives on the native InkWell (a bridged widget) so that
      // host-side `find.byKey` can locate it. A `super.key` on the
      // script-defined StatelessWidget would only be visible on the
      // d4rt proxy element, not on a native finder.
      //
      // Explicit `<String>`: the tom_d4rt analyzer pass currently does
      // not propagate the argument's static type into the generic
      // constructor invocation, so `ValueKey('cell-$id')` (no type
      // arg) would resolve to `ValueKey<dynamic>` and fail to match
      // `find.byKey(const ValueKey<String>('cell-0'))` on the host
      // side (Dart's `ValueKey.==` rejects different runtime types).
      // Tracked as a future interpreter cluster — until then, always
      // type ValueKey explicitly when the host needs to find by key.
      key: ValueKey<String>('cell-$id'),
      onTap: enabled ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 260),
          switchInCurve: Curves.easeOutBack,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: value == null
              ? const SizedBox.shrink(key: ValueKey('empty'))
              : _Mark(
                  key: ValueKey(value),
                  symbol: value!,
                  color: value == 'X' ? scheme.primary : scheme.tertiary,
                ),
        ),
      ),
    );
  }
}

class _Mark extends StatelessWidget {
  final String symbol;
  final Color color;

  const _Mark({super.key, required this.symbol, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          symbol,
          style: TextStyle(
            fontSize: 100,
            fontWeight: FontWeight.w800,
            color: color,
            height: 1.0,
          ),
        ),
      ),
    );
  }
}
