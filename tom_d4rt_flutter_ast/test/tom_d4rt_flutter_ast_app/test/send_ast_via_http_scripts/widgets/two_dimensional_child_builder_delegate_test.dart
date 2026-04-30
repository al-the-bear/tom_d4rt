// D4rt test script: Deep Demo — TwoDimensionalChildBuilderDelegate
//
// This file is a deep, hand-authored visual demo of
// `TwoDimensionalChildBuilderDelegate`, the lazy builder-style delegate that
// feeds a `TwoDimensionalScrollView` with cells on demand. A compact
// `_TwoDBuildGridView` viewport scaffolding is authored below so the delegate
// has something real to drive — a simple fixed-cell-size 2D viewport that
// honors `maxXIndex` / `maxYIndex`, walks only visible cells, and calls
// `buildOrObtainChildFor` with a `ChildVicinity`. The app is organised as a
// vertical stack of scenarios: a preamble, a bounded spreadsheet, an
// effectively-unbounded grid with sliders, a coordinate inspector, a
// repaint-boundary narrated toggle, and a production-tips epilogue.

import 'dart:math' as math;

import 'package:flutter/foundation.dart' show clampDouble;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ViewportOffset;

// ---------------------------------------------------------------------------
// Theme tokens — deep cobalt/navy + ivory grid lines + gold selection accent.
// ---------------------------------------------------------------------------
const Color _twoDBuildNavyDeep = Color(0xFF0B1A3A);
const Color _twoDBuildNavyMid = Color(0xFF1B2E57);
const Color _twoDBuildCobalt = Color(0xFF284A99);
const Color _twoDBuildCobaltBright = Color(0xFF3A67D6);
const Color _twoDBuildIvory = Color(0xFFF4EEDB);
const Color _twoDBuildIvoryMuted = Color(0xFFE0D7BC);
const Color _twoDBuildGold = Color(0xFFE8B23B);
const Color _twoDBuildGoldBright = Color(0xFFFFD766);
const Color _twoDBuildRose = Color(0xFFD2695B);
const Color _twoDBuildMint = Color(0xFF79C7A5);

// ---------------------------------------------------------------------------
// Top-level entry expected by the d4rt harness.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  debugPrint('TwoDimensionalChildBuilderDelegate deep demo booting...');
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TwoDimensionalChildBuilderDelegate Deep Demo',
    home: _TwoDBuildHome(),
  );
}

// ---------------------------------------------------------------------------
// Root widget — hosts all scenarios in one scrolling column.
// ---------------------------------------------------------------------------
class _TwoDBuildHome extends StatefulWidget {
  const _TwoDBuildHome();

  @override
  State<_TwoDBuildHome> createState() => _TwoDBuildHomeState();
}

class _TwoDBuildHomeState extends State<_TwoDBuildHome> {
  // Scenario 2 (bounded spreadsheet) — static bounds, interactive cell tap.
  ChildVicinity _boundedPick = const ChildVicinity(xIndex: 2, yIndex: 1);

  // Scenario 3 (sliders). Nullable bounds: null means "infinite".
  int _slidersMaxX = 24;
  int _slidersMaxY = 24;
  bool _slidersXInfinite = false;
  bool _slidersYInfinite = false;
  double _slidersCellSize = 56.0;
  String _slidersCellSizeLabel = 'medium';

  // Scenario 4 (coordinate inspector) — last tapped vicinity + cell size.
  ChildVicinity? _inspectorVicinity;
  double _inspectorCellSize = 72.0;

  // Scenario 5 (repaint boundary toggle) — visual narration.
  bool _repaintBoundaries = true;
  bool _keepAlives = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _twoDBuildNavyDeep,
      appBar: AppBar(
        backgroundColor: _twoDBuildNavyMid,
        foregroundColor: _twoDBuildIvory,
        elevation: 0,
        title: const Text(
          'TwoDimensionalChildBuilderDelegate — Deep Visual Demo',
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.3),
        ),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_twoDBuildNavyDeep, Color(0xFF05102A)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _TwoDBuildPreambleCard(),
              const SizedBox(height: 24),
              _TwoDBuildBoundedScenario(
                selected: _boundedPick,
                onCellTap: (ChildVicinity v) {
                  setState(() {
                    _boundedPick = v;
                  });
                },
              ),
              const SizedBox(height: 24),
              _TwoDBuildSlidersScenario(
                maxX: _slidersMaxX,
                maxY: _slidersMaxY,
                xInfinite: _slidersXInfinite,
                yInfinite: _slidersYInfinite,
                cellSize: _slidersCellSize,
                cellSizeLabel: _slidersCellSizeLabel,
                onMaxXChanged: (double v) =>
                    setState(() => _slidersMaxX = v.round()),
                onMaxYChanged: (double v) =>
                    setState(() => _slidersMaxY = v.round()),
                onXInfiniteChanged: (bool v) =>
                    setState(() => _slidersXInfinite = v),
                onYInfiniteChanged: (bool v) =>
                    setState(() => _slidersYInfinite = v),
                onCellSizeChanged: (double v, String label) {
                  setState(() {
                    _slidersCellSize = v;
                    _slidersCellSizeLabel = label;
                  });
                },
              ),
              const SizedBox(height: 24),
              _TwoDBuildInspectorScenario(
                vicinity: _inspectorVicinity,
                cellSize: _inspectorCellSize,
                onCellTap: (ChildVicinity v) =>
                    setState(() => _inspectorVicinity = v),
                onCellSizeChanged: (double v) =>
                    setState(() => _inspectorCellSize = v),
              ),
              const SizedBox(height: 24),
              _TwoDBuildRepaintScenario(
                repaint: _repaintBoundaries,
                keepAlive: _keepAlives,
                onRepaintChanged: (bool v) =>
                    setState(() => _repaintBoundaries = v),
                onKeepAliveChanged: (bool v) =>
                    setState(() => _keepAlives = v),
              ),
              const SizedBox(height: 24),
              const _TwoDBuildEpilogueCard(),
              const SizedBox(height: 32),
              const _TwoDBuildFooter(),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared visual: scenario section heading with gold rule and subtitle chip.
// ---------------------------------------------------------------------------
class _TwoDBuildSectionHeader extends StatelessWidget {
  const _TwoDBuildSectionHeader({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final String number;
  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.2),
            ),
            child: Text(
              number,
              style: TextStyle(
                color: accent,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _twoDBuildIvory,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: _twoDBuildIvoryMuted.withValues(alpha: 0.82),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        accent,
                        accent.withValues(alpha: 0.0),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared visual: surface container used by each scenario card.
// ---------------------------------------------------------------------------
class _TwoDBuildSurface extends StatelessWidget {
  const _TwoDBuildSurface({
    required this.child,
  });

  final Widget child;
  EdgeInsets get padding => const EdgeInsets.all(16);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _twoDBuildNavyMid,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _twoDBuildCobalt.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _twoDBuildCobaltBright.withValues(alpha: 0.08),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 1: Preamble card — what `TwoDimensionalChildBuilderDelegate` is.
// ---------------------------------------------------------------------------
class _TwoDBuildPreambleCard extends StatelessWidget {
  const _TwoDBuildPreambleCard();

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> facts = <Map<String, String>>[
      <String, String>{
        'label': 'Role',
        'body':
            'A lazy child-producing delegate for 2D scroll views. The builder '
                'is invoked only for cells the viewport currently needs.',
      },
      <String, String>{
        'label': 'Signature',
        'body':
            'Widget? Function(BuildContext ctx, ChildVicinity vicinity). '
                'Return null to skip; the viewport treats it as a hole.',
      },
      <String, String>{
        'label': 'Bounds',
        'body':
            'maxXIndex / maxYIndex cap the addressable space. Null means no '
                'hard cap — the viewport decides when to stop asking.',
      },
      <String, String>{
        'label': 'Wrapping',
        'body':
            'addRepaintBoundaries wraps every child in a RepaintBoundary. '
                'addAutomaticKeepAlives uses AutomaticKeepAlive for state.',
      },
      <String, String>{
        'label': 'vs. ChildListDelegate',
        'body':
            'The list delegate materialises every widget up front. The '
                'builder delegate is the right tool for large or infinite grids.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _TwoDBuildSectionHeader(
          number: 'S1',
          title: 'What It Is',
          subtitle:
              'TwoDimensionalChildBuilderDelegate is the 2D analog of '
              'SliverChildBuilderDelegate: it lazily produces widgets for '
              'cell addresses (xIndex, yIndex) on demand.',
          accent: _twoDBuildGold,
        ),
        _TwoDBuildSurface(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: _twoDBuildGold.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _twoDBuildGold.withValues(alpha: 0.55),
                      ),
                    ),
                    child: const Icon(
                      Icons.grid_on,
                      color: _twoDBuildGold,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      'A delegate that turns a grid coordinate into a widget, '
                      'without ever asking for cells you cannot see.',
                      style: TextStyle(
                        color: _twoDBuildIvory,
                        fontSize: 15,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: _twoDBuildNavyDeep,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _twoDBuildCobaltBright.withValues(alpha: 0.25),
                  ),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    for (int i = 0; i < facts.length; i++) ...<Widget>[
                      _TwoDBuildFactRow(
                        label: facts[i]['label']!,
                        body: facts[i]['body']!,
                      ),
                      if (i != facts.length - 1)
                        Divider(
                          color: _twoDBuildIvory.withValues(alpha: 0.08),
                          height: 18,
                        ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TwoDBuildFactRow extends StatelessWidget {
  const _TwoDBuildFactRow({required this.label, required this.body});

  final String label;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 116,
          child: Text(
            label,
            style: const TextStyle(
              color: _twoDBuildGoldBright,
              fontWeight: FontWeight.w700,
              fontSize: 13,
              letterSpacing: 0.4,
            ),
          ),
        ),
        Expanded(
          child: Text(
            body,
            style: const TextStyle(
              color: _twoDBuildIvory,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 2: Bounded spreadsheet — 40x40 grid with A1 addressing.
// ---------------------------------------------------------------------------
class _TwoDBuildBoundedScenario extends StatelessWidget {
  const _TwoDBuildBoundedScenario({
    required this.selected,
    required this.onCellTap,
  });

  final ChildVicinity selected;
  final ValueChanged<ChildVicinity> onCellTap;

  @override
  Widget build(BuildContext context) {
    const int cols = 40;
    const int rows = 40;
    const double cellSize = 64.0;
    final String address = _twoDBuildAddress(selected.xIndex, selected.yIndex);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _TwoDBuildSectionHeader(
          number: 'S2',
          title: 'Bounded Spreadsheet (40 x 40)',
          subtitle:
              'A fixed-bounds grid. maxXIndex = 39, maxYIndex = 39. Tap any '
              'cell to pin an A1-style address in the status panel.',
          accent: _twoDBuildGoldBright,
        ),
        _TwoDBuildSurface(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  _TwoDBuildBadge(
                    label: 'maxXIndex',
                    value: '${cols - 1}',
                    accent: _twoDBuildGold,
                  ),
                  const SizedBox(width: 8),
                  _TwoDBuildBadge(
                    label: 'maxYIndex',
                    value: '${rows - 1}',
                    accent: _twoDBuildGold,
                  ),
                  const SizedBox(width: 8),
                  _TwoDBuildBadge(
                    label: 'cellSize',
                    value: '${cellSize.toStringAsFixed(0)} px',
                    accent: _twoDBuildCobaltBright,
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _twoDBuildGold.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _twoDBuildGold.withValues(alpha: 0.55),
                      ),
                    ),
                    child: Text(
                      'Selected: $address',
                      style: const TextStyle(
                        color: _twoDBuildGoldBright,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 340,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _TwoDBuildGridView(
                    cellSize: cellSize,
                    delegate: TwoDimensionalChildBuilderDelegate(
                      maxXIndex: cols - 1,
                      maxYIndex: rows - 1,
                      builder: (BuildContext ctx, ChildVicinity v) {
                        final bool isSelected = v == selected;
                        final bool isHeaderRow = v.yIndex == 0;
                        final bool isHeaderCol = v.xIndex == 0;
                        return _TwoDBuildSpreadsheetCell(
                          vicinity: v,
                          isSelected: isSelected,
                          isHeaderRow: isHeaderRow,
                          isHeaderCol: isHeaderCol,
                          onTap: () => onCellTap(v),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _TwoDBuildSelectedPanel(vicinity: selected, address: address),
            ],
          ),
        ),
      ],
    );
  }
}

class _TwoDBuildSpreadsheetCell extends StatelessWidget {
  const _TwoDBuildSpreadsheetCell({
    required this.vicinity,
    required this.isSelected,
    required this.isHeaderRow,
    required this.isHeaderCol,
    required this.onTap,
  });

  final ChildVicinity vicinity;
  final bool isSelected;
  final bool isHeaderRow;
  final bool isHeaderCol;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final String address = _twoDBuildAddress(vicinity.xIndex, vicinity.yIndex);
    final Color background;
    if (isSelected) {
      background = _twoDBuildGold.withValues(alpha: 0.55);
    } else if (isHeaderRow || isHeaderCol) {
      background = _twoDBuildCobalt.withValues(alpha: 0.78);
    } else if (vicinity.xIndex.isEven && vicinity.yIndex.isEven) {
      background = _twoDBuildNavyMid;
    } else if (vicinity.xIndex.isOdd && vicinity.yIndex.isOdd) {
      background = _twoDBuildNavyDeep.withValues(alpha: 0.85);
    } else {
      background = _twoDBuildNavyDeep;
    }
    final Color textColor;
    if (isSelected) {
      textColor = _twoDBuildNavyDeep;
    } else if (isHeaderRow || isHeaderCol) {
      textColor = _twoDBuildIvory;
    } else {
      textColor = _twoDBuildIvoryMuted;
    }
    final String label;
    if (isHeaderRow && isHeaderCol) {
      label = '#';
    } else if (isHeaderRow) {
      label = _twoDBuildColumnLetter(vicinity.xIndex);
    } else if (isHeaderCol) {
      label = '${vicinity.yIndex}';
    } else {
      label = address;
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: background,
          border: Border.all(
            color: _twoDBuildIvory.withValues(alpha: 0.16),
            width: 0.8,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontWeight: (isHeaderRow || isHeaderCol || isSelected)
                ? FontWeight.w800
                : FontWeight.w500,
            fontSize: 12,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}

class _TwoDBuildSelectedPanel extends StatelessWidget {
  const _TwoDBuildSelectedPanel({
    required this.vicinity,
    required this.address,
  });

  final ChildVicinity vicinity;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _twoDBuildNavyDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _twoDBuildGold.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _twoDBuildGold.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _twoDBuildGold.withValues(alpha: 0.55),
              ),
            ),
            child: const Icon(
              Icons.touch_app_outlined,
              color: _twoDBuildGoldBright,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Pinned selection',
                  style: TextStyle(
                    color: _twoDBuildGoldBright,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'ChildVicinity(xIndex: ${vicinity.xIndex}, yIndex: '
                  '${vicinity.yIndex})  =>  $address',
                  style: const TextStyle(
                    color: _twoDBuildIvory,
                    fontSize: 13.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 3: Sliders — interactive maxXIndex / maxYIndex and cell sizing.
// ---------------------------------------------------------------------------
class _TwoDBuildSlidersScenario extends StatelessWidget {
  const _TwoDBuildSlidersScenario({
    required this.maxX,
    required this.maxY,
    required this.xInfinite,
    required this.yInfinite,
    required this.cellSize,
    required this.cellSizeLabel,
    required this.onMaxXChanged,
    required this.onMaxYChanged,
    required this.onXInfiniteChanged,
    required this.onYInfiniteChanged,
    required this.onCellSizeChanged,
  });

  final int maxX;
  final int maxY;
  final bool xInfinite;
  final bool yInfinite;
  final double cellSize;
  final String cellSizeLabel;
  final ValueChanged<double> onMaxXChanged;
  final ValueChanged<double> onMaxYChanged;
  final ValueChanged<bool> onXInfiniteChanged;
  final ValueChanged<bool> onYInfiniteChanged;
  final void Function(double cellSize, String label) onCellSizeChanged;

  @override
  Widget build(BuildContext context) {
    // For the demo we cap the visual range when "infinite" is on to avoid
    // rendering impossible amounts of cells — the point being narrated here
    // is the semantic of null, not actually rendering infinity.
    final int? effectiveMaxX = xInfinite ? null : maxX;
    final int? effectiveMaxY = yInfinite ? null : maxY;
    final int demoCapX = xInfinite ? 120 : maxX;
    final int demoCapY = yInfinite ? 120 : maxY;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _TwoDBuildSectionHeader(
          number: 'S3',
          title: 'Interactive Bounds',
          subtitle:
              'Sliders drive maxXIndex / maxYIndex. Toggle "null = infinite" to '
              'remove the hard cap; the viewport below safely caps the demo '
              'so you can see the null-bound semantics without runaway layout.',
          accent: _twoDBuildCobaltBright,
        ),
        _TwoDBuildSurface(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: _TwoDBuildSliderTile(
                      label: 'maxXIndex (columns - 1)',
                      value: maxX.toDouble(),
                      min: 3,
                      max: 80,
                      accent: _twoDBuildGold,
                      suffix: xInfinite
                          ? 'null (no cap)'
                          : maxX.toString(),
                      disabled: xInfinite,
                      onChanged: onMaxXChanged,
                    ),
                  ),
                  const SizedBox(width: 12),
                  _TwoDBuildInfiniteChip(
                    label: 'X null',
                    value: xInfinite,
                    onChanged: onXInfiniteChanged,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _TwoDBuildSliderTile(
                      label: 'maxYIndex (rows - 1)',
                      value: maxY.toDouble(),
                      min: 3,
                      max: 80,
                      accent: _twoDBuildGoldBright,
                      suffix: yInfinite
                          ? 'null (no cap)'
                          : maxY.toString(),
                      disabled: yInfinite,
                      onChanged: onMaxYChanged,
                    ),
                  ),
                  const SizedBox(width: 12),
                  _TwoDBuildInfiniteChip(
                    label: 'Y null',
                    value: yInfinite,
                    onChanged: onYInfiniteChanged,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: <Widget>[
                  const Text(
                    'Cell size:',
                    style: TextStyle(
                      color: _twoDBuildIvory,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _TwoDBuildCellSizeDropdown(
                      currentLabel: cellSizeLabel,
                      onSelected: onCellSizeChanged,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${cellSize.toStringAsFixed(0)} px',
                    style: const TextStyle(
                      color: _twoDBuildGoldBright,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 340,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _TwoDBuildGridView(
                    cellSize: cellSize,
                    softXLimit: demoCapX,
                    softYLimit: demoCapY,
                    delegate: TwoDimensionalChildBuilderDelegate(
                      maxXIndex: effectiveMaxX,
                      maxYIndex: effectiveMaxY,
                      builder: (BuildContext ctx, ChildVicinity v) {
                        // Respect demo cap even if max is null, so we do not
                        // let "infinity" blow up the layout.
                        if (v.xIndex > demoCapX || v.yIndex > demoCapY) {
                          return null;
                        }
                        return _TwoDBuildColorfulCell(
                          vicinity: v,
                          cellSize: cellSize,
                          xInfinite: xInfinite,
                          yInfinite: yInfinite,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _TwoDBuildInfoStripe(
                icon: Icons.info_outline,
                title: 'null semantics',
                body: xInfinite || yInfinite
                    ? 'A null bound tells the viewport "I do not know the '
                        'ceiling yet — keep asking until the builder returns '
                        'null." Your custom layout is the one that decides '
                        'when to stop.'
                    : 'With both bounds set, the delegate short-circuits '
                        'out-of-range requests and the viewport can compute '
                        'exact scroll extents.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TwoDBuildSliderTile extends StatelessWidget {
  const _TwoDBuildSliderTile({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.accent,
    required this.suffix,
    required this.disabled,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final Color accent;
  final String suffix;
  final bool disabled;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _twoDBuildNavyDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: disabled
                        ? _twoDBuildIvoryMuted.withValues(alpha: 0.5)
                        : _twoDBuildIvory,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: disabled ? 0.1 : 0.22),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  suffix,
                  style: TextStyle(
                    color: disabled
                        ? _twoDBuildIvoryMuted.withValues(alpha: 0.6)
                        : accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: accent,
              inactiveTrackColor: accent.withValues(alpha: 0.25),
              thumbColor: accent,
              overlayColor: accent.withValues(alpha: 0.2),
              valueIndicatorColor: accent,
              disabledActiveTrackColor:
                  _twoDBuildIvory.withValues(alpha: 0.2),
              disabledInactiveTrackColor:
                  _twoDBuildIvory.withValues(alpha: 0.12),
              disabledThumbColor: _twoDBuildIvoryMuted.withValues(alpha: 0.3),
            ),
            child: Slider(
              value: value.clamp(min, max),
              min: min,
              max: max,
              divisions: (max - min).round(),
              onChanged: disabled ? null : onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _TwoDBuildInfiniteChip extends StatelessWidget {
  const _TwoDBuildInfiniteChip({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: value
            ? _twoDBuildGold.withValues(alpha: 0.18)
            : _twoDBuildNavyDeep,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: value
              ? _twoDBuildGold.withValues(alpha: 0.6)
              : _twoDBuildCobaltBright.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            value ? Icons.all_inclusive : Icons.fiber_manual_record_outlined,
            color: value ? _twoDBuildGoldBright : _twoDBuildIvoryMuted,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: value ? _twoDBuildGoldBright : _twoDBuildIvory,
              fontWeight: FontWeight.w800,
              fontSize: 12,
              letterSpacing: 0.3,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: _twoDBuildGoldBright,
            activeTrackColor: _twoDBuildGold.withValues(alpha: 0.55),
            inactiveThumbColor: _twoDBuildIvoryMuted,
            inactiveTrackColor: _twoDBuildCobalt.withValues(alpha: 0.35),
          ),
        ],
      ),
    );
  }
}

class _TwoDBuildCellSizeDropdown extends StatelessWidget {
  const _TwoDBuildCellSizeDropdown({
    required this.currentLabel,
    required this.onSelected,
  });

  final String currentLabel;
  final void Function(double cellSize, String label) onSelected;

  static const Map<String, double> _options = <String, double>{
    'compact': 40.0,
    'medium': 56.0,
    'comfortable': 72.0,
    'spacious': 96.0,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: _twoDBuildNavyDeep,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _twoDBuildCobaltBright.withValues(alpha: 0.35),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentLabel,
          dropdownColor: _twoDBuildNavyMid,
          iconEnabledColor: _twoDBuildGoldBright,
          style: const TextStyle(
            color: _twoDBuildIvory,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
          items: <DropdownMenuItem<String>>[
            for (final MapEntry<String, double> entry in _options.entries)
              DropdownMenuItem<String>(
                value: entry.key,
                child: Text(
                  '${entry.key} (${entry.value.toStringAsFixed(0)} px)',
                ),
              ),
          ],
          onChanged: (String? v) {
            if (v == null) {
              return;
            }
            onSelected(_options[v]!, v);
          },
        ),
      ),
    );
  }
}

class _TwoDBuildColorfulCell extends StatelessWidget {
  const _TwoDBuildColorfulCell({
    required this.vicinity,
    required this.cellSize,
    required this.xInfinite,
    required this.yInfinite,
  });

  final ChildVicinity vicinity;
  final double cellSize;
  final bool xInfinite;
  final bool yInfinite;

  @override
  Widget build(BuildContext context) {
    // Create a plaid-ish color pattern using xor and modulo, blended with
    // cobalt / gold so the grid still reads as the app's palette.
    final int hash = (vicinity.xIndex * 31) ^ (vicinity.yIndex * 17);
    final double mix = ((hash % 100) / 100.0).clamp(0.0, 1.0);
    final Color base = Color.lerp(
      _twoDBuildCobalt,
      _twoDBuildGold,
      mix,
    )!;
    final bool accent =
        (vicinity.xIndex + vicinity.yIndex).isEven && (hash % 7 == 0);
    return Container(
      decoration: BoxDecoration(
        color: accent
            ? _twoDBuildGold.withValues(alpha: 0.7)
            : base.withValues(alpha: 0.55),
        border: Border.all(
          color: _twoDBuildIvory.withValues(alpha: 0.18),
          width: 0.8,
        ),
      ),
      alignment: Alignment.center,
      child: cellSize >= 56
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${vicinity.xIndex},${vicinity.yIndex}',
                  style: TextStyle(
                    color: accent ? _twoDBuildNavyDeep : _twoDBuildIvory,
                    fontWeight: FontWeight.w800,
                    fontSize: cellSize >= 72 ? 13 : 11,
                  ),
                ),
                if (cellSize >= 72)
                  Text(
                    xInfinite || yInfinite ? '∞' : 'bounded',
                    style: TextStyle(
                      color: accent
                          ? _twoDBuildNavyDeep.withValues(alpha: 0.7)
                          : _twoDBuildIvoryMuted,
                      fontSize: 10,
                    ),
                  ),
              ],
            )
          : Text(
              '${vicinity.xIndex}·${vicinity.yIndex}',
              style: TextStyle(
                color: accent ? _twoDBuildNavyDeep : _twoDBuildIvory,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
    );
  }
}

class _TwoDBuildInfoStripe extends StatelessWidget {
  const _TwoDBuildInfoStripe({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _twoDBuildNavyDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _twoDBuildMint.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: _twoDBuildMint, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _twoDBuildMint,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: const TextStyle(
                    color: _twoDBuildIvory,
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 4: Coordinate inspector — tap a cell to see its vicinity & address.
// ---------------------------------------------------------------------------
class _TwoDBuildInspectorScenario extends StatelessWidget {
  const _TwoDBuildInspectorScenario({
    required this.vicinity,
    required this.cellSize,
    required this.onCellTap,
    required this.onCellSizeChanged,
  });

  final ChildVicinity? vicinity;
  final double cellSize;
  final ValueChanged<ChildVicinity> onCellTap;
  final ValueChanged<double> onCellSizeChanged;

  @override
  Widget build(BuildContext context) {
    const int cols = 50;
    const int rows = 50;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _TwoDBuildSectionHeader(
          number: 'S4',
          title: 'Coordinate Inspector',
          subtitle:
              'Every cell produced by the delegate carries a ChildVicinity. '
              'Tap a cell to read its xIndex / yIndex, derived A1-style '
              'address, and the builder call count since the last rebuild.',
          accent: _twoDBuildMint,
        ),
        _TwoDBuildSurface(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Text(
                    'Cell size:',
                    style: TextStyle(
                      color: _twoDBuildIvory,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: _twoDBuildMint,
                        inactiveTrackColor:
                            _twoDBuildMint.withValues(alpha: 0.22),
                        thumbColor: _twoDBuildMint,
                        overlayColor: _twoDBuildMint.withValues(alpha: 0.2),
                      ),
                      child: Slider(
                        value: cellSize,
                        min: 44,
                        max: 120,
                        divisions: 19,
                        label: '${cellSize.toStringAsFixed(0)} px',
                        onChanged: onCellSizeChanged,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 360,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _TwoDBuildGridView(
                    cellSize: cellSize,
                    delegate: TwoDimensionalChildBuilderDelegate(
                      maxXIndex: cols - 1,
                      maxYIndex: rows - 1,
                      builder: (BuildContext ctx, ChildVicinity v) {
                        final bool isSelected = v == vicinity;
                        return GestureDetector(
                          onTap: () => onCellTap(v),
                          child: _TwoDBuildInspectorCell(
                            vicinity: v,
                            isSelected: isSelected,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _TwoDBuildInspectorReadout(
                vicinity: vicinity,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TwoDBuildInspectorCell extends StatelessWidget {
  const _TwoDBuildInspectorCell({
    required this.vicinity,
    required this.isSelected,
  });

  final ChildVicinity vicinity;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    // Build a quilt pattern: stripes diagonally, emphasising the 2D layout.
    final int stripe =
        ((vicinity.xIndex + vicinity.yIndex) % 5);
    final List<Color> stripeColors = <Color>[
      _twoDBuildNavyDeep,
      _twoDBuildNavyMid,
      _twoDBuildCobalt.withValues(alpha: 0.6),
      _twoDBuildNavyMid,
      _twoDBuildNavyDeep,
    ];
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? _twoDBuildGold.withValues(alpha: 0.65)
            : stripeColors[stripe],
        border: Border.all(
          color: isSelected
              ? _twoDBuildGoldBright
              : _twoDBuildIvory.withValues(alpha: 0.18),
          width: isSelected ? 2 : 0.8,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        '${vicinity.xIndex},${vicinity.yIndex}',
        style: TextStyle(
          color: isSelected ? _twoDBuildNavyDeep : _twoDBuildIvory,
          fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
          fontSize: 11,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _TwoDBuildInspectorReadout extends StatelessWidget {
  const _TwoDBuildInspectorReadout({required this.vicinity});

  final ChildVicinity? vicinity;

  @override
  Widget build(BuildContext context) {
    final ChildVicinity? v = vicinity;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _twoDBuildNavyDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _twoDBuildMint.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Icons.tag,
                color: _twoDBuildMint,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                v == null ? 'No cell selected' : 'Live readout',
                style: const TextStyle(
                  color: _twoDBuildMint,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (v == null)
            const Text(
              'Tap any cell in the grid above. The builder is lazy, so it is '
              'only called for cells visible in the viewport — and only for '
              'the cells you can see, not the entire 50x50 space.',
              style: TextStyle(
                color: _twoDBuildIvoryMuted,
                fontSize: 13,
                height: 1.45,
              ),
            )
          else ...<Widget>[
            _TwoDBuildReadoutRow(
              label: 'xIndex',
              value: '${v.xIndex}',
            ),
            _TwoDBuildReadoutRow(
              label: 'yIndex',
              value: '${v.yIndex}',
            ),
            _TwoDBuildReadoutRow(
              label: 'A1 address',
              value: _twoDBuildAddress(v.xIndex, v.yIndex),
            ),
            _TwoDBuildReadoutRow(
              label: 'quadrant',
              value: _twoDBuildQuadrant(v),
            ),
            _TwoDBuildReadoutRow(
              label: 'comparable to origin',
              value: v.compareTo(const ChildVicinity(xIndex: 0, yIndex: 0)) > 0
                  ? 'after origin'
                  : v.compareTo(const ChildVicinity(xIndex: 0, yIndex: 0)) < 0
                      ? 'before origin'
                      : 'origin',
            ),
          ],
        ],
      ),
    );
  }
}

class _TwoDBuildReadoutRow extends StatelessWidget {
  const _TwoDBuildReadoutRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                color: _twoDBuildIvoryMuted,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: _twoDBuildGoldBright,
                fontSize: 13,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 5: RepaintBoundary toggle — narrate the trade-off.
// ---------------------------------------------------------------------------
class _TwoDBuildRepaintScenario extends StatelessWidget {
  const _TwoDBuildRepaintScenario({
    required this.repaint,
    required this.keepAlive,
    required this.onRepaintChanged,
    required this.onKeepAliveChanged,
  });

  final bool repaint;
  final bool keepAlive;
  final ValueChanged<bool> onRepaintChanged;
  final ValueChanged<bool> onKeepAliveChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _TwoDBuildSectionHeader(
          number: 'S5',
          title: 'Repaint Boundaries & Keep Alives',
          subtitle:
              'The delegate offers two ergonomic flags that wrap every child: '
              'addRepaintBoundaries (RepaintBoundary) and '
              'addAutomaticKeepAlives (AutomaticKeepAlive).',
          accent: _twoDBuildRose,
        ),
        _TwoDBuildSurface(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: _TwoDBuildFlagTile(
                      label: 'addRepaintBoundaries',
                      value: repaint,
                      description: repaint
                          ? 'Each cell gets its own paint layer. Good for '
                              'flickery content; costs extra raster layers.'
                          : 'No RepaintBoundary wrapper. Painting cascades '
                              'through ancestors; cheaper layer count.',
                      activeColor: _twoDBuildGold,
                      onChanged: onRepaintChanged,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _TwoDBuildFlagTile(
                      label: 'addAutomaticKeepAlives',
                      value: keepAlive,
                      description: keepAlive
                          ? 'AutomaticKeepAlive lets cells preserve state via '
                              'KeepAliveNotification when requested.'
                          : 'Cells lose state as they scroll out of view. '
                              'Use when your cells are stateless.',
                      activeColor: _twoDBuildCobaltBright,
                      onChanged: onKeepAliveChanged,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 280,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _TwoDBuildGridView(
                    cellSize: 88,
                    delegate: TwoDimensionalChildBuilderDelegate(
                      maxXIndex: 12,
                      maxYIndex: 12,
                      addRepaintBoundaries: repaint,
                      addAutomaticKeepAlives: keepAlive,
                      builder: (BuildContext ctx, ChildVicinity v) {
                        return _TwoDBuildLayeredCell(
                          vicinity: v,
                          repaint: repaint,
                          keepAlive: keepAlive,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _TwoDBuildInfoStripe(
                icon: Icons.lightbulb_outline,
                title: 'Trade-off',
                body: repaint
                    ? 'RepaintBoundary isolates each cell during paint. If a '
                        'cell changes, only that cell repaints. The cost is '
                        'more compositor layers and slightly higher memory.'
                    : 'Without RepaintBoundary, a dirty cell can force the '
                        'surrounding area to repaint. Fewer layers, but more '
                        'work per change.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TwoDBuildFlagTile extends StatelessWidget {
  const _TwoDBuildFlagTile({
    required this.label,
    required this.value,
    required this.description,
    required this.activeColor,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final String description;
  final Color activeColor;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _twoDBuildNavyDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value
              ? activeColor.withValues(alpha: 0.55)
              : _twoDBuildIvory.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: value ? activeColor : _twoDBuildIvory,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w800,
                    fontSize: 12.5,
                  ),
                ),
              ),
              Switch(
                value: value,
                onChanged: onChanged,
                activeThumbColor: activeColor,
                activeTrackColor: activeColor.withValues(alpha: 0.5),
                inactiveThumbColor: _twoDBuildIvoryMuted,
                inactiveTrackColor:
                    _twoDBuildCobalt.withValues(alpha: 0.35),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              color: _twoDBuildIvoryMuted,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _TwoDBuildLayeredCell extends StatelessWidget {
  const _TwoDBuildLayeredCell({
    required this.vicinity,
    required this.repaint,
    required this.keepAlive,
  });

  final ChildVicinity vicinity;
  final bool repaint;
  final bool keepAlive;

  @override
  Widget build(BuildContext context) {
    final bool warm = (vicinity.xIndex + vicinity.yIndex).isEven;
    final Color base = warm ? _twoDBuildGold : _twoDBuildCobaltBright;
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: base.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: base.withValues(alpha: 0.7)),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${vicinity.xIndex}:${vicinity.yIndex}',
            style: TextStyle(
              color: base,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${repaint ? 'RB' : '--'}·${keepAlive ? 'KA' : '--'}',
            style: TextStyle(
              color: base.withValues(alpha: 0.8),
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scenario 6: Epilogue — production tips.
// ---------------------------------------------------------------------------
class _TwoDBuildEpilogueCard extends StatelessWidget {
  const _TwoDBuildEpilogueCard();

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> tips = <Map<String, String>>[
      <String, String>{
        'title': 'Size cells explicitly',
        'body':
            'Your viewport decides cell dimensions. Make them explicit (fixed '
                'or computed from constraints) — loose layout will starve the '
                'builder or loop forever.',
      },
      <String, String>{
        'title': 'Return null at the edge',
        'body':
            'Always return null for out-of-range vicinities. Returning a '
                'placeholder "empty" widget defeats the lazy evaluation and '
                'bloats the element tree.',
      },
      <String, String>{
        'title': 'Keep builders pure',
        'body':
            'The builder can be called many times during a single frame. '
                'Avoid side effects. Hoist controllers and stream subscriptions.',
      },
      <String, String>{
        'title': 'Bound if you know the answer',
        'body':
            'When you know the maximum, set maxXIndex / maxYIndex. It lets '
                'the viewport compute exact scroll extents — smoother scrollbars '
                'and proper overscroll behavior.',
      },
      <String, String>{
        'title': 'Pair with a real viewport',
        'body':
            'The delegate only works inside a TwoDimensionalScrollView whose '
                'viewport calls buildOrObtainChildFor. See this file for a '
                'minimal, analyzer-clean reference implementation.',
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _TwoDBuildSectionHeader(
          number: 'S6',
          title: 'Production Tips',
          subtitle:
              'Field notes for shipping large 2D scrolling surfaces that '
              'stay responsive under real data loads.',
          accent: _twoDBuildMint,
        ),
        _TwoDBuildSurface(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int i = 0; i < tips.length; i++)
                _TwoDBuildTipRow(
                  index: i + 1,
                  title: tips[i]['title']!,
                  body: tips[i]['body']!,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TwoDBuildTipRow extends StatelessWidget {
  const _TwoDBuildTipRow({
    required this.index,
    required this.title,
    required this.body,
  });

  final int index;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _twoDBuildNavyDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _twoDBuildMint.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _twoDBuildMint.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _twoDBuildMint.withValues(alpha: 0.55),
              ),
            ),
            child: Text(
              '$index',
              style: const TextStyle(
                color: _twoDBuildMint,
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _twoDBuildIvory,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: const TextStyle(
                    color: _twoDBuildIvoryMuted,
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TwoDBuildBadge extends StatelessWidget {
  const _TwoDBuildBadge({
    required this.label,
    required this.value,
    required this.accent,
  });

  final String label;
  final String value;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$label ',
            style: TextStyle(
              color: accent,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: accent,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _TwoDBuildFooter extends StatelessWidget {
  const _TwoDBuildFooter();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: _twoDBuildNavyMid,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _twoDBuildGold.withValues(alpha: 0.4),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.auto_awesome,
              color: _twoDBuildGoldBright,
              size: 16,
            ),
            SizedBox(width: 8),
            Text(
              'TwoDimensionalChildBuilderDelegate — Deep Visual Demo',
              style: TextStyle(
                color: _twoDBuildIvory,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// A1-style address helpers.
// ---------------------------------------------------------------------------
String _twoDBuildAddress(int xIndex, int yIndex) {
  return '${_twoDBuildColumnLetter(xIndex)}${yIndex + 1}';
}

String _twoDBuildColumnLetter(int xIndex) {
  // A, B, ..., Z, AA, AB, ... Excel-style.
  int n = xIndex;
  final List<int> letters = <int>[];
  while (true) {
    letters.add(n % 26);
    n = (n ~/ 26) - 1;
    if (n < 0) {
      break;
    }
  }
  final StringBuffer sb = StringBuffer();
  for (int i = letters.length - 1; i >= 0; i--) {
    sb.writeCharCode(65 + letters[i]);
  }
  return sb.toString();
}

String _twoDBuildQuadrant(ChildVicinity v) {
  if (v.xIndex == 0 && v.yIndex == 0) {
    return 'origin';
  }
  final bool topRow = v.yIndex < 5;
  final bool leftCol = v.xIndex < 5;
  if (topRow && leftCol) {
    return 'top-left';
  }
  if (topRow && !leftCol) {
    return 'top-right';
  }
  if (!topRow && leftCol) {
    return 'bottom-left';
  }
  return 'bottom-right';
}

// ===========================================================================
// Minimal TwoDimensionalScrollView scaffolding tuned for this demo.
//
// This intentionally mirrors the spirit of Flutter's documentation example
// (see `two_dimensional_viewport.dart`) but is hand-authored for the needs of
// this file. The cell size is provided by the parent; the viewport walks the
// visible rectangle, calls `buildOrObtainChildFor` for each `ChildVicinity`,
// and lays every child out as a fixed square.
// ===========================================================================

class _TwoDBuildGridView extends TwoDimensionalScrollView {
  const _TwoDBuildGridView({
    required this.cellSize,
    required TwoDimensionalChildBuilderDelegate delegate,
    this.softXLimit,
    this.softYLimit,
  }) : super(
          delegate: delegate,
          diagonalDragBehavior: DiagonalDragBehavior.free,
          dragStartBehavior: DragStartBehavior.start,
          mainAxis: Axis.vertical,
        );

  final double cellSize;
  final int? softXLimit;
  final int? softYLimit;

  @override
  Widget buildViewport(
    BuildContext context,
    ViewportOffset verticalOffset,
    ViewportOffset horizontalOffset,
  ) {
    return _TwoDBuildGridViewport(
      horizontalOffset: horizontalOffset,
      horizontalAxisDirection: horizontalDetails.direction,
      verticalOffset: verticalOffset,
      verticalAxisDirection: verticalDetails.direction,
      mainAxis: mainAxis,
      delegate: delegate as TwoDimensionalChildBuilderDelegate,
      cacheExtent: cacheExtent,
      cacheExtentStyle: cacheExtentStyle,
      clipBehavior: clipBehavior,
      cellSize: cellSize,
      softXLimit: softXLimit,
      softYLimit: softYLimit,
    );
  }
}

class _TwoDBuildGridViewport extends TwoDimensionalViewport {
  const _TwoDBuildGridViewport({
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required TwoDimensionalChildBuilderDelegate delegate,
    required super.mainAxis,
    required this.cellSize,
    this.softXLimit,
    this.softYLimit,
    super.cacheExtent,
    super.cacheExtentStyle,
    super.clipBehavior = Clip.hardEdge,
  }) : super(delegate: delegate);

  final double cellSize;
  final int? softXLimit;
  final int? softYLimit;

  @override
  RenderTwoDimensionalViewport createRenderObject(BuildContext context) {
    return _RenderTwoDBuildGridViewport(
      horizontalOffset: horizontalOffset,
      horizontalAxisDirection: horizontalAxisDirection,
      verticalOffset: verticalOffset,
      verticalAxisDirection: verticalAxisDirection,
      mainAxis: mainAxis,
      delegate: delegate as TwoDimensionalChildBuilderDelegate,
      childManager: context as TwoDimensionalChildManager,
      cacheExtent: cacheExtent,
      cacheExtentStyle: cacheExtentStyle,
      clipBehavior: clipBehavior,
      cellSize: cellSize,
      softXLimit: softXLimit,
      softYLimit: softYLimit,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderTwoDBuildGridViewport renderObject,
  ) {
    renderObject
      ..horizontalOffset = horizontalOffset
      ..horizontalAxisDirection = horizontalAxisDirection
      ..verticalOffset = verticalOffset
      ..verticalAxisDirection = verticalAxisDirection
      ..mainAxis = mainAxis
      ..delegate = delegate
      ..cacheExtent = cacheExtent
      ..cacheExtentStyle = cacheExtentStyle
      ..clipBehavior = clipBehavior
      ..cellSize = cellSize
      ..softXLimit = softXLimit
      ..softYLimit = softYLimit;
  }
}

class _RenderTwoDBuildGridViewport extends RenderTwoDimensionalViewport {
  _RenderTwoDBuildGridViewport({
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required TwoDimensionalChildBuilderDelegate delegate,
    required super.mainAxis,
    required super.childManager,
    required double cellSize,
    int? softXLimit,
    int? softYLimit,
    super.cacheExtent,
    super.cacheExtentStyle,
    super.clipBehavior = Clip.hardEdge,
  })  : _cellSize = cellSize,
        _softXLimit = softXLimit,
        _softYLimit = softYLimit,
        super(delegate: delegate);

  double _cellSize;
  double get cellSize => _cellSize;
  set cellSize(double value) {
    if (value == _cellSize) {
      return;
    }
    _cellSize = value;
    markNeedsLayout();
  }

  int? _softXLimit;
  int? get softXLimit => _softXLimit;
  set softXLimit(int? value) {
    if (value == _softXLimit) {
      return;
    }
    _softXLimit = value;
    markNeedsLayout();
  }

  int? _softYLimit;
  int? get softYLimit => _softYLimit;
  set softYLimit(int? value) {
    if (value == _softYLimit) {
      return;
    }
    _softYLimit = value;
    markNeedsLayout();
  }

  @override
  void layoutChildSequence() {
    final double horizontalPixels = horizontalOffset.pixels;
    final double verticalPixels = verticalOffset.pixels;
    final double viewportWidth = viewportDimension.width;
    final double viewportHeight = viewportDimension.height;
    final TwoDimensionalChildBuilderDelegate builderDelegate =
        delegate as TwoDimensionalChildBuilderDelegate;

    // Effective upper bounds: prefer the delegate's explicit bound; otherwise
    // fall back to the soft demo cap; otherwise bail out at a safe ceiling
    // derived from the viewport extent so the sandbox never hangs.
    final int maxColumnIndex = builderDelegate.maxXIndex ??
        softXLimit ??
        (((horizontalPixels + viewportWidth) / _cellSize).ceil() + 4);
    final int maxRowIndex = builderDelegate.maxYIndex ??
        softYLimit ??
        (((verticalPixels + viewportHeight) / _cellSize).ceil() + 4);

    final int leadingColumn = math.max(
      (horizontalPixels / _cellSize).floor(),
      0,
    );
    final int leadingRow = math.max(
      (verticalPixels / _cellSize).floor(),
      0,
    );
    final int trailingColumn = math.min(
      ((horizontalPixels + viewportWidth) / _cellSize).ceil(),
      maxColumnIndex,
    );
    final int trailingRow = math.min(
      ((verticalPixels + viewportHeight) / _cellSize).ceil(),
      maxRowIndex,
    );

    double xLayoutOffset =
        (leadingColumn * _cellSize) - horizontalOffset.pixels;
    for (int column = leadingColumn; column <= trailingColumn; column++) {
      double yLayoutOffset =
          (leadingRow * _cellSize) - verticalOffset.pixels;
      for (int row = leadingRow; row <= trailingRow; row++) {
        final ChildVicinity vicinity =
            ChildVicinity(xIndex: column, yIndex: row);
        final RenderBox? child = buildOrObtainChildFor(vicinity);
        if (child != null) {
          child.layout(
            constraints.tighten(width: _cellSize, height: _cellSize),
          );
          parentDataOf(child).layoutOffset =
              Offset(xLayoutOffset, yLayoutOffset);
        }
        yLayoutOffset += _cellSize;
      }
      xLayoutOffset += _cellSize;
    }

    // Apply content dimensions so the scroll bars and overscroll math work.
    final double verticalExtent = _cellSize * (maxRowIndex + 1);
    verticalOffset.applyContentDimensions(
      0.0,
      clampDouble(verticalExtent - viewportHeight, 0.0, double.infinity),
    );
    final double horizontalExtent = _cellSize * (maxColumnIndex + 1);
    horizontalOffset.applyContentDimensions(
      0.0,
      clampDouble(horizontalExtent - viewportWidth, 0.0, double.infinity),
    );
  }
}

