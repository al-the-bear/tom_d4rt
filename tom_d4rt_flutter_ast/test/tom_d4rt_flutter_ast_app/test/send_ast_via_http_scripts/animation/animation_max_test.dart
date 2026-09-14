// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =============================================================================
//   Visual Deep Demo: AnimationMax<T>, AnimationMin<T> & the operator family
// =============================================================================
//
// This file is a hand-written reference exhibit for the Flutter `Animation<T>`
// operator/utility family.  The headline subjects are the two compound
// animations `AnimationMax<T>` and `AnimationMin<T>` -- thin subclasses of
// `CompoundAnimation<T>` that combine two source animations by taking the
// per-tick maximum / minimum value (using `Comparable.compareTo`).  Around them
// orbits an entire constellation of related types:
//
//   * Animation<T>         -- the abstract listenable value-over-time.
//   * Animatable<T>        -- a transform U -> T applied over an animation.
//   * CurvedAnimation      -- applies a Curve to a parent's t.
//   * ReverseAnimation     -- flips the parent value (and reverses status).
//   * TrainHoppingAnimation-- hops between two trains the moment they cross.
//   * CompoundAnimation<T> -- abstract base composing `first` and `next`.
//   * AnimationMax<T>      -- compound, value = max(first, next).
//   * AnimationMin<T>      -- compound, value = min(first, next).
//   * ProxyAnimation       -- forwards to a swappable parent.
//   * Animation.drive()    -- chain an Animatable on top of an Animation.
//
// All visualisations are static -- we never read `.value` from a running
// animation, instead we sample `Curve.transform(t)` for many `t` and draw the
// curves directly so the test fixture has zero runtime dependence on a ticker.
// =============================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
//   Palette
// ---------------------------------------------------------------------------

const Color _kBg = Color(0xFFF5F1E8);
const Color _kInk = Color(0xFF2A2520);
const Color _kSubInk = Color(0xFF6B5F50);
const Color _kBlue = Color(0xFF2E64A8);
const Color _kPink = Color(0xFFD64C7A);
const Color _kGold = Color(0xFFE3A636);
const Color _kGreen = Color(0xFF3F8B59);
const Color _kPurple = Color(0xFF6B4FA0);
const Color _kSlate = Color(0xFF445566);
const Color _kCard = Color(0xFFFFFCF5);
const Color _kCardBorder = Color(0xFFD9CFB8);
const Color _kGrid = Color(0xFFE8DFC9);
const Color _kAccent = Color(0xFFB07232);

// ---------------------------------------------------------------------------
//   Build entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'AnimationMax visual deep demo',
    home: Scaffold(
      backgroundColor: _kBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _PrivateHeroCard(),
            const SizedBox(height: 36.0),
            _PrivateSectionHeader(
              index: 1,
              title: 'Anatomy of AnimationMax<T>',
              tag: 'compound',
            ),
            const SizedBox(height: 18.0),
            _PrivateAnatomyCard(),
            const SizedBox(height: 36.0),
            _PrivateSectionHeader(
              index: 2,
              title: 'Dual-curve plot: source A vs. source B',
              tag: 'visual',
            ),
            const SizedBox(height: 18.0),
            _PrivateDualCurveCard(),
            const SizedBox(height: 36.0),
            _PrivateSectionHeader(
              index: 3,
              title: 'Max / Min envelopes — the compound result',
              tag: 'visual',
            ),
            const SizedBox(height: 18.0),
            _PrivateEnvelopeCard(),
            const SizedBox(height: 36.0),
            _PrivateSectionHeader(
              index: 4,
              title: 'AnimationMax · AnimationMin · CompoundAnimation table',
              tag: 'reference',
            ),
            const SizedBox(height: 18.0),
            _PrivateComparisonTable(),
            const SizedBox(height: 36.0),
            _PrivateSectionHeader(
              index: 5,
              title: 'CompoundAnimation<T> family overview',
              tag: 'family',
            ),
            const SizedBox(height: 18.0),
            _PrivateFamilyTreeCard(),
            const SizedBox(height: 36.0),
            _PrivateSectionHeader(
              index: 6,
              title: 'Animation<T>.drive(Animatable<U>) — chain operators',
              tag: 'chain',
            ),
            const SizedBox(height: 18.0),
            _PrivateDriveChainCard(),
            const SizedBox(height: 36.0),
            _PrivateSectionHeader(
              index: 7,
              title: 'CurvedAnimation gallery — six classic curves',
              tag: 'gallery',
            ),
            const SizedBox(height: 18.0),
            _PrivateCurveGalleryCard(),
            const SizedBox(height: 36.0),
            _PrivateSectionHeader(
              index: 8,
              title: 'ReverseAnimation — flip-it visualisation',
              tag: 'reverse',
            ),
            const SizedBox(height: 18.0),
            _PrivateReverseCard(),
            const SizedBox(height: 36.0),
            _PrivateSectionHeader(
              index: 9,
              title: 'TrainHoppingAnimation — switch the moment they cross',
              tag: 'hop',
            ),
            const SizedBox(height: 18.0),
            _PrivateTrainHoppingCard(),
            const SizedBox(height: 36.0),
            _PrivateSectionHeader(
              index: 10,
              title: 'ProxyAnimation — late-bound parent',
              tag: 'proxy',
            ),
            const SizedBox(height: 18.0),
            _PrivateProxyCard(),
            const SizedBox(height: 36.0),
            _PrivateSectionHeader(
              index: 11,
              title: 'Recipe — wiring AnimationMax(c1, c2)',
              tag: 'code',
            ),
            const SizedBox(height: 18.0),
            _PrivateRecipeCard(),
            const SizedBox(height: 36.0),
            _PrivateSectionHeader(
              index: 12,
              title: 'Pitfalls & gotchas',
              tag: 'warn',
            ),
            const SizedBox(height: 18.0),
            _PrivatePitfallsCard(),
            const SizedBox(height: 40.0),
            _PrivateFooter(),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
//   Section header
// ---------------------------------------------------------------------------

class _PrivateSectionHeader extends StatelessWidget {
  const _PrivateSectionHeader({
    required this.index,
    required this.title,
    required this.tag,
  });

  final int index;
  final String title;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 44.0,
          height: 44.0,
          decoration: BoxDecoration(
            color: _kInk,
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.center,
          child: Text(
            '$index',
            style: const TextStyle(
              color: _kBg,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: _kInk,
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: _kAccent.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: _kAccent.withValues(alpha: 0.55)),
          ),
          child: Text(
            tag.toUpperCase(),
            style: const TextStyle(
              color: _kAccent,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
//   Hero card
// ---------------------------------------------------------------------------

class _PrivateHeroCard extends StatelessWidget {
  const _PrivateHeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: _kCardBorder),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.06),
            blurRadius: 22.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: _kGold.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Text(
                    'ANIMATION OPERATORS · DEEP DEMO',
                    style: TextStyle(
                      color: _kAccent,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 18.0),
                const Text(
                  'AnimationMax<T> & AnimationMin<T>',
                  style: TextStyle(
                    color: _kInk,
                    fontSize: 36.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.7,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 12.0),
                const Text(
                  'Compose two Animation<T>s and read the per-tick max or min. '
                  'A tiny pair of helpers, but a lovely lens for the whole '
                  'Animation operator family — drive, curve, reverse, hop, '
                  'proxy, compound.',
                  style: TextStyle(
                    color: _kSubInk,
                    fontSize: 15.0,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 22.0),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: <Widget>[
                    _PrivateChip(
                      label: 'CompoundAnimation<T>',
                      color: _kBlue,
                    ),
                    _PrivateChip(
                      label: 'CurvedAnimation',
                      color: _kPink,
                    ),
                    _PrivateChip(
                      label: 'ReverseAnimation',
                      color: _kGreen,
                    ),
                    _PrivateChip(
                      label: 'TrainHoppingAnimation',
                      color: _kPurple,
                    ),
                    _PrivateChip(
                      label: 'ProxyAnimation',
                      color: _kSlate,
                    ),
                    _PrivateChip(
                      label: 'Animatable<T>.animate()',
                      color: _kAccent,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 30.0),
          Expanded(
            flex: 4,
            child: AspectRatio(
              aspectRatio: 16.0 / 10.0,
              child: Container(
                decoration: BoxDecoration(
                  color: _kBg,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: _kCardBorder),
                ),
                padding: const EdgeInsets.all(14.0),
                child: CustomPaint(
                  painter: _PrivateHeroPlotPainter(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateChip extends StatelessWidget {
  const _PrivateChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _PrivateHeroPlotPainter extends CustomPainter {
  const _PrivateHeroPlotPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint grid = Paint()
      ..color = _kGrid
      ..strokeWidth = 1.0;
    for (int i = 1; i < 5; i++) {
      final double y = size.height * (i / 5);
      canvas.drawLine(Offset(0.0, y), Offset(size.width, y), grid);
    }
    for (int i = 1; i < 8; i++) {
      final double x = size.width * (i / 8);
      canvas.drawLine(Offset(x, 0.0), Offset(x, size.height), grid);
    }

    final List<double> ts = _PrivateSamples.linspace(0.0, 1.0, 80);
    final List<double> a = ts
        .map((double t) => _PrivateCurves.easeInOutSine(t))
        .toList();
    final List<double> b = ts
        .map((double t) => _PrivateCurves.bumpCurve(t))
        .toList();
    final List<double> mx = <double>[
      for (int i = 0; i < ts.length; i++) a[i] > b[i] ? a[i] : b[i],
    ];

    _PrivatePlotting.drawPath(canvas, size, ts, a, _kBlue, 2.4);
    _PrivatePlotting.drawPath(canvas, size, ts, b, _kPink, 2.4);
    _PrivatePlotting.drawPath(canvas, size, ts, mx, _kGold, 3.8);

    final TextPainter labelA = _PrivatePlotting.textPainter(
      'A: easeInOutSine',
      _kBlue,
      12.0,
    );
    labelA.paint(canvas, const Offset(10.0, 6.0));
    final TextPainter labelB = _PrivatePlotting.textPainter(
      'B: bumpCurve',
      _kPink,
      12.0,
    );
    labelB.paint(canvas, Offset(10.0, 6.0 + labelA.height + 2.0));
    final TextPainter labelMax = _PrivatePlotting.textPainter(
      'AnimationMax(A, B)',
      _kAccent,
      12.0,
    );
    labelMax.paint(
      canvas,
      Offset(10.0, 6.0 + labelA.height * 2.0 + 4.0),
    );
  }

  @override
  bool shouldRepaint(covariant _PrivateHeroPlotPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
//   Anatomy card
// ---------------------------------------------------------------------------

class _PrivateAnatomyCard extends StatelessWidget {
  const _PrivateAnatomyCard();

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'class AnimationMax<T extends Comparable<dynamic>> '
            'extends CompoundAnimation<T>',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14.0,
              color: _kInk,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14.0),
          const Text(
            'AnimationMax inherits the listening / status / lifecycle '
            'machinery of CompoundAnimation<T> and only overrides one thing: '
            'the value getter. It returns whichever of `first.value` or '
            '`next.value` compares larger via Comparable.compareTo.',
            style: TextStyle(
              color: _kSubInk,
              fontSize: 14.0,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 22.0),
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: _kBg,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: _kCardBorder),
            ),
            child: const Text(
              "@override\n"
              "T get value =>\n"
              "    first.value.compareTo(next.value) > 0\n"
              "        ? first.value\n"
              "        : next.value;",
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.5,
                color: _kInk,
                height: 1.55,
              ),
            ),
          ),
          const SizedBox(height: 22.0),
          Row(
            children: <Widget>[
              Expanded(
                child: _PrivateAnatomyTile(
                  title: 'first',
                  body: 'The first source `Animation<T>`. Listeners are '
                      'forwarded automatically by CompoundAnimation.',
                  color: _kBlue,
                ),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: _PrivateAnatomyTile(
                  title: 'next',
                  body: 'The second source `Animation<T>`. Status is taken '
                      'from whichever child most recently changed status.',
                  color: _kPink,
                ),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: _PrivateAnatomyTile(
                  title: 'value',
                  body: 'Per-tick maximum of `first.value` and `next.value` '
                      'using Comparable.compareTo.',
                  color: _kGold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivateAnatomyTile extends StatelessWidget {
  const _PrivateAnatomyTile({
    required this.title,
    required this.body,
    required this.color,
  });

  final String title;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            body,
            style: const TextStyle(
              color: _kSubInk,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//   Dual-curve card
// ---------------------------------------------------------------------------

class _PrivateDualCurveCard extends StatelessWidget {
  const _PrivateDualCurveCard();

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Two source animations, sampled at 200 points across t ∈ [0, 1].',
            style: TextStyle(color: _kSubInk, fontSize: 14.0, height: 1.55),
          ),
          const SizedBox(height: 16.0),
          AspectRatio(
            aspectRatio: 16.0 / 6.0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: _kBg,
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(color: _kCardBorder),
              ),
              child: CustomPaint(
                painter: _PrivateDualCurvePainter(),
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          Row(
            children: <Widget>[
              _PrivateLegend(color: _kBlue, label: 'A — easeOutCubic'),
              const SizedBox(width: 18.0),
              _PrivateLegend(color: _kPink, label: 'B — slowFastSlow'),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivateDualCurvePainter extends CustomPainter {
  const _PrivateDualCurvePainter();

  @override
  void paint(Canvas canvas, Size size) {
    _PrivatePlotting.drawAxes(canvas, size);
    final List<double> ts = _PrivateSamples.linspace(0.0, 1.0, 200);
    final List<double> a =
        ts.map((double t) => _PrivateCurves.easeOutCubic(t)).toList();
    final List<double> b =
        ts.map((double t) => _PrivateCurves.slowFastSlow(t)).toList();

    _PrivatePlotting.drawPath(canvas, size, ts, a, _kBlue, 2.6);
    _PrivatePlotting.drawPath(canvas, size, ts, b, _kPink, 2.6);
  }

  @override
  bool shouldRepaint(covariant _PrivateDualCurvePainter oldDelegate) => false;
}

class _PrivateLegend extends StatelessWidget {
  const _PrivateLegend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 14.0,
          height: 14.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          label,
          style: const TextStyle(
            color: _kInk,
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
//   Envelope card
// ---------------------------------------------------------------------------

class _PrivateEnvelopeCard extends StatelessWidget {
  const _PrivateEnvelopeCard();

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'AnimationMax (gold) and AnimationMin (green) envelopes derived '
            'from the same A and B from the previous panel. The compound '
            'value at every t is `max(A.value, B.value)` or '
            '`min(A.value, B.value)` respectively.',
            style: TextStyle(color: _kSubInk, fontSize: 14.0, height: 1.55),
          ),
          const SizedBox(height: 16.0),
          AspectRatio(
            aspectRatio: 16.0 / 6.5,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: _kBg,
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(color: _kCardBorder),
              ),
              child: CustomPaint(
                painter: _PrivateEnvelopePainter(),
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          Row(
            children: <Widget>[
              _PrivateLegend(color: _kBlue, label: 'A'),
              const SizedBox(width: 14.0),
              _PrivateLegend(color: _kPink, label: 'B'),
              const SizedBox(width: 14.0),
              _PrivateLegend(color: _kGold, label: 'AnimationMax'),
              const SizedBox(width: 14.0),
              _PrivateLegend(color: _kGreen, label: 'AnimationMin'),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivateEnvelopePainter extends CustomPainter {
  const _PrivateEnvelopePainter();

  @override
  void paint(Canvas canvas, Size size) {
    _PrivatePlotting.drawAxes(canvas, size);
    final List<double> ts = _PrivateSamples.linspace(0.0, 1.0, 240);
    final List<double> a =
        ts.map((double t) => _PrivateCurves.easeOutCubic(t)).toList();
    final List<double> b =
        ts.map((double t) => _PrivateCurves.slowFastSlow(t)).toList();
    final List<double> mx = <double>[
      for (int i = 0; i < ts.length; i++) a[i] > b[i] ? a[i] : b[i],
    ];
    final List<double> mn = <double>[
      for (int i = 0; i < ts.length; i++) a[i] < b[i] ? a[i] : b[i],
    ];

    _PrivatePlotting.drawPath(canvas, size, ts, a, _kBlue, 1.6);
    _PrivatePlotting.drawPath(canvas, size, ts, b, _kPink, 1.6);
    _PrivatePlotting.drawPath(canvas, size, ts, mx, _kGold, 3.4);
    _PrivatePlotting.drawPath(canvas, size, ts, mn, _kGreen, 3.4);
  }

  @override
  bool shouldRepaint(covariant _PrivateEnvelopePainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
//   Comparison table
// ---------------------------------------------------------------------------

class _PrivateComparisonTable extends StatelessWidget {
  const _PrivateComparisonTable();

  @override
  Widget build(BuildContext context) {
    final List<List<String>> rows = <List<String>>[
      <String>[
        'Class',
        'Extends',
        'value semantics',
        'Listener model',
      ],
      <String>[
        'CompoundAnimation<T>',
        'Animation<T>',
        'abstract — subclass overrides',
        'forwards from `first` & `next`',
      ],
      <String>[
        'AnimationMax<T>',
        'CompoundAnimation<T>',
        'compareTo > 0 ? first : next',
        'inherits compound forwarding',
      ],
      <String>[
        'AnimationMin<T>',
        'CompoundAnimation<T>',
        'compareTo < 0 ? first : next',
        'inherits compound forwarding',
      ],
      <String>[
        'AnimationMean',
        'CompoundAnimation<double>',
        '(first.value + next.value) / 2',
        'inherits compound forwarding',
      ],
    ];

    return _PrivateCard(
      child: Column(
        children: <Widget>[
          for (int i = 0; i < rows.length; i++)
            _PrivateTableRow(
              cells: rows[i],
              isHeader: i == 0,
              isLast: i == rows.length - 1,
            ),
        ],
      ),
    );
  }
}

class _PrivateTableRow extends StatelessWidget {
  const _PrivateTableRow({
    required this.cells,
    required this.isHeader,
    required this.isLast,
  });

  final List<String> cells;
  final bool isHeader;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isHeader ? _kInk : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isLast ? Colors.transparent : _kCardBorder,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (int i = 0; i < cells.length; i++)
            Expanded(
              flex: i == 0 ? 3 : (i == 2 ? 4 : 3),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Text(
                  cells[i],
                  style: TextStyle(
                    fontFamily: i <= 1 ? 'monospace' : null,
                    color: isHeader ? _kBg : _kInk,
                    fontSize: isHeader ? 12.5 : 13.5,
                    fontWeight:
                        isHeader ? FontWeight.w800 : FontWeight.w500,
                    letterSpacing: isHeader ? 0.6 : 0.0,
                    height: 1.45,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//   Family tree card
// ---------------------------------------------------------------------------

class _PrivateFamilyTreeCard extends StatelessWidget {
  const _PrivateFamilyTreeCard();

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'CompoundAnimation<T> is the abstract glue that binds two source '
            'animations into one — it owns the listener/status forwarding so '
            'each subclass only has to implement `value`.',
            style: TextStyle(color: _kSubInk, fontSize: 14.0, height: 1.55),
          ),
          const SizedBox(height: 22.0),
          _PrivateTreeNode(
            label: 'Animation<T>',
            sub: 'abstract base',
            color: _kSlate,
          ),
          _PrivateTreeArrow(),
          _PrivateTreeNode(
            label: 'CompoundAnimation<T>',
            sub: 'composes first + next, forwards listeners & status',
            color: _kBlue,
          ),
          _PrivateTreeArrow(),
          Row(
            children: <Widget>[
              Expanded(
                child: _PrivateTreeNode(
                  label: 'AnimationMax<T>',
                  sub: 'value = max(first, next)',
                  color: _kGold,
                ),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: _PrivateTreeNode(
                  label: 'AnimationMin<T>',
                  sub: 'value = min(first, next)',
                  color: _kGreen,
                ),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: _PrivateTreeNode(
                  label: 'AnimationMean',
                  sub: 'value = (first + next) / 2',
                  color: _kPurple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivateTreeNode extends StatelessWidget {
  const _PrivateTreeNode({
    required this.label,
    required this.sub,
    required this.color,
  });

  final String label;
  final String sub;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              color: color,
              fontSize: 14.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            sub,
            style: const TextStyle(
              color: _kSubInk,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateTreeArrow extends StatelessWidget {
  const _PrivateTreeArrow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Container(
          width: 2.0,
          height: 22.0,
          color: _kCardBorder,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//   Drive chain card
// ---------------------------------------------------------------------------

class _PrivateDriveChainCard extends StatelessWidget {
  const _PrivateDriveChainCard();

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Animation<T>.drive(Animatable<U>) returns a new Animation<U> '
            'where every value is run through the Animatable transform. '
            'Tweens are the most common Animatable.',
            style: TextStyle(color: _kSubInk, fontSize: 14.0, height: 1.55),
          ),
          const SizedBox(height: 22.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _PrivateChainBox(
                title: 'AnimationController',
                sub: 'Animation<double> 0 → 1',
                color: _kBlue,
              ),
              _PrivateChainArrow(label: '.drive(curve)'),
              _PrivateChainBox(
                title: 'CurvedAnimation',
                sub: 'Curves.easeInOut',
                color: _kPink,
              ),
              _PrivateChainArrow(label: '.drive(tween)'),
              _PrivateChainBox(
                title: 'Animation<Offset>',
                sub: 'Tween<Offset>(begin..end)',
                color: _kGold,
              ),
            ],
          ),
          const SizedBox(height: 22.0),
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: _kBg,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: _kCardBorder),
            ),
            child: const Text(
              "final Animation<double> ctrl    = controller; // 0..1\n"
              "final Animation<double> curved  = ctrl.drive(\n"
              "  CurveTween(curve: Curves.easeInOutCubic),\n"
              ");\n"
              "final Animation<Offset>  slide  = curved.drive(\n"
              "  Tween<Offset>(begin: Offset.zero, end: Offset(120, 0)),\n"
              ");",
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                color: _kInk,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateChainBox extends StatelessWidget {
  const _PrivateChainBox({
    required this.title,
    required this.sub,
    required this.color,
  });

  final String title;
  final String sub;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 14.0,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.5)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'monospace',
                color: color,
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              sub,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _kSubInk,
                fontSize: 11.5,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivateChainArrow extends StatelessWidget {
  const _PrivateChainArrow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _kAccent,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4.0),
          Container(
            width: 24.0,
            height: 2.0,
            color: _kAccent,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//   Curve gallery card
// ---------------------------------------------------------------------------

class _PrivateCurveGalleryCard extends StatelessWidget {
  const _PrivateCurveGalleryCard();

  @override
  Widget build(BuildContext context) {
    final List<_PrivateCurveSpec> specs = <_PrivateCurveSpec>[
      _PrivateCurveSpec('linear', _kSlate, _PrivateCurves.linear),
      _PrivateCurveSpec('easeIn', _kBlue, _PrivateCurves.easeIn),
      _PrivateCurveSpec('easeOut', _kPink, _PrivateCurves.easeOut),
      _PrivateCurveSpec(
        'easeInOutCubic',
        _kGold,
        _PrivateCurves.easeInOutCubic,
      ),
      _PrivateCurveSpec('bounceOut', _kGreen, _PrivateCurves.bounceOut),
      _PrivateCurveSpec('elasticOut', _kPurple, _PrivateCurves.elasticOut),
    ];

    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'CurvedAnimation feeds its parent t through Curve.transform(t). '
            'These six panels show classic curves sampled across t ∈ [0, 1].',
            style: TextStyle(color: _kSubInk, fontSize: 14.0, height: 1.55),
          ),
          const SizedBox(height: 18.0),
          Row(
            children: <Widget>[
              for (int i = 0; i < 3; i++)
                Expanded(child: _PrivateCurveTile(spec: specs[i])),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              for (int i = 3; i < 6; i++)
                Expanded(child: _PrivateCurveTile(spec: specs[i])),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivateCurveSpec {
  const _PrivateCurveSpec(this.label, this.color, this.fn);

  final String label;
  final Color color;
  final double Function(double) fn;
}

class _PrivateCurveTile extends StatelessWidget {
  const _PrivateCurveTile({required this.spec});

  final _PrivateCurveSpec spec;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: _kBg,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: _kCardBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              spec.label,
              style: TextStyle(
                fontFamily: 'monospace',
                color: spec.color,
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8.0),
            AspectRatio(
              aspectRatio: 1.4,
              child: CustomPaint(
                painter: _PrivateCurveTilePainter(spec: spec),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivateCurveTilePainter extends CustomPainter {
  const _PrivateCurveTilePainter({required this.spec});

  final _PrivateCurveSpec spec;

  @override
  void paint(Canvas canvas, Size size) {
    _PrivatePlotting.drawAxes(canvas, size, alpha: 0.7);
    final List<double> ts = _PrivateSamples.linspace(0.0, 1.0, 100);
    final List<double> ys = ts.map(spec.fn).toList();
    _PrivatePlotting.drawPath(canvas, size, ts, ys, spec.color, 2.4);
  }

  @override
  bool shouldRepaint(covariant _PrivateCurveTilePainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
//   ReverseAnimation card
// ---------------------------------------------------------------------------

class _PrivateReverseCard extends StatelessWidget {
  const _PrivateReverseCard();

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'ReverseAnimation wraps an Animation<double> and exposes '
            '`1.0 - parent.value`. AnimationStatus.forward becomes reverse '
            'and vice versa. Useful when paired with a fade-out.',
            style: TextStyle(color: _kSubInk, fontSize: 14.0, height: 1.55),
          ),
          const SizedBox(height: 18.0),
          AspectRatio(
            aspectRatio: 16.0 / 5.5,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: _kBg,
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(color: _kCardBorder),
              ),
              child: CustomPaint(
                painter: _PrivateReversePainter(),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: <Widget>[
              _PrivateLegend(color: _kBlue, label: 'parent — easeInOutCubic'),
              const SizedBox(width: 18.0),
              _PrivateLegend(color: _kPink, label: 'ReverseAnimation(parent)'),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivateReversePainter extends CustomPainter {
  const _PrivateReversePainter();

  @override
  void paint(Canvas canvas, Size size) {
    _PrivatePlotting.drawAxes(canvas, size);
    final List<double> ts = _PrivateSamples.linspace(0.0, 1.0, 200);
    final List<double> a =
        ts.map((double t) => _PrivateCurves.easeInOutCubic(t)).toList();
    final List<double> r = a.map((double y) => 1.0 - y).toList();
    _PrivatePlotting.drawPath(canvas, size, ts, a, _kBlue, 2.4);
    _PrivatePlotting.drawPath(canvas, size, ts, r, _kPink, 2.4);
  }

  @override
  bool shouldRepaint(covariant _PrivateReversePainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
//   TrainHopping card
// ---------------------------------------------------------------------------

class _PrivateTrainHoppingCard extends StatelessWidget {
  const _PrivateTrainHoppingCard();

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'TrainHoppingAnimation listens to two animations and "hops" from '
            'the current to the next as soon as their values cross. The hop '
            'point is marked with a gold ring.',
            style: TextStyle(color: _kSubInk, fontSize: 14.0, height: 1.55),
          ),
          const SizedBox(height: 18.0),
          AspectRatio(
            aspectRatio: 16.0 / 6.0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: _kBg,
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(color: _kCardBorder),
              ),
              child: CustomPaint(
                painter: _PrivateTrainHoppingPainter(),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: <Widget>[
              _PrivateLegend(color: _kBlue, label: 'currentTrain'),
              const SizedBox(width: 14.0),
              _PrivateLegend(color: _kPink, label: 'nextTrain'),
              const SizedBox(width: 14.0),
              _PrivateLegend(color: _kGold, label: 'hop point'),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivateTrainHoppingPainter extends CustomPainter {
  const _PrivateTrainHoppingPainter();

  @override
  void paint(Canvas canvas, Size size) {
    _PrivatePlotting.drawAxes(canvas, size);
    final List<double> ts = _PrivateSamples.linspace(0.0, 1.0, 200);
    final List<double> trainA =
        ts.map((double t) => _PrivateCurves.linear(t)).toList();
    final List<double> trainB =
        ts.map((double t) => 1.0 - _PrivateCurves.easeInQuad(t)).toList();

    _PrivatePlotting.drawPath(canvas, size, ts, trainA, _kBlue, 2.4);
    _PrivatePlotting.drawPath(canvas, size, ts, trainB, _kPink, 2.4);

    int crossIdx = 0;
    for (int i = 1; i < ts.length; i++) {
      final double prevDiff = trainA[i - 1] - trainB[i - 1];
      final double diff = trainA[i] - trainB[i];
      if (prevDiff * diff <= 0.0) {
        crossIdx = i;
        break;
      }
    }
    final double cx = ts[crossIdx] * size.width;
    final double cy = size.height - trainA[crossIdx] * size.height;
    final Paint hop = Paint()
      ..color = _kGold
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawCircle(Offset(cx, cy), 9.0, hop);

    final TextPainter tp = _PrivatePlotting.textPainter(
      'hop!',
      _kAccent,
      12.0,
    );
    tp.paint(canvas, Offset(cx + 12.0, cy - 18.0));
  }

  @override
  bool shouldRepaint(covariant _PrivateTrainHoppingPainter oldDelegate) =>
      false;
}

// ---------------------------------------------------------------------------
//   ProxyAnimation card
// ---------------------------------------------------------------------------

class _PrivateProxyCard extends StatelessWidget {
  const _PrivateProxyCard();

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'ProxyAnimation forwards every read to a swappable parent. Use '
            'it when you do not yet know which animation you will be '
            'observing — assign `proxy.parent = controller` later. Listeners '
            'attached to the proxy survive the parent swap.',
            style: TextStyle(color: _kSubInk, fontSize: 14.0, height: 1.55),
          ),
          const SizedBox(height: 18.0),
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: _kBg,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: _kCardBorder),
            ),
            child: const Text(
              "final ProxyAnimation proxy = ProxyAnimation();\n"
              "// ...\n"
              "// later, once the controller is built:\n"
              "proxy.parent = realController; // listeners survive the swap.\n",
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                color: _kInk,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//   Recipe card
// ---------------------------------------------------------------------------

class _PrivateRecipeCard extends StatelessWidget {
  const _PrivateRecipeCard();

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'A real, production-style wiring of AnimationMax<double>(c1, c2) '
            'driven by two AnimationControllers and consumed by a '
            'FadeTransition.',
            style: TextStyle(color: _kSubInk, fontSize: 14.0, height: 1.55),
          ),
          const SizedBox(height: 18.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: _kInk,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: const Text(
              "// Two underlying controllers (managed by State.dispose).\n"
              "final AnimationController c1 = AnimationController(\n"
              "  vsync: this,\n"
              "  duration: const Duration(milliseconds: 800),\n"
              ");\n"
              "final AnimationController c2 = AnimationController(\n"
              "  vsync: this,\n"
              "  duration: const Duration(milliseconds: 1200),\n"
              ");\n\n"
              "// Curve them so the comparison is interesting.\n"
              "final Animation<double> a = CurvedAnimation(\n"
              "  parent: c1,\n"
              "  curve: Curves.easeInOutCubic,\n"
              ");\n"
              "final Animation<double> b = CurvedAnimation(\n"
              "  parent: c2,\n"
              "  curve: Curves.elasticOut,\n"
              ");\n\n"
              "// AnimationMax<T extends Comparable> — picks per-tick max.\n"
              "final AnimationMax<double> hottest =\n"
              "    AnimationMax<double>(a, b);\n\n"
              "// Drop into a FadeTransition like any other Animation<double>.\n"
              "FadeTransition(\n"
              "  opacity: hottest,\n"
              "  child: const Card(child: Text('Whichever is louder wins.')),\n"
              ");",
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: Color(0xFFE8E0CC),
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//   Pitfalls card
// ---------------------------------------------------------------------------

class _PrivatePitfallsCard extends StatelessWidget {
  const _PrivatePitfallsCard();

  @override
  Widget build(BuildContext context) {
    final List<_PrivatePitfall> pitfalls = <_PrivatePitfall>[
      _PrivatePitfall(
        title: 'Add listeners — they are not implicit.',
        body: 'CompoundAnimation forwards listeners to its children only '
            'after at least one listener is added to the compound itself. '
            'Without listeners it stays detached.',
      ),
      _PrivatePitfall(
        title: 'Always dispose the source controllers, not the compound.',
        body: 'AnimationMax / AnimationMin do not own their sources. Dispose '
            'the AnimationControllers; the compound has no `dispose` method.',
      ),
      _PrivatePitfall(
        title: 'You cannot set value directly on a CompoundAnimation.',
        body: 'The value is derived. To force a particular outcome, set the '
            'underlying controllers (e.g. c1.value = 0.7).',
      ),
      _PrivatePitfall(
        title: 'T must be Comparable.',
        body: 'AnimationMax<T> is constrained by T extends Comparable. '
            'For doubles and ints this is automatic; for custom types you '
            'must implement Comparable<T> yourself.',
      ),
      _PrivatePitfall(
        title: 'Status is whichever child changed status last.',
        body: 'CompoundAnimation reports the most recent status from either '
            'child. Plan around that — it is rarely what you want for both '
            'children animating in opposite directions.',
      ),
    ];
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final _PrivatePitfall p in pitfalls)
            Padding(
              padding: const EdgeInsets.only(bottom: 14.0),
              child: _PrivatePitfallTile(pitfall: p),
            ),
        ],
      ),
    );
  }
}

class _PrivatePitfall {
  const _PrivatePitfall({required this.title, required this.body});

  final String title;
  final String body;
}

class _PrivatePitfallTile extends StatelessWidget {
  const _PrivatePitfallTile({required this.pitfall});

  final _PrivatePitfall pitfall;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: _kPink.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kPink.withValues(alpha: 0.40)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28.0,
            height: 28.0,
            decoration: BoxDecoration(
              color: _kPink,
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: const Text(
              '!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pitfall.title,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  pitfall.body,
                  style: const TextStyle(
                    color: _kSubInk,
                    fontSize: 13.0,
                    height: 1.5,
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
//   Footer
// ---------------------------------------------------------------------------

class _PrivateFooter extends StatelessWidget {
  const _PrivateFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 18.0),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: _kGold,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12.0),
          const Expanded(
            child: Text(
              'Visual deep demo · AnimationMax / AnimationMin & friends · '
              'rendered statically — never reads .value from a live animation.',
              style: TextStyle(
                color: _kBg,
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.4,
              ),
            ),
          ),
          const Text(
            'tom_d4rt_flutter_ast · animation/animation_max_test.dart',
            style: TextStyle(
              fontFamily: 'monospace',
              color: _kBg,
              fontSize: 11.0,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//   Generic card chrome
// ---------------------------------------------------------------------------

class _PrivateCard extends StatelessWidget {
  const _PrivateCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: _kCardBorder),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.04),
            blurRadius: 12.0,
            offset: const Offset(0.0, 6.0),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ---------------------------------------------------------------------------
//   Curve maths (no analyzer, no runtime — pure dart numerics)
// ---------------------------------------------------------------------------

class _PrivateCurves {
  const _PrivateCurves._();

  static double linear(double t) => t;

  static double easeIn(double t) => t * t * t;

  static double easeOut(double t) {
    final double inv = 1.0 - t;
    return 1.0 - inv * inv * inv;
  }

  static double easeInQuad(double t) => t * t;

  static double easeOutCubic(double t) {
    final double inv = 1.0 - t;
    return 1.0 - inv * inv * inv;
  }

  static double easeInOutCubic(double t) {
    if (t < 0.5) {
      return 4.0 * t * t * t;
    } else {
      final double f = 2.0 * t - 2.0;
      return 0.5 * f * f * f + 1.0;
    }
  }

  static double easeInOutSine(double t) {
    return 0.5 - 0.5 * _PrivateMath.cos(_PrivateMath.pi * t);
  }

  static double bumpCurve(double t) {
    final double centred = t - 0.5;
    final double bump = 1.0 - 4.0 * centred * centred;
    return bump < 0.0 ? 0.0 : bump;
  }

  static double slowFastSlow(double t) {
    return t * t * (3.0 - 2.0 * t);
  }

  static double bounceOut(double t) {
    if (t < 1.0 / 2.75) {
      return 7.5625 * t * t;
    } else if (t < 2.0 / 2.75) {
      final double tx = t - 1.5 / 2.75;
      return 7.5625 * tx * tx + 0.75;
    } else if (t < 2.5 / 2.75) {
      final double tx = t - 2.25 / 2.75;
      return 7.5625 * tx * tx + 0.9375;
    } else {
      final double tx = t - 2.625 / 2.75;
      return 7.5625 * tx * tx + 0.984375;
    }
  }

  static double elasticOut(double t) {
    if (t == 0.0) return 0.0;
    if (t == 1.0) return 1.0;
    final double p = 0.3;
    final double s = p / 4.0;
    final double powerExp = _PrivateMath.pow(2.0, -10.0 * t);
    final double sineArg = (t - s) * (2.0 * _PrivateMath.pi) / p;
    return powerExp * _PrivateMath.sin(sineArg) + 1.0;
  }
}

// ---------------------------------------------------------------------------
//   Tiny math (no dart:math import to keep the bridge surface minimal)
// ---------------------------------------------------------------------------

class _PrivateMath {
  const _PrivateMath._();

  static const double pi = 3.141592653589793;

  static double sin(double x) {
    double t = x % (2.0 * pi);
    if (t > pi) t -= 2.0 * pi;
    if (t < -pi) t += 2.0 * pi;
    final double t2 = t * t;
    final double t3 = t2 * t;
    final double t5 = t3 * t2;
    final double t7 = t5 * t2;
    final double t9 = t7 * t2;
    return t -
        t3 / 6.0 +
        t5 / 120.0 -
        t7 / 5040.0 +
        t9 / 362880.0;
  }

  static double cos(double x) {
    return sin(x + pi / 2.0);
  }

  static double pow(double base, double exp) {
    if (exp == 0.0) return 1.0;
    if (base == 0.0) return 0.0;
    final double ln = _ln(base);
    return _exp(ln * exp);
  }

  static double _ln(double x) {
    if (x <= 0.0) return 0.0;
    double y = (x - 1.0) / (x + 1.0);
    final double y2 = y * y;
    double sum = y;
    double term = y;
    for (int n = 1; n < 12; n++) {
      term *= y2;
      sum += term / (2.0 * n + 1.0);
    }
    return 2.0 * sum;
  }

  static double _exp(double x) {
    double sum = 1.0;
    double term = 1.0;
    for (int n = 1; n < 30; n++) {
      term *= x / n;
      sum += term;
    }
    return sum;
  }
}

// ---------------------------------------------------------------------------
//   Sample utilities
// ---------------------------------------------------------------------------

class _PrivateSamples {
  const _PrivateSamples._();

  static List<double> linspace(double a, double b, int n) {
    if (n <= 1) return <double>[a];
    final List<double> out = <double>[];
    for (int i = 0; i < n; i++) {
      final double t = i / (n - 1);
      out.add(a + (b - a) * t);
    }
    return out;
  }
}

// ---------------------------------------------------------------------------
//   Plotting utilities
// ---------------------------------------------------------------------------

class _PrivatePlotting {
  const _PrivatePlotting._();

  static void drawAxes(Canvas canvas, Size size, {double alpha = 1.0}) {
    final Paint grid = Paint()
      ..color = _kGrid.withValues(alpha: alpha)
      ..strokeWidth = 1.0;
    for (int i = 1; i < 5; i++) {
      final double y = size.height * (i / 5);
      canvas.drawLine(Offset(0.0, y), Offset(size.width, y), grid);
    }
    for (int i = 1; i < 8; i++) {
      final double x = size.width * (i / 8);
      canvas.drawLine(Offset(x, 0.0), Offset(x, size.height), grid);
    }
    final Paint axis = Paint()
      ..color = _kSubInk.withValues(alpha: 0.5 * alpha)
      ..strokeWidth = 1.2;
    canvas.drawLine(
      Offset(0.0, size.height),
      Offset(size.width, size.height),
      axis,
    );
    canvas.drawLine(const Offset(0.0, 0.0), Offset(0.0, size.height), axis);
  }

  static void drawPath(
    Canvas canvas,
    Size size,
    List<double> ts,
    List<double> ys,
    Color color,
    double width,
  ) {
    final Path path = Path();
    bool moved = false;
    for (int i = 0; i < ts.length; i++) {
      final double x = ts[i] * size.width;
      final double y = size.height - ys[i].clamp(0.0, 1.0) * size.height;
      if (!moved) {
        path.moveTo(x, y);
        moved = true;
      } else {
        path.lineTo(x, y);
      }
    }
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, paint);
  }

  static TextPainter textPainter(String text, Color color, double size) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    return tp;
  }
}
