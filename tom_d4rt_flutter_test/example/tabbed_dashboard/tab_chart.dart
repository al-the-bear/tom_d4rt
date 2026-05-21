// Chart tab — a `CustomPaint` line chart with Add/Clear controls.
//
// Uses `AutomaticKeepAliveClientMixin` (via `wantKeepAlive => true`)
// so the accumulated point list survives switching to Settings/Log
// and back. The `super.build(context)` call inside `build` is
// required by the mixin contract.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'chart_painter.dart';

class ChartTab extends StatefulWidget {
  const ChartTab({super.key});

  @override
  State<ChartTab> createState() => _ChartTabState();
}

class _ChartTabState extends State<ChartTab>
    with AutomaticKeepAliveClientMixin {
  // Five seed points so the painter has something visible on first
  // mount. `_add` pushes the next deterministic pseudo-value onto
  // the tail.
  final List<double> _values = <double>[1.0, 3.0, 2.0, 5.0, 4.0];

  @override
  bool get wantKeepAlive => true;

  void _add() {
    final int n = _values.length;
    final double last = _values.last;
    // Cheap deterministic next value — no `dart:math` import needed.
    final double next = ((last * 7.0 + n * 3.0) % 9.0) + 1.0;
    setState(() {
      _values.add(next);
    });
    print('chart.add value=${next.toStringAsFixed(1)}');
    print('chart.points n=${_values.length}');
  }

  void _clear() {
    setState(() {
      _values.clear();
    });
    print('chart.cleared');
    print('chart.points n=0');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Points: ${_values.length}',
              key: const Key('chart-count-label'),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: CustomPaint(
                key: const Key('chart-paint'),
                painter: ChartPainter(_values),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  key: const Key('chart-clear-button'),
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Clear chart',
                  onPressed: _clear,
                ),
                const SizedBox(width: 8.0),
                FilledButton.icon(
                  key: const Key('chart-add-button'),
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                  onPressed: _add,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
