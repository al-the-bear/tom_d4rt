// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// =============================================================================
//  PointerScrollEvent — Deep Visual Reference
// =============================================================================
//
//  This file is a single-screen, hand-authored visual exploration of the class
//  `PointerScrollEvent` from `package:flutter/gestures.dart`. It is rendered
//  inside a sandboxed Flutter test harness; therefore there are NO stateful
//  widgets, NO controllers, NO timers, NO async work. Every "animation" is a
//  static snapshot driven by `AlwaysStoppedAnimation<double>` with a constant.
//
//  Visual identity for THIS file:
//    palette  : deep abyss / aurora — midnight indigo, plasma violet, kelp
//                green, tide foam, signal amber.
//    metaphor : a scroll wheel as a luminous pulsar, with scrollDelta drawn
//                as ribbons of phosphorescent ink across the canvas.
//
//  Sections (all stacked top-to-bottom, single scroll axis):
//    1.  Hero header — class name, parent chain, one-line elevator pitch.
//    2.  Anatomy diagram — a stylised mouse rendered with CustomPaint and
//        nested containers, with arrows showing scrollDelta vectors.
//    3.  Field reference grid — every PointerScrollEvent field as a card.
//    4.  Synthetic event log — a list of fabricated PointerScrollEvent
//        snapshots, each shown as a "ticker tape" record.
//    5.  Magnitude matrix — a 3x3 grid of scroll deltas at small / medium /
//        large magnitude across vertical / horizontal / diagonal directions.
//    6.  Cumulative scroll preview — a fake document whose scroll offset is
//        derived (pure-Dart) from a synthetic event sequence.
//    7.  Comparison table — PointerScrollEvent vs PointerPanZoomUpdateEvent
//        vs PointerHoverEvent vs PointerScrollInertiaCancelEvent.
//    8.  Code recipe cards — formatted snippets showing how to handle scroll
//        signals inside a Listener / RawGestureDetector.
//    9.  Edge cases — zero-delta, NaN-guard, very-large delta, mouse-vs-pad.
//    10. Construction sandbox — try/catch wrappers around runtime PSE
//        construction, each variant rendered as a labelled chip card.
//    11. Footer — summary card and references list.
//
// =============================================================================

dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFF050714),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
        child: const _PageBody(),
      ),
    ),
  );
}

// =============================================================================
//  Palette & shared design tokens
// =============================================================================

class _Palette {
  static const Color abyss = Color(0xFF050714);
  static const Color midnight = Color(0xFF0B0E2A);
  static const Color indigo = Color(0xFF1A1F4D);
  static const Color violet = Color(0xFF6C3CE9);
  static const Color plasma = Color(0xFFB47BFF);
  static const Color kelp = Color(0xFF1F8F76);
  static const Color foam = Color(0xFFCBE9DF);
  static const Color amber = Color(0xFFF7B500);
  static const Color signal = Color(0xFFFF5A8B);
  static const Color ink = Color(0xFFE7E9F8);
  static const Color faint = Color(0xFF8A8FB8);
  static const Color line = Color(0xFF272C55);
}

class _Type {
  static const TextStyle hero = TextStyle(
    color: _Palette.ink,
    fontSize: 30,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.8,
    height: 1.05,
  );
  static const TextStyle h1 = TextStyle(
    color: _Palette.ink,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
  );
  static const TextStyle h2 = TextStyle(
    color: _Palette.foam,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );
  static const TextStyle body = TextStyle(
    color: _Palette.ink,
    fontSize: 13.5,
    height: 1.45,
  );
  static const TextStyle dim = TextStyle(
    color: _Palette.faint,
    fontSize: 12.5,
    height: 1.45,
  );
  static const TextStyle label = TextStyle(
    color: _Palette.plasma,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.4,
  );
  static const TextStyle mono = TextStyle(
    color: _Palette.foam,
    fontSize: 12.5,
    fontFamily: 'monospace',
    height: 1.55,
  );
  static const TextStyle monoDim = TextStyle(
    color: _Palette.faint,
    fontSize: 12,
    fontFamily: 'monospace',
    height: 1.55,
  );
  static const TextStyle tag = TextStyle(
    color: _Palette.amber,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.6,
  );
}

// =============================================================================
//  Page assembly
// =============================================================================

class _PageBody extends StatelessWidget {
  const _PageBody();

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = <Widget>[];

    sections.add(_buildHero());
    sections.add(_gap(24));
    sections.add(_buildAnatomy());
    sections.add(_gap(28));
    sections.add(_buildFieldReference());
    sections.add(_gap(28));
    sections.add(_buildSyntheticLog());
    sections.add(_gap(28));
    sections.add(_buildMagnitudeMatrix());
    sections.add(_gap(28));
    sections.add(_buildCumulativePreview());
    sections.add(_gap(28));
    sections.add(_buildComparisonTable());
    sections.add(_gap(28));
    sections.add(_buildRecipeCards());
    sections.add(_gap(28));
    sections.add(_buildEdgeCases());
    sections.add(_gap(28));
    sections.add(_buildConstructionSandbox());
    sections.add(_gap(28));
    sections.add(_buildFooter());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: sections,
    );
  }

  Widget _gap(double h) => SizedBox(height: h);

  // ---------------------------------------------------------------------------
  //  Section 1 — Hero header
  // ---------------------------------------------------------------------------
  Widget _buildHero() {
    return _GlowFrame(
      gradient: const <Color>[
        Color(0xFF12174A),
        Color(0xFF1F1056),
        Color(0xFF3A1771),
      ],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                _PulsarBadge(seed: 0.42),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('CLASS REFERENCE', style: _Type.label),
                      const SizedBox(height: 6),
                      const Text('PointerScrollEvent', style: _Type.hero),
                      const SizedBox(height: 6),
                      Text(
                        'package:flutter/gestures.dart',
                        style: _Type.dim.copyWith(fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const _Divider(),
            const SizedBox(height: 14),
            const Text(
              'PointerScrollEvent is the discrete pointer-signal that fires '
              'when a mouse wheel rotates or a trackpad emits a scroll '
              'tick. It is the canonical carrier of the field that defines '
              'it: scrollDelta — an Offset describing how much the scroll '
              'surface should advance along each axis.',
              style: _Type.body,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _Chip(text: 'extends PointerSignalEvent', color: _Palette.violet),
                _Chip(text: 'extends PointerEvent', color: _Palette.kelp),
                _Chip(text: 'immutable', color: _Palette.amber),
                _Chip(text: 'discrete', color: _Palette.signal),
                _Chip(text: 'non-positional dispatch', color: _Palette.plasma),
              ],
            ),
            const SizedBox(height: 14),
            _InheritanceLadder(),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  //  Section 2 — Anatomy diagram
  // ---------------------------------------------------------------------------
  Widget _buildAnatomy() {
    return _Section(
      title: '02 · Anatomy of a scroll signal',
      caption:
          'The "wheel" is a synthesised input. Each tick of the wheel '
          'becomes one PointerScrollEvent whose scrollDelta encodes the '
          'magnitude AND direction of that tick. The axes below are '
          'Flutter conventions: +x is right, +y is downward.',
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
        decoration: _panelDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 220,
              height: 280,
              child: CustomPaint(
                painter: _MouseAnatomyPainter(
                  pulse: const AlwaysStoppedAnimation<double>(0.62),
                ),
              ),
            ),
            const SizedBox(width: 18),
            Expanded(child: _anatomyLegend()),
          ],
        ),
      ),
    );
  }

  Widget _anatomyLegend() {
    final List<List<String>> rows = <List<String>>[
      <String>['scrollDelta.dy < 0', 'wheel rolled away from user', 'scroll up'],
      <String>['scrollDelta.dy > 0', 'wheel rolled toward user', 'scroll down'],
      <String>['scrollDelta.dx != 0', 'shift+wheel or sideways trackpad', 'pan'],
      <String>['delta == Offset.zero', 'always — scroll has no drag delta', '—'],
      <String>['kind == mouse', 'discrete tick, often integer multiples', 'wheel'],
      <String>['kind == trackpad', 'continuous pixel deltas', 'pad'],
    ];

    final List<Widget> children = <Widget>[];
    children.add(const Text('Field semantics', style: _Type.h2));
    children.add(const SizedBox(height: 10));

    for (int i = 0; i < rows.length; i++) {
      final List<String> r = rows[i];
      children.add(_legendRow(r[0], r[1], r[2]));
      if (i != rows.length - 1) {
        children.add(const SizedBox(height: 10));
      }
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }

  Widget _legendRow(String code, String desc, String tag) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 160,
          child: Text(code, style: _Type.mono),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(desc, style: _Type.body),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: _Palette.amber.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _Palette.amber.withValues(alpha: 0.4)),
          ),
          child: Text(tag, style: _Type.tag),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  //  Section 3 — Field reference
  // ---------------------------------------------------------------------------
  Widget _buildFieldReference() {
    final List<_FieldSpec> specs = _fieldSpecs();
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < specs.length; i += 2) {
      final _FieldSpec a = specs[i];
      final _FieldSpec? b = (i + 1 < specs.length) ? specs[i + 1] : null;
      // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #27, P1):
      // Stretch-Row in pair-card grid inside the unbounded vertical
      // viewport — wrap in IntrinsicHeight so Expanded(_FieldCard) pairs
      // share the tallest card's height with finite constraints.
      rows.add(IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: _FieldCard(spec: a)),
            const SizedBox(width: 12),
            Expanded(
              child: b == null
                  ? const SizedBox.shrink()
                  : _FieldCard(spec: b),
            ),
          ],
        ),
      ));
      if (i + 2 < specs.length) {
        rows.add(const SizedBox(height: 12));
      }
    }

    return _Section(
      title: '03 · Field reference',
      caption:
          'PointerScrollEvent inherits ~30 fields from PointerEvent and '
          'PointerSignalEvent. The cards below enumerate the fields that '
          'matter at the point of handling a scroll tick.',
      child: Column(children: rows),
    );
  }

  List<_FieldSpec> _fieldSpecs() {
    return <_FieldSpec>[
      _FieldSpec(
        name: 'scrollDelta',
        type: 'Offset',
        sample: 'Offset(0.0, 53.0)',
        note:
            'The defining field. Pixels (or device units) the surface should '
            'advance. Signed, can be diagonal.',
        accent: _Palette.signal,
      ),
      _FieldSpec(
        name: 'position',
        type: 'Offset',
        sample: 'Offset(412.5, 218.0)',
        note: 'Global pointer position at the moment the tick arrived.',
        accent: _Palette.violet,
      ),
      _FieldSpec(
        name: 'localPosition',
        type: 'Offset',
        sample: 'Offset(48.0, 12.0)',
        note: 'Position relative to the receiver (set by the dispatcher).',
        accent: _Palette.violet,
      ),
      _FieldSpec(
        name: 'delta',
        type: 'Offset',
        sample: 'Offset.zero',
        note:
            'Always Offset.zero for a scroll signal. Scroll has no drag '
            'delta — use scrollDelta instead.',
        accent: _Palette.kelp,
      ),
      _FieldSpec(
        name: 'kind',
        type: 'PointerDeviceKind',
        sample: 'PointerDeviceKind.mouse',
        note:
            'mouse, trackpad, stylus, … . Trackpad scroll is often emitted '
            'as PointerPanZoom* instead, on platforms that expose it.',
        accent: _Palette.amber,
      ),
      _FieldSpec(
        name: 'device',
        type: 'int',
        sample: '0',
        note: 'Stable id of the originating device for this engine instance.',
        accent: _Palette.foam,
      ),
      _FieldSpec(
        name: 'pointer',
        type: 'int',
        sample: '0',
        note: 'Pointer id; zero for signal events on most platforms.',
        accent: _Palette.foam,
      ),
      _FieldSpec(
        name: 'timeStamp',
        type: 'Duration',
        sample: 'Duration(milliseconds: 12_843)',
        note: 'Engine clock at dispatch. Useful for velocity estimation.',
        accent: _Palette.plasma,
      ),
      _FieldSpec(
        name: 'embedderId',
        type: 'int',
        sample: '0',
        note: 'Embedder-supplied id for cross-process correlation.',
        accent: _Palette.plasma,
      ),
      _FieldSpec(
        name: 'buttons',
        type: 'int',
        sample: '0',
        note: 'Bitmask of buttons held — zero for a plain wheel tick.',
        accent: _Palette.kelp,
      ),
      _FieldSpec(
        name: 'pressure',
        type: 'double',
        sample: '0.0',
        note: 'Always 0.0 for scroll signals — wheels do not report pressure.',
        accent: _Palette.kelp,
      ),
      _FieldSpec(
        name: 'synthesized',
        type: 'bool',
        sample: 'false',
        note:
            'true if Flutter manufactured this event itself (rare for '
            'scroll, common for hover bookkeeping).',
        accent: _Palette.signal,
      ),
    ];
  }

  // ---------------------------------------------------------------------------
  //  Section 4 — Synthetic event log
  // ---------------------------------------------------------------------------
  Widget _buildSyntheticLog() {
    final List<_SyntheticTick> ticks = _syntheticTicks();
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < ticks.length; i++) {
      rows.add(_TickerRow(tick: ticks[i], index: i));
      if (i != ticks.length - 1) {
        rows.add(const SizedBox(height: 8));
      }
    }
    return _Section(
      title: '04 · Synthetic event log',
      caption:
          'A fabricated stream of 14 scroll ticks spanning a slow read, a '
          'flick, a horizontal pan, a stutter, and a trailing tail.',
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        decoration: _panelDecoration(),
        child: Column(children: rows),
      ),
    );
  }

  List<_SyntheticTick> _syntheticTicks() {
    return <_SyntheticTick>[
      _SyntheticTick(t: 12_840, dx: 0, dy: 32, kind: 'mouse', tag: 'read'),
      _SyntheticTick(t: 12_972, dx: 0, dy: 32, kind: 'mouse', tag: 'read'),
      _SyntheticTick(t: 13_115, dx: 0, dy: 53, kind: 'trackpad', tag: 'flick'),
      _SyntheticTick(t: 13_133, dx: 0, dy: 96, kind: 'trackpad', tag: 'flick'),
      _SyntheticTick(t: 13_158, dx: 0, dy: 142, kind: 'trackpad', tag: 'flick'),
      _SyntheticTick(t: 13_191, dx: 0, dy: 184, kind: 'trackpad', tag: 'flick'),
      _SyntheticTick(t: 13_407, dx: -64, dy: 0, kind: 'trackpad', tag: 'pan'),
      _SyntheticTick(t: 13_424, dx: -88, dy: 0, kind: 'trackpad', tag: 'pan'),
      _SyntheticTick(t: 13_682, dx: 22, dy: 14, kind: 'trackpad', tag: 'drift'),
      _SyntheticTick(t: 13_910, dx: 0, dy: 0, kind: 'mouse', tag: 'stutter'),
      _SyntheticTick(t: 14_144, dx: 0, dy: -32, kind: 'mouse', tag: 'reverse'),
      _SyntheticTick(t: 14_312, dx: 0, dy: -32, kind: 'mouse', tag: 'reverse'),
      _SyntheticTick(t: 14_502, dx: 0, dy: -16, kind: 'trackpad', tag: 'tail'),
      _SyntheticTick(t: 14_810, dx: 0, dy: -4, kind: 'trackpad', tag: 'tail'),
    ];
  }

  // ---------------------------------------------------------------------------
  //  Section 5 — Magnitude matrix
  // ---------------------------------------------------------------------------
  Widget _buildMagnitudeMatrix() {
    final List<List<Offset>> grid = <List<Offset>>[
      <Offset>[
        const Offset(0, 16),
        const Offset(0, 64),
        const Offset(0, 240),
      ],
      <Offset>[
        const Offset(16, 0),
        const Offset(64, 0),
        const Offset(240, 0),
      ],
      <Offset>[
        const Offset(11, 11),
        const Offset(45, 45),
        const Offset(170, 170),
      ],
    ];
    final List<String> rowLabels = <String>['vertical', 'horizontal', 'diagonal'];
    final List<String> colLabels = <String>['small (16px)', 'medium (64px)', 'large (240px)'];

    final List<Widget> headerCells = <Widget>[
      _matrixHeaderCell('axis ↓ / size →', isHeader: true),
    ];
    for (int c = 0; c < colLabels.length; c++) {
      headerCells.add(_matrixHeaderCell(colLabels[c]));
    }

    final List<Widget> rows = <Widget>[];
    rows.add(Row(children: _flexEqual(headerCells)));
    for (int r = 0; r < grid.length; r++) {
      final List<Widget> cells = <Widget>[];
      cells.add(_matrixHeaderCell(rowLabels[r]));
      for (int c = 0; c < grid[r].length; c++) {
        cells.add(_MatrixCell(delta: grid[r][c]));
      }
      rows.add(const SizedBox(height: 1));
      // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #27, P1):
      // Stretch-Row inside the unbounded SingleChildScrollView gets
      // infinite cross-axis constraints. IntrinsicHeight gives the row
      // a finite height matching its tallest cell.
      rows.add(IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _flexEqual(cells),
        ),
      ));
    }

    return _Section(
      title: '05 · Magnitude × axis matrix',
      caption:
          'Each cell shows the scrollDelta arrow at relative scale within '
          'its 96×96 viewport. The grid demonstrates how the same field '
          'encodes nine qualitatively different scroll behaviours.',
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: _panelDecoration(),
        child: Column(children: rows),
      ),
    );
  }

  List<Widget> _flexEqual(List<Widget> children) {
    final List<Widget> out = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      out.add(Expanded(child: children[i]));
    }
    return out;
  }

  Widget _matrixHeaderCell(String text, {bool isHeader = false}) {
    return Container(
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isHeader ? Colors.transparent : _Palette.indigo.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: _Type.dim.copyWith(
          color: isHeader ? _Palette.faint : _Palette.foam,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  //  Section 6 — Cumulative scroll preview
  // ---------------------------------------------------------------------------
  Widget _buildCumulativePreview() {
    final List<_SyntheticTick> ticks = _syntheticTicks();
    final List<double> cumulativeY = <double>[];
    double accY = 0.0;
    for (int i = 0; i < ticks.length; i++) {
      accY += ticks[i].dy;
      cumulativeY.add(accY);
    }
    final double finalOffset = accY;

    return _Section(
      title: '06 · Derived scroll position',
      caption:
          'Pure-Dart simulation: the synthetic stream from §4 is summed '
          'into a vertical scroll offset. A virtual document is shifted '
          'by that offset; no real scrolling happens.',
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _panelDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 280,
                  color: _Palette.midnight,
                  child: ClipRect(
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 0,
                          right: 0,
                          top: -finalOffset.clamp(0.0, 600.0),
                          child: _virtualDocument(),
                        ),
                        Positioned(
                          right: 6,
                          top: 6,
                          bottom: 6,
                          width: 6,
                          child: _scrollIndicator(finalOffset),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: _cumulativeChart(cumulativeY),
            ),
          ],
        ),
      ),
    );
  }

  Widget _virtualDocument() {
    final List<Widget> paragraphs = <Widget>[];
    final List<String> lines = <String>[
      'The deep field of Pointer Signals',
      '',
      'A pointer signal is a discrete announcement, not a',
      'continuous gesture. It arrives, it carries a payload,',
      'it leaves. The scroll wheel and the trackpad both',
      'speak this language; the wheel speaks it slowly, in',
      'integer-flavoured ticks, while the trackpad speaks it',
      'in a fluent stream of small pixel deltas.',
      '',
      'In Flutter, the carrier is PointerScrollEvent, and the',
      'word it carries is scrollDelta. Everything else is',
      'context — when, where, by which device — but the',
      'verb of the message is the delta.',
      '',
      'Treat scrollDelta as a vector, not a scalar: dx and dy',
      'are independent axes, and a single tick may move both.',
      'A two-finger trackpad swipe will routinely yield events',
      'with non-zero values on both axes.',
      '',
      'When you sum scroll deltas to derive a position, you',
      'are reconstructing what the OS, in another universe,',
      'might have done for you. In Flutter, the OS gives you',
      'the deltas and lets your widget decide what scroll',
      'means in this particular surface.',
    ];
    for (int i = 0; i < lines.length; i++) {
      paragraphs.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        child: Text(
          lines[i],
          style: _Type.body.copyWith(
            color: i == 0 ? _Palette.amber : _Palette.ink,
            fontWeight: i == 0 ? FontWeight.w700 : FontWeight.w400,
            fontSize: i == 0 ? 16 : 13,
          ),
        ),
      ));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: paragraphs,
      ),
    );
  }

  Widget _scrollIndicator(double offset) {
    final double frac = (offset / 600.0).clamp(0.0, 1.0);
    return CustomPaint(
      painter: _ScrollbarPainter(fraction: frac),
    );
  }

  Widget _cumulativeChart(List<double> values) {
    return Container(
      height: 280,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _Palette.midnight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _Palette.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Cumulative dy', style: _Type.h2),
          const SizedBox(height: 6),
          Text(
            'final offset: ${values.isEmpty ? "0" : values[values.length - 1].toStringAsFixed(0)} px',
            style: _Type.dim,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: CustomPaint(
              painter: _LineChartPainter(values: values),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  //  Section 7 — Comparison table
  // ---------------------------------------------------------------------------
  Widget _buildComparisonTable() {
    final List<List<String>> data = <List<String>>[
      <String>[
        'aspect',
        'PointerScrollEvent',
        'PointerPanZoomUpdateEvent',
        'PointerHoverEvent',
        'PointerScrollInertiaCancelEvent',
      ],
      <String>[
        'parent',
        'PointerSignalEvent',
        'PointerEvent',
        'PointerEvent',
        'PointerSignalEvent',
      ],
      <String>[
        'fires from',
        'wheel / trackpad scroll',
        'two-finger trackpad gesture',
        'mouse motion (no buttons)',
        'fling cancel from OS',
      ],
      <String>[
        'principal field',
        'scrollDelta : Offset',
        'pan + scale + rotation',
        'position : Offset',
        '— (signal only)',
      ],
      <String>[
        'cumulative?',
        'no — discrete ticks',
        'yes — gesture-bounded',
        'no — sampled motion',
        'no — one-shot',
      ],
      <String>[
        'inertia handled by',
        'OS (mouse) / OS (pad)',
        'Flutter recogniser',
        'n/a',
        'cancels Flutter inertia',
      ],
      <String>[
        'typical handler',
        'Listener.onPointerSignal',
        'PanZoomGestureRecognizer',
        'MouseRegion / Listener',
        'Listener.onPointerSignal',
      ],
      <String>[
        'kind values',
        'mouse, trackpad',
        'trackpad',
        'mouse, stylus, trackpad',
        'mouse, trackpad',
      ],
    ];

    return _Section(
      title: '07 · Family comparison',
      caption:
          'PointerScrollEvent sits within a small family of pointer-related '
          'event types. Knowing the boundary between scroll-as-signal and '
          'scroll-as-gesture is what lets you handle trackpad input '
          'correctly across platforms.',
      child: _ComparisonTable(rows: data),
    );
  }

  // ---------------------------------------------------------------------------
  //  Section 8 — Code recipe cards
  // ---------------------------------------------------------------------------
  Widget _buildRecipeCards() {
    final List<_Recipe> recipes = <_Recipe>[
      _Recipe(
        title: 'Listener — minimum viable handler',
        purpose:
            'Catch every wheel tick that lands inside a widget subtree.',
        snippet: <_Span>[
          _Span('Listener', _Palette.violet),
          _Span('(\n  ', _Palette.foam),
          _Span('onPointerSignal', _Palette.amber),
          _Span(': (', _Palette.foam),
          _Span('PointerSignalEvent', _Palette.violet),
          _Span(' e) {\n    ', _Palette.foam),
          _Span('if', _Palette.signal),
          _Span(' (e ', _Palette.foam),
          _Span('is', _Palette.signal),
          _Span(' ', _Palette.foam),
          _Span('PointerScrollEvent', _Palette.violet),
          _Span(') {\n      ', _Palette.foam),
          _Span('// e.scrollDelta — the payload', _Palette.faint),
          _Span('\n    }\n  },\n  ', _Palette.foam),
          _Span('child', _Palette.amber),
          _Span(': child,\n)', _Palette.foam),
        ],
      ),
      _Recipe(
        title: 'Routing through GestureBinding',
        purpose:
            'Forward to the binding so default scroll inertia works on '
            'platforms that supply it.',
        snippet: <_Span>[
          _Span('void', _Palette.signal),
          _Span(' ', _Palette.foam),
          _Span('_onSignal', _Palette.amber),
          _Span('(', _Palette.foam),
          _Span('PointerSignalEvent', _Palette.violet),
          _Span(' e) {\n  ', _Palette.foam),
          _Span('if', _Palette.signal),
          _Span(' (e ', _Palette.foam),
          _Span('is', _Palette.signal),
          _Span(' ', _Palette.foam),
          _Span('PointerScrollEvent', _Palette.violet),
          _Span(') {\n    ', _Palette.foam),
          _Span('GestureBinding', _Palette.violet),
          _Span('.instance.pointerSignalResolver\n        .register(e, _handle);\n  }\n}\n\n', _Palette.foam),
          _Span('void', _Palette.signal),
          _Span(' ', _Palette.foam),
          _Span('_handle', _Palette.amber),
          _Span('(', _Palette.foam),
          _Span('PointerSignalEvent', _Palette.violet),
          _Span(' e) {\n  ', _Palette.foam),
          _Span('final', _Palette.signal),
          _Span(' s = e ', _Palette.foam),
          _Span('as', _Palette.signal),
          _Span(' ', _Palette.foam),
          _Span('PointerScrollEvent', _Palette.violet),
          _Span(';\n  scroll(s.scrollDelta);\n}', _Palette.foam),
        ],
      ),
      _Recipe(
        title: 'Distinguishing mouse from trackpad',
        purpose:
            'Apply different multipliers — wheels are coarse, pads are fine.',
        snippet: <_Span>[
          _Span('final', _Palette.signal),
          _Span(' ', _Palette.foam),
          _Span('Offset', _Palette.violet),
          _Span(' raw = e.scrollDelta;\n', _Palette.foam),
          _Span('final', _Palette.signal),
          _Span(' ', _Palette.foam),
          _Span('double', _Palette.violet),
          _Span(' factor = e.kind == ', _Palette.foam),
          _Span('PointerDeviceKind', _Palette.violet),
          _Span('.mouse\n    ? 1.0\n    : 0.55;\n', _Palette.foam),
          _Span('final', _Palette.signal),
          _Span(' tuned = raw * factor;', _Palette.foam),
        ],
      ),
      _Recipe(
        title: 'Velocity from timeStamp',
        purpose:
            'Estimate scroll velocity by differencing consecutive scroll '
            'events on their timeStamp field.',
        snippet: <_Span>[
          _Span('final', _Palette.signal),
          _Span(' dt = (e.timeStamp - last.timeStamp)\n    .inMicroseconds / 1e6;\n', _Palette.foam),
          _Span('final', _Palette.signal),
          _Span(' v = dt > 0\n    ? e.scrollDelta / dt\n    : ', _Palette.foam),
          _Span('Offset', _Palette.violet),
          _Span('.zero;', _Palette.foam),
        ],
      ),
    ];

    final List<Widget> cards = <Widget>[];
    for (int i = 0; i < recipes.length; i++) {
      cards.add(_RecipeCard(recipe: recipes[i]));
      if (i != recipes.length - 1) {
        cards.add(const SizedBox(height: 12));
      }
    }

    return _Section(
      title: '08 · Recipes',
      caption:
          'Idiomatic ways to handle scroll signals. Each card shows a '
          'short, complete fragment; none are runnable here, they are '
          'documentation.',
      child: Column(children: cards),
    );
  }

  // ---------------------------------------------------------------------------
  //  Section 9 — Edge cases
  // ---------------------------------------------------------------------------
  Widget _buildEdgeCases() {
    final List<_EdgeCase> cases = <_EdgeCase>[
      _EdgeCase(
        title: 'scrollDelta == Offset.zero',
        body:
            'Some platforms emit zero-delta ticks as keep-alive or to mark '
            'the end of a fling. Always check before applying the delta.',
        guard: 'if (e.scrollDelta == Offset.zero) return;',
        accent: _Palette.amber,
      ),
      _EdgeCase(
        title: 'NaN / infinite delta',
        body:
            'Misbehaving driver or hostile injector can yield NaN. Cheap '
            'guard: clamp by a sane absolute maximum.',
        guard: 'final dy = e.scrollDelta.dy.clamp(-2000.0, 2000.0);',
        accent: _Palette.signal,
      ),
      _EdgeCase(
        title: 'Very large delta from accelerated wheel',
        body:
            'Accelerated wheel drivers may report >500px per tick. Decide '
            'whether to honour them or saturate.',
        guard: 'final s = (e.scrollDelta.dy.abs() > 400) ? 400.0 : e.scrollDelta.dy;',
        accent: _Palette.violet,
      ),
      _EdgeCase(
        title: 'Trackpad gestures on Wayland',
        body:
            'On some Wayland sessions, trackpad scroll fires as scroll '
            'signals; on others as PointerPanZoom. Handle both for '
            'cross-platform stability.',
        guard: '// register handlers for both scroll AND panZoomUpdate',
        accent: _Palette.kelp,
      ),
      _EdgeCase(
        title: 'Pre-empted by inner scrollable',
        body:
            'A nested ScrollView consumes wheel ticks before your Listener '
            'sees them. Wrap with a NotificationListener if you need '
            'visibility into resolved scroll changes instead.',
        guard:
            'NotificationListener<ScrollNotification>(onNotification: …)',
        accent: _Palette.plasma,
      ),
      _EdgeCase(
        title: 'High-DPI scaling',
        body:
            'scrollDelta is in logical pixels already; do NOT multiply by '
            'devicePixelRatio. Doing so produces jet-fighter scrolling on '
            '4K screens.',
        guard: '// treat scrollDelta as logical px, never physical px',
        accent: _Palette.foam,
      ),
    ];

    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < cases.length; i += 2) {
      final _EdgeCase a = cases[i];
      final _EdgeCase? b = (i + 1 < cases.length) ? cases[i + 1] : null;
      // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #27, P1):
      // Stretch-Row in edge-case pair grid inside the unbounded vertical
      // viewport — wrap in IntrinsicHeight to scope the cross-axis size.
      rows.add(IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: _EdgeCaseCard(data: a)),
            const SizedBox(width: 12),
            Expanded(
              child: b == null
                  ? const SizedBox.shrink()
                  : _EdgeCaseCard(data: b),
            ),
          ],
        ),
      ));
      if (i + 2 < cases.length) {
        rows.add(const SizedBox(height: 12));
      }
    }

    return _Section(
      title: '09 · Edge cases',
      caption:
          'Six places where naïve scroll handling falls over. Each card is '
          'small enough to copy and adapt as a guard clause.',
      child: Column(children: rows),
    );
  }

  // ---------------------------------------------------------------------------
  //  Section 10 — Construction sandbox
  // ---------------------------------------------------------------------------
  Widget _buildConstructionSandbox() {
    final List<Widget> tiles = <Widget>[];
    final List<_Variant> variants = <_Variant>[
      _Variant(
        label: 'mouse · vertical · small',
        position: const Offset(120, 80),
        scrollDelta: const Offset(0, 32),
        kind: PointerDeviceKind.mouse,
        accent: _Palette.violet,
      ),
      _Variant(
        label: 'mouse · vertical · large',
        position: const Offset(220, 140),
        scrollDelta: const Offset(0, 240),
        kind: PointerDeviceKind.mouse,
        accent: _Palette.violet,
      ),
      _Variant(
        label: 'mouse · reverse',
        position: const Offset(320, 200),
        scrollDelta: const Offset(0, -64),
        kind: PointerDeviceKind.mouse,
        accent: _Palette.amber,
      ),
      _Variant(
        label: 'trackpad · diagonal',
        position: const Offset(420, 260),
        scrollDelta: const Offset(48, 48),
        kind: PointerDeviceKind.trackpad,
        accent: _Palette.kelp,
      ),
      _Variant(
        label: 'trackpad · pure horizontal',
        position: const Offset(520, 320),
        scrollDelta: const Offset(72, 0),
        kind: PointerDeviceKind.trackpad,
        accent: _Palette.kelp,
      ),
      _Variant(
        label: 'trackpad · zero (keep-alive)',
        position: const Offset(620, 380),
        scrollDelta: Offset.zero,
        kind: PointerDeviceKind.trackpad,
        accent: _Palette.signal,
      ),
    ];

    for (int i = 0; i < variants.length; i++) {
      tiles.add(_VariantCard(variant: variants[i]));
    }

    return _Section(
      title: '10 · Construction sandbox',
      caption:
          'Each card constructs a real PointerScrollEvent at runtime '
          'inside try/catch and renders the surviving instance. Construction '
          'is wrapped because some variants assert on certain Flutter '
          'engine builds.',
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: tiles,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  //  Section 11 — Footer
  // ---------------------------------------------------------------------------
  Widget _buildFooter() {
    return _GlowFrame(
      gradient: const <Color>[
        Color(0xFF0A0F33),
        Color(0xFF110A33),
        Color(0xFF050714),
      ],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('TAKEAWAYS', style: _Type.label),
            const SizedBox(height: 8),
            const Text(
              '— scrollDelta is the verb; everything else is context.\n'
              '— delta is always Offset.zero on a scroll signal.\n'
              '— mouse vs trackpad: same event class, very different magnitudes.\n'
              '— treat scroll signals as discrete ticks, not as a stream.\n'
              '— on Wayland, also handle PointerPanZoomUpdateEvent.\n'
              '— scrollDelta is in logical pixels; never re-scale by DPR.',
              style: _Type.body,
            ),
            const SizedBox(height: 14),
            const _Divider(),
            const SizedBox(height: 12),
            const Text('REFERENCES', style: _Type.label),
            const SizedBox(height: 8),
            Text(
              'flutter/lib/src/gestures/events.dart\n'
              'flutter/lib/src/gestures/binding.dart  (PointerSignalResolver)\n'
              'flutter/lib/src/widgets/listener.dart\n'
              'PointerEventConverter (engine bridge)',
              style: _Type.mono.copyWith(color: _Palette.faint),
            ),
            const SizedBox(height: 14),
            Row(
              children: <Widget>[
                _Chip(text: 'rendered with CustomPaint', color: _Palette.kelp),
                const SizedBox(width: 8),
                _Chip(text: 'no controllers', color: _Palette.amber),
                const SizedBox(width: 8),
                _Chip(text: 'no async', color: _Palette.signal),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  //  Shared decorations
  // ---------------------------------------------------------------------------
  BoxDecoration _panelDecoration() {
    return BoxDecoration(
      color: _Palette.midnight,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _Palette.line),
    );
  }
}

// =============================================================================
//  _Section — common header + caption + body wrapper
// =============================================================================

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.caption,
    required this.child,
  });

  final String title;
  final String caption;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(right: 10),
              decoration: const BoxDecoration(
                color: _Palette.plasma,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(child: Text(title, style: _Type.h1)),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(caption, style: _Type.dim),
        ),
        const SizedBox(height: 14),
        child,
      ],
    );
  }
}

// =============================================================================
//  _GlowFrame — gradient hero panel
// =============================================================================

class _GlowFrame extends StatelessWidget {
  const _GlowFrame({required this.child, required this.gradient});

  final Widget child;
  final List<Color> gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        border: Border.all(color: _Palette.violet.withValues(alpha: 0.35)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _Palette.violet.withValues(alpha: 0.25),
            blurRadius: 20,
            spreadRadius: -8,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

// =============================================================================
//  _Divider, _Chip, _PulsarBadge, _InheritanceLadder
// =============================================================================

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            _Palette.violet.withValues(alpha: 0.0),
            _Palette.violet.withValues(alpha: 0.55),
            _Palette.violet.withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _PulsarBadge extends StatelessWidget {
  const _PulsarBadge({required this.seed});

  final double seed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: CustomPaint(
        painter: _PulsarPainter(
          phase: AlwaysStoppedAnimation<double>(seed),
        ),
      ),
    );
  }
}

class _PulsarPainter extends CustomPainter {
  _PulsarPainter({required this.phase});

  final Animation<double> phase;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset c = Offset(size.width / 2, size.height / 2);
    final double r = size.shortestSide / 2;
    final double t = phase.value;

    for (int i = 6; i >= 0; i--) {
      final double f = i / 6.0;
      final Paint ring = Paint()
        ..color = _Palette.violet.withValues(alpha: 0.10 + 0.10 * (1 - f))
        ..style = PaintingStyle.fill;
      canvas.drawCircle(c, r * (0.45 + f * 0.55), ring);
    }

    final Paint core = Paint()
      ..shader = ui.Gradient.radial(
        c,
        r * 0.55,
        <Color>[_Palette.amber, _Palette.signal, _Palette.violet],
        <double>[0.0, 0.55, 1.0],
      );
    canvas.drawCircle(c, r * 0.55, core);

    final Paint ray = Paint()
      ..color = _Palette.foam.withValues(alpha: 0.85)
      ..strokeWidth = 1.4;
    for (int i = 0; i < 8; i++) {
      final double a = (i / 8.0) * 6.2831853 + t;
      final Offset p1 = c + Offset.fromDirection(a, r * 0.62);
      final Offset p2 = c + Offset.fromDirection(a, r * 0.95);
      canvas.drawLine(p1, p2, ray);
    }
  }

  @override
  bool shouldRepaint(covariant _PulsarPainter old) => false;
}

class _InheritanceLadder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> chain = <String>[
      'Object',
      'PointerEvent',
      'PointerSignalEvent',
      'PointerScrollEvent',
    ];
    final List<Widget> rungs = <Widget>[];
    for (int i = 0; i < chain.length; i++) {
      final bool last = i == chain.length - 1;
      rungs.add(Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: last ? _Palette.signal.withValues(alpha: 0.18) : _Palette.indigo.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: last ? _Palette.signal : _Palette.violet.withValues(alpha: 0.4),
          ),
        ),
        child: Text(
          chain[i],
          style: _Type.mono.copyWith(
            color: last ? _Palette.signal : _Palette.foam,
            fontWeight: last ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
      ));
      if (!last) {
        rungs.add(const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Text('▸', style: TextStyle(color: _Palette.faint)),
        ));
      }
    }
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: rungs,
    );
  }
}

// =============================================================================
//  _MouseAnatomyPainter
// =============================================================================

class _MouseAnatomyPainter extends CustomPainter {
  _MouseAnatomyPainter({required this.pulse});

  final Animation<double> pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final Rect body = Rect.fromCenter(
      center: Offset(cx, size.height * 0.55),
      width: size.width * 0.62,
      height: size.height * 0.78,
    );

    // Body shadow
    final Paint shadow = Paint()
      ..color = _Palette.violet.withValues(alpha: 0.22)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawRRect(
      RRect.fromRectAndRadius(body.shift(const Offset(0, 8)), const Radius.circular(60)),
      shadow,
    );

    // Body
    final Paint bodyPaint = Paint()
      ..shader = ui.Gradient.linear(
        body.topCenter,
        body.bottomCenter,
        <Color>[const Color(0xFF1B2152), const Color(0xFF0E1230)],
      );
    canvas.drawRRect(
      RRect.fromRectAndRadius(body, const Radius.circular(60)),
      bodyPaint,
    );

    // Body outline
    final Paint outline = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = _Palette.violet.withValues(alpha: 0.55);
    canvas.drawRRect(
      RRect.fromRectAndRadius(body, const Radius.circular(60)),
      outline,
    );

    // Wheel slot
    final Rect slot = Rect.fromCenter(
      center: Offset(cx, body.top + body.height * 0.28),
      width: 24,
      height: 64,
    );
    final Paint slotPaint = Paint()..color = const Color(0xFF05071A);
    canvas.drawRRect(
      RRect.fromRectAndRadius(slot, const Radius.circular(10)),
      slotPaint,
    );

    // Wheel
    final double t = pulse.value;
    final Rect wheel = Rect.fromCenter(
      center: slot.center,
      width: 18,
      height: 50,
    );
    final Paint wheelPaint = Paint()
      ..shader = ui.Gradient.linear(
        wheel.topCenter,
        wheel.bottomCenter,
        <Color>[_Palette.amber, _Palette.signal, _Palette.amber],
      );
    canvas.drawRRect(
      RRect.fromRectAndRadius(wheel, const Radius.circular(8)),
      wheelPaint,
    );

    // Wheel ridges
    final Paint ridge = Paint()
      ..color = _Palette.abyss.withValues(alpha: 0.55)
      ..strokeWidth = 1.2;
    for (int i = 0; i < 7; i++) {
      final double y = wheel.top + 6 + (i / 6.0) * (wheel.height - 12) + t * 2;
      canvas.drawLine(Offset(wheel.left + 2, y), Offset(wheel.right - 2, y), ridge);
    }

    // Wheel glow
    final Paint glow = Paint()
      ..color = _Palette.amber.withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawCircle(slot.center, 22, glow);

    // Up arrow
    _drawArrow(
      canvas,
      Offset(cx + 60, slot.center.dy),
      const Offset(0, -1),
      40,
      _Palette.kelp,
      'scrollDelta.dy < 0',
    );
    // Down arrow
    _drawArrow(
      canvas,
      Offset(cx + 60, slot.center.dy + 60),
      const Offset(0, 1),
      40,
      _Palette.signal,
      'scrollDelta.dy > 0',
    );
    // Left arrow
    _drawArrow(
      canvas,
      Offset(cx - 60, body.center.dy),
      const Offset(-1, 0),
      36,
      _Palette.plasma,
      'scrollDelta.dx',
    );

    // Position pin
    final Paint pin = Paint()..color = _Palette.foam;
    canvas.drawCircle(Offset(cx + 25, slot.center.dy + 12), 4, pin);
    final TextPainter tp = TextPainter(
      text: const TextSpan(
        text: 'position',
        style: TextStyle(color: _Palette.foam, fontSize: 10, fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(cx + 32, slot.center.dy + 6));
  }

  void _drawArrow(Canvas canvas, Offset origin, Offset dir, double length, Color color, String label) {
    final Offset end = origin + Offset(dir.dx * length, dir.dy * length);
    final Paint stem = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(origin, end, stem);
    final Path head = Path();
    final double angle = dir.direction;
    final Offset h1 = end + Offset.fromDirection(angle + 2.6, 8);
    final Offset h2 = end + Offset.fromDirection(angle - 2.6, 8);
    head.moveTo(end.dx, end.dy);
    head.lineTo(h1.dx, h1.dy);
    head.lineTo(h2.dx, h2.dy);
    head.close();
    canvas.drawPath(head, Paint()..color = color);
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(color: color, fontSize: 9.5, fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final Offset labelPos = (dir.dy != 0)
        ? Offset(end.dx + 6, end.dy - 5)
        : Offset(end.dx - tp.width - 4, end.dy - tp.height - 2);
    tp.paint(canvas, labelPos);
  }

  @override
  bool shouldRepaint(covariant _MouseAnatomyPainter old) => false;
}

// =============================================================================
//  _FieldSpec / _FieldCard
// =============================================================================

class _FieldSpec {
  _FieldSpec({
    required this.name,
    required this.type,
    required this.sample,
    required this.note,
    required this.accent,
  });
  final String name;
  final String type;
  final String sample;
  final String note;
  final Color accent;
}

class _FieldCard extends StatelessWidget {
  const _FieldCard({required this.spec});
  final _FieldSpec spec;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: _Palette.midnight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: spec.accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: spec.accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                spec.name,
                style: _Type.mono.copyWith(
                  color: _Palette.ink,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: spec.accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  spec.type,
                  style: TextStyle(
                    color: spec.accent,
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(spec.note, style: _Type.body),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: _Palette.abyss,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _Palette.line),
            ),
            child: Row(
              children: <Widget>[
                const Text(
                  'sample › ',
                  style: TextStyle(
                    color: _Palette.faint,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
                Expanded(
                  child: Text(
                    spec.sample,
                    style: _Type.mono.copyWith(color: _Palette.amber, fontSize: 12),
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

// =============================================================================
//  _SyntheticTick / _TickerRow
// =============================================================================

class _SyntheticTick {
  _SyntheticTick({
    required this.t,
    required this.dx,
    required this.dy,
    required this.kind,
    required this.tag,
  });
  final int t;
  final double dx;
  final double dy;
  final String kind;
  final String tag;
}

class _TickerRow extends StatelessWidget {
  const _TickerRow({required this.tick, required this.index});
  final _SyntheticTick tick;
  final int index;

  Color get _kindColor =>
      tick.kind == 'mouse' ? _Palette.violet : _Palette.kelp;

  IconData get _kindIcon =>
      tick.kind == 'mouse' ? Icons.mouse_outlined : Icons.touch_app_outlined;

  Color get _tagColor {
    switch (tick.tag) {
      case 'flick':
        return _Palette.amber;
      case 'pan':
        return _Palette.plasma;
      case 'reverse':
        return _Palette.signal;
      case 'stutter':
        return _Palette.faint;
      default:
        return _Palette.foam;
    }
  }

  String _ms(int t) {
    final int s = t ~/ 1000;
    final int ms = t % 1000;
    return '${s.toString().padLeft(2, '0')}.${ms.toString().padLeft(3, '0')}s';
  }

  @override
  Widget build(BuildContext context) {
    final double mag = (tick.dx.abs() + tick.dy.abs());
    final double bar = (mag / 240.0).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: index.isEven ? _Palette.indigo.withValues(alpha: 0.35) : _Palette.midnight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 28,
            child: Text(
              '#${index.toString().padLeft(2, '0')}',
              style: _Type.monoDim,
            ),
          ),
          SizedBox(
            width: 86,
            child: Text(_ms(tick.t), style: _Type.mono.copyWith(color: _Palette.foam)),
          ),
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _kindColor.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(_kindIcon, size: 16, color: _kindColor),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 130,
            child: Text(
              'Δ(${tick.dx.toStringAsFixed(0)}, ${tick.dy.toStringAsFixed(0)})',
              style: _Type.mono.copyWith(
                color: tick.dy >= 0 ? _Palette.amber : _Palette.signal,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 6,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: _Palette.abyss,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: bar,
                  child: Container(
                    height: 6,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: _kindColor,
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: _kindColor.withValues(alpha: 0.6),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _tagColor.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _tagColor.withValues(alpha: 0.5)),
            ),
            child: Text(
              tick.tag,
              style: TextStyle(
                color: _tagColor,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
//  _MatrixCell
// =============================================================================

class _MatrixCell extends StatelessWidget {
  const _MatrixCell({required this.delta});
  final Offset delta;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: _Palette.abyss,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _Palette.line),
      ),
      child: CustomPaint(
        painter: _ArrowPainter(delta: delta),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              '(${delta.dx.toStringAsFixed(0)}, ${delta.dy.toStringAsFixed(0)})',
              style: _Type.monoDim.copyWith(fontSize: 10),
            ),
          ),
        ),
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  _ArrowPainter({required this.delta});
  final Offset delta;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    if (delta == Offset.zero) {
      final Paint dot = Paint()..color = _Palette.faint;
      canvas.drawCircle(center, 4, dot);
      return;
    }
    final double mag = delta.distance;
    final double maxR = size.shortestSide * 0.36;
    final double scale = (mag > 240) ? maxR / mag : maxR / 240.0;
    final Offset end = center + delta * scale;

    final Paint stem = Paint()
      ..color = _Palette.plasma
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, end, stem);

    final double angle = (end - center).direction;
    final Path head = Path();
    final Offset h1 = end + Offset.fromDirection(angle + 2.6, 8);
    final Offset h2 = end + Offset.fromDirection(angle - 2.6, 8);
    head.moveTo(end.dx, end.dy);
    head.lineTo(h1.dx, h1.dy);
    head.lineTo(h2.dx, h2.dy);
    head.close();
    canvas.drawPath(head, Paint()..color = _Palette.plasma);

    final Paint origin = Paint()..color = _Palette.amber;
    canvas.drawCircle(center, 2.6, origin);
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter old) => false;
}

// =============================================================================
//  _ScrollbarPainter / _LineChartPainter
// =============================================================================

class _ScrollbarPainter extends CustomPainter {
  _ScrollbarPainter({required this.fraction});
  final double fraction;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint track = Paint()..color = _Palette.line;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(3),
      ),
      track,
    );
    final double thumbHeight = (size.height * 0.25).clamp(20.0, size.height);
    final double maxTop = size.height - thumbHeight;
    final Paint thumb = Paint()..color = _Palette.amber;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, maxTop * fraction, size.width, thumbHeight),
        const Radius.circular(3),
      ),
      thumb,
    );
  }

  @override
  bool shouldRepaint(covariant _ScrollbarPainter old) => old.fraction != fraction;
}

class _LineChartPainter extends CustomPainter {
  _LineChartPainter({required this.values});
  final List<double> values;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;
    double minV = values[0];
    double maxV = values[0];
    for (int i = 1; i < values.length; i++) {
      if (values[i] < minV) minV = values[i];
      if (values[i] > maxV) maxV = values[i];
    }
    if (maxV - minV < 1) {
      maxV = minV + 1;
    }

    final Paint grid = Paint()
      ..color = _Palette.line
      ..strokeWidth = 1;
    for (int i = 0; i < 4; i++) {
      final double y = (i / 3.0) * size.height;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final Path line = Path();
    final Path fill = Path();
    for (int i = 0; i < values.length; i++) {
      final double x = (i / (values.length - 1).clamp(1, 9999)) * size.width;
      final double yNorm = (values[i] - minV) / (maxV - minV);
      final double y = size.height - yNorm * size.height;
      if (i == 0) {
        line.moveTo(x, y);
        fill.moveTo(x, size.height);
        fill.lineTo(x, y);
      } else {
        line.lineTo(x, y);
        fill.lineTo(x, y);
      }
    }
    fill.lineTo(size.width, size.height);
    fill.close();

    final Paint fillPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(0, size.height),
        <Color>[
          _Palette.amber.withValues(alpha: 0.45),
          _Palette.amber.withValues(alpha: 0.0),
        ],
      );
    canvas.drawPath(fill, fillPaint);

    final Paint linePaint = Paint()
      ..color = _Palette.amber
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(line, linePaint);

    for (int i = 0; i < values.length; i++) {
      final double x = (i / (values.length - 1).clamp(1, 9999)) * size.width;
      final double yNorm = (values[i] - minV) / (maxV - minV);
      final double y = size.height - yNorm * size.height;
      canvas.drawCircle(Offset(x, y), 2.6, Paint()..color = _Palette.signal);
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter old) => old.values != values;
}

// =============================================================================
//  _ComparisonTable
// =============================================================================

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable({required this.rows});
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    final List<Widget> built = <Widget>[];
    for (int r = 0; r < rows.length; r++) {
      final bool isHeader = r == 0;
      final List<Widget> cells = <Widget>[];
      for (int c = 0; c < rows[r].length; c++) {
        cells.add(Expanded(
          flex: c == 0 ? 2 : 3,
          child: Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: _Palette.line.withValues(alpha: 0.7)),
              ),
            ),
            child: Text(
              rows[r][c],
              style: isHeader
                  ? _Type.label.copyWith(
                      color: c == 0 ? _Palette.faint : _Palette.plasma,
                      fontSize: 11,
                    )
                  : (c == 0
                      ? _Type.dim.copyWith(color: _Palette.faint, fontWeight: FontWeight.w600)
                      : _Type.body.copyWith(fontFamily: 'monospace', fontSize: 12.5)),
            ),
          ),
        ));
      }
      built.add(Container(
        color: isHeader ? _Palette.indigo.withValues(alpha: 0.5) : Colors.transparent,
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #27, P1):
        // Stretch-Row inside an unbounded vertical viewport — wrap in
        // IntrinsicHeight so the bottom-bordered cells share a finite
        // common height instead of receiving infinite constraints.
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: cells,
          ),
        ),
      ));
    }
    return Container(
      decoration: BoxDecoration(
        color: _Palette.midnight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: built),
    );
  }
}

// =============================================================================
//  _Span / _Recipe / _RecipeCard
// =============================================================================

class _Span {
  const _Span(this.text, this.color);
  final String text;
  final Color color;
}

class _Recipe {
  _Recipe({
    required this.title,
    required this.purpose,
    required this.snippet,
  });
  final String title;
  final String purpose;
  final List<_Span> snippet;
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({required this.recipe});
  final _Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> spans = <TextSpan>[];
    for (int i = 0; i < recipe.snippet.length; i++) {
      final _Span s = recipe.snippet[i];
      spans.add(TextSpan(
        text: s.text,
        style: TextStyle(color: s.color, fontFamily: 'monospace', fontSize: 12.5, height: 1.55),
      ));
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: _Palette.midnight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.violet.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _Palette.violet.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('RECIPE', style: _Type.tag),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(recipe.title, style: _Type.h2)),
            ],
          ),
          const SizedBox(height: 4),
          Text(recipe.purpose, style: _Type.dim),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            decoration: BoxDecoration(
              color: _Palette.abyss,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _Palette.line),
            ),
            child: Text.rich(TextSpan(children: spans)),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
//  _EdgeCase / _EdgeCaseCard
// =============================================================================

class _EdgeCase {
  _EdgeCase({
    required this.title,
    required this.body,
    required this.guard,
    required this.accent,
  });
  final String title;
  final String body;
  final String guard;
  final Color accent;
}

class _EdgeCaseCard extends StatelessWidget {
  const _EdgeCaseCard({required this.data});
  final _EdgeCase data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: _Palette.midnight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: data.accent.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.warning_amber_rounded, size: 16, color: data.accent),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  data.title,
                  style: _Type.h2.copyWith(color: data.accent, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(data.body, style: _Type.body),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: _Palette.abyss,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: data.accent.withValues(alpha: 0.3)),
            ),
            child: Text(
              data.guard,
              style: _Type.mono.copyWith(color: data.accent, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
//  _Variant / _VariantCard — runtime PointerScrollEvent construction
// =============================================================================

class _Variant {
  _Variant({
    required this.label,
    required this.position,
    required this.scrollDelta,
    required this.kind,
    required this.accent,
  });
  final String label;
  final Offset position;
  final Offset scrollDelta;
  final PointerDeviceKind kind;
  final Color accent;
}

class _VariantCard extends StatelessWidget {
  const _VariantCard({required this.variant});
  final _Variant variant;

  @override
  Widget build(BuildContext context) {
    Widget body;
    String summary;
    bool ok;
    try {
      // Runtime construction (not const) so any failing assert is catchable.
      final PointerScrollEvent evt = PointerScrollEvent(
        timeStamp: const Duration(milliseconds: 12_345),
        kind: variant.kind,
        device: 0,
        position: variant.position,
        scrollDelta: variant.scrollDelta,
        embedderId: 0,
      );
      ok = true;
      summary =
          'kind=${evt.kind.name}\n'
          'position=(${evt.position.dx.toStringAsFixed(1)}, ${evt.position.dy.toStringAsFixed(1)})\n'
          'scrollDelta=(${evt.scrollDelta.dx.toStringAsFixed(1)}, ${evt.scrollDelta.dy.toStringAsFixed(1)})\n'
          'delta=${evt.delta}\n'
          'embedderId=${evt.embedderId}\n'
          'pointer=${evt.pointer}';
      body = _variantPreview(variant, ok: true);
    } catch (e) {
      ok = false;
      summary = 'construction failed:\n$e';
      body = _variantPreview(variant, ok: false);
    }

    return Container(
      width: 270,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: _Palette.midnight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: variant.accent.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: ok ? variant.accent : _Palette.signal,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  variant.label,
                  style: _Type.h2.copyWith(fontSize: 13, color: variant.accent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          body,
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _Palette.abyss,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _Palette.line),
            ),
            child: Text(summary, style: _Type.monoDim.copyWith(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  Widget _variantPreview(_Variant v, {required bool ok}) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: _Palette.abyss,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _Palette.line),
      ),
      child: ok
          ? CustomPaint(painter: _ArrowPainter(delta: v.scrollDelta))
          : const Center(
              child: Text(
                'caught — see summary',
                style: TextStyle(color: _Palette.signal, fontSize: 11),
              ),
            ),
    );
  }
}
