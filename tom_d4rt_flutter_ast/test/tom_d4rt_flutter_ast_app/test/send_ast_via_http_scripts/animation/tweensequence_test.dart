// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TweenSequence and TweenSequenceItem from animation
// Deep Demo: Visual demonstration of multi-stage tween sequences with weights and curves
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TweenSequence Deep Demo executing');

  // Shared sample grid used by most visualisations: 0.0, 0.1, ..., 1.0
  final samples = <double>[
    0.0,
    0.1,
    0.2,
    0.3,
    0.4,
    0.5,
    0.6,
    0.7,
    0.8,
    0.9,
    1.0,
  ];

  // ============================================================
  // SECTION 1: TweenSequence concept overview
  // ============================================================
  print('=== Section 1: TweenSequence Concept Overview ===');

  final conceptCards = <Widget>[];

  // Concept 1: What is a TweenSequence
  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade50, Colors.indigo.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.deepPurple.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.timeline, size: 44.0, color: Colors.deepPurple),
          SizedBox(height: 10.0),
          Text(
            'TweenSequence<T>',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Composes a list of\nTweenSequenceItems into a\nsingle Animatable<T>',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.deepPurple.shade700,
            ),
          ),
        ],
      ),
    ),
  );

  // Concept 2: weight semantics
  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade50, Colors.orange.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.tune, size: 44.0, color: Colors.orange.shade800),
          SizedBox(height: 10.0),
          Text(
            'weight',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Each item\'s share of the\ntimeline is weight / sum.\nUnits are arbitrary.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.orange.shade900),
          ),
        ],
      ),
    ),
  );

  // Concept 3: chaining curves
  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.cyan.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.show_chart, size: 44.0, color: Colors.teal.shade700),
          SizedBox(height: 10.0),
          Text(
            '.chain(CurveTween)',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Per-segment easing\nby chaining a CurveTween\ninside any item.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.teal.shade900),
          ),
        ],
      ),
    ),
  );

  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: double sequence — 3 stages (0→1, 1→0.3, 0.3→1)
  // ============================================================
  print('=== Section 2: double TweenSequence (0→1, 1→0.3, 0.3→1) ===');

  final doubleSequence = TweenSequence<double>([
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      weight: 1,
    ),
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 1.0, end: 0.3),
      weight: 1,
    ),
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 0.3, end: 1.0),
      weight: 1,
    ),
  ]);

  // Pre-compute samples so we can render them and print them.
  final doubleSamples = <double>[];
  for (final t in samples) {
    final v = doubleSequence.transform(t);
    doubleSamples.add(v);
    print('  doubleSequence.transform(${t.toStringAsFixed(2)}) = '
        '${v.toStringAsFixed(3)}');
  }

  final doubleBars = <Widget>[];
  for (int i = 0; i < samples.length; i++) {
    final t = samples[i];
    final v = doubleSamples[i];
    doubleBars.add(
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                v.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
              SizedBox(height: 4.0),
              Container(
                height: 120.0 * v + 4.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo.shade300, Colors.indigo.shade700],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(4.0),
                  ),
                ),
              ),
              SizedBox(height: 4.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 1.0),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Text(
                  't=${t.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 9.0,
                    color: Colors.indigo.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final doubleBarChart = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TweenSequence<double>([0→1, 1→0.3, 0.3→1]) with equal weights',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 8.0),
        SizedBox(
          height: 170.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: doubleBars,
          ),
        ),
      ],
    ),
  );

  print('Created double bar chart with ${doubleBars.length} samples');

  // ============================================================
  // SECTION 3: weight effect — three weight configurations
  // ============================================================
  print('=== Section 3: Weight Effect Comparison ===');

  // Build a chart for one weight configuration.
  final weightConfigs = <Map<String, dynamic>>[
    {
      'label': 'weights: 1 / 1 / 1 (equal)',
      'weights': <int>[1, 1, 1],
      'color': Colors.blue,
    },
    {
      'label': 'weights: 8 / 1 / 1 (front-loaded)',
      'weights': <int>[8, 1, 1],
      'color': Colors.green,
    },
    {
      'label': 'weights: 1 / 1 / 8 (back-loaded)',
      'weights': <int>[1, 1, 8],
      'color': Colors.deepOrange,
    },
  ];

  final weightCharts = <Widget>[];
  for (final cfg in weightConfigs) {
    final weights = cfg['weights'] as List<int>;
    final color = cfg['color'] as MaterialColor;
    final label = cfg['label'] as String;

    final seq = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: weights[0].toDouble(),
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 0.3),
        weight: weights[1].toDouble(),
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.3, end: 1.0),
        weight: weights[2].toDouble(),
      ),
    ]);

    final values = <double>[];
    for (final t in samples) {
      values.add(seq.transform(t));
    }

    final bars = <Widget>[];
    for (int i = 0; i < samples.length; i++) {
      final t = samples[i];
      final v = values[i];
      bars.add(
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  v.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 8.5,
                    color: color.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.0),
                Container(
                  height: 90.0 * v + 3.0,
                  color: color.shade500,
                ),
                SizedBox(height: 2.0),
                Text(
                  t.toStringAsFixed(1),
                  style: TextStyle(fontSize: 8.0, color: color.shade900),
                ),
              ],
            ),
          ),
        ),
      );
    }

    weightCharts.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.shade300, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.bar_chart, size: 16.0, color: color.shade700),
                SizedBox(width: 6.0),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    color: color.shade900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            SizedBox(
              height: 130.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: bars,
              ),
            ),
          ],
        ),
      ),
    );
    print('Built weight chart: $label');
  }

  // ============================================================
  // SECTION 4: ColorTween sequence (red→blue→green→yellow)
  // ============================================================
  print('=== Section 4: Color TweenSequence ===');

  final colorSequence = TweenSequence<Color?>([
    TweenSequenceItem<Color?>(
      tween: ColorTween(begin: Colors.red, end: Colors.blue),
      weight: 1,
    ),
    TweenSequenceItem<Color?>(
      tween: ColorTween(begin: Colors.blue, end: Colors.green),
      weight: 1,
    ),
    TweenSequenceItem<Color?>(
      tween: ColorTween(begin: Colors.green, end: Colors.yellow),
      weight: 1,
    ),
  ]);

  final colorSwatches = <Widget>[];
  for (int i = 0; i < samples.length; i++) {
    final t = samples[i];
    final c = colorSequence.transform(t) ?? Colors.black;
    final r = (c.r * 255).round();
    final g = (c.g * 255).round();
    final b = (c.b * 255).round();
    print('  colorSequence.transform(${t.toStringAsFixed(2)}) = '
        'rgb($r,$g,$b)');

    colorSwatches.add(
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.5),
          child: Column(
            children: [
              Text(
                't=${t.toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: 9.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 3.0),
              Container(
                height: 64.0,
                decoration: BoxDecoration(
                  color: c,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: Colors.black26, width: 0.5),
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                '$r,$g,$b',
                style: TextStyle(
                  fontSize: 8.0,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final colorStrip = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TweenSequence<Color?>([red→blue, blue→green, green→yellow])',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        SizedBox(height: 8.0),
        Row(children: colorSwatches),
      ],
    ),
  );

  print('Created color strip with ${colorSwatches.length} swatches');

  // ============================================================
  // SECTION 5: Offset sequence — path traced as dots
  // ============================================================
  print('=== Section 5: Offset TweenSequence path ===');

  // Path: top-left -> top-right -> bottom-right -> bottom-left.
  final offsetSequence = TweenSequence<Offset>([
    TweenSequenceItem<Offset>(
      tween: Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(1.0, 0.0)),
      weight: 1,
    ),
    TweenSequenceItem<Offset>(
      tween: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(1.0, 1.0)),
      weight: 1,
    ),
    TweenSequenceItem<Offset>(
      tween: Tween<Offset>(begin: Offset(1.0, 1.0), end: Offset(0.0, 1.0)),
      weight: 1,
    ),
  ]);

  const pathCanvasWidth = 320.0;
  const pathCanvasHeight = 160.0;
  const pathPadding = 16.0;
  const dotSize = 14.0;

  final pathDots = <Widget>[];
  // Background grid lines for orientation.
  pathDots.add(
    Positioned(
      left: pathPadding,
      right: pathPadding,
      top: pathPadding,
      bottom: pathPadding,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
          color: Colors.white,
        ),
      ),
    ),
  );

  for (int i = 0; i < samples.length; i++) {
    final t = samples[i];
    final pos = offsetSequence.transform(t);
    final usableW = pathCanvasWidth - 2 * pathPadding - dotSize;
    final usableH = pathCanvasHeight - 2 * pathPadding - dotSize;
    final left = pathPadding + pos.dx * usableW;
    final top = pathPadding + pos.dy * usableH;

    print('  offsetSequence.transform(${t.toStringAsFixed(2)}) = '
        '(${pos.dx.toStringAsFixed(2)}, ${pos.dy.toStringAsFixed(2)})');

    // Fade older dots so the trail is visible.
    final fade = 0.35 + 0.65 * (i / (samples.length - 1));
    pathDots.add(
      Positioned(
        left: left,
        top: top,
        child: Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            color: Colors.purple.withValues(alpha: fade),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withValues(alpha: 0.35),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              '${i}',
              style: TextStyle(
                fontSize: 7.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  final offsetPath = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.purple.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.purple.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TweenSequence<Offset> traced across 11 samples',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.purple.shade900,
          ),
        ),
        SizedBox(height: 8.0),
        Center(
          child: SizedBox(
            width: pathCanvasWidth,
            height: pathCanvasHeight,
            child: Stack(children: pathDots),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Path: (0,0) → (1,0) → (1,1) → (0,1)',
          style: TextStyle(
            fontSize: 10.5,
            color: Colors.purple.shade800,
          ),
        ),
      ],
    ),
  );

  print('Created offset path with ${samples.length} dots');

  // ============================================================
  // SECTION 6: ConstantTween segments (flat holds in waveform)
  // ============================================================
  print('=== Section 6: ConstantTween segments ===');

  final constantSequence = TweenSequence<double>([
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      weight: 1,
    ),
    TweenSequenceItem<double>(
      tween: ConstantTween<double>(1.0),
      weight: 2,
    ),
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 1.0, end: 0.0),
      weight: 1,
    ),
  ]);

  final constantBars = <Widget>[];
  for (int i = 0; i < samples.length; i++) {
    final t = samples[i];
    final v = constantSequence.transform(t);
    print('  constantSequence.transform(${t.toStringAsFixed(2)}) = '
        '${v.toStringAsFixed(3)}');

    constantBars.add(
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                v.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade900,
                ),
              ),
              SizedBox(height: 3.0),
              Container(
                height: 110.0 * v + 4.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.brown.shade300,
                      Colors.brown.shade700,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(3.0),
                  ),
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                t.toStringAsFixed(1),
                style: TextStyle(fontSize: 9.0, color: Colors.brown.shade900),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final constantChart = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.brown.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.brown.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TweenSequence<double>([0→1 (w:1), const 1.0 (w:2), 1→0 (w:1)])',
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.bold,
            color: Colors.brown.shade900,
          ),
        ),
        Text(
          'Notice the flat plateau from t≈0.25 to t≈0.75 — the hold segment.',
          style: TextStyle(fontSize: 10.5, color: Colors.brown.shade700),
        ),
        SizedBox(height: 8.0),
        SizedBox(
          height: 150.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: constantBars,
          ),
        ),
      ],
    ),
  );

  print('Created constant tween chart');

  // ============================================================
  // SECTION 7: CurveTween chained inside TweenSequenceItem
  // ============================================================
  print('=== Section 7: CurveTween inside TweenSequenceItem ===');

  final linearVsCurved = <Map<String, dynamic>>[
    {
      'label': 'Linear: 0→1 (w:1), 1→0 (w:1)',
      'color': Colors.blueGrey,
      'seq': TweenSequence<double>([
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          weight: 1,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.0, end: 0.0),
          weight: 1,
        ),
      ]),
    },
    {
      'label': 'easeInOut chained on each item',
      'color': Colors.deepPurple,
      'seq': TweenSequence<double>([
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 1,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.0, end: 0.0)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 1,
        ),
      ]),
    },
    {
      'label': 'bounceOut chained on each item',
      'color': Colors.pink,
      'seq': TweenSequence<double>([
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: Curves.bounceOut)),
          weight: 1,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.0, end: 0.0)
              .chain(CurveTween(curve: Curves.bounceOut)),
          weight: 1,
        ),
      ]),
    },
  ];

  final curveCharts = <Widget>[];
  for (final entry in linearVsCurved) {
    final seq = entry['seq'] as TweenSequence<double>;
    final color = entry['color'] as MaterialColor;
    final label = entry['label'] as String;

    final bars = <Widget>[];
    for (int i = 0; i < samples.length; i++) {
      final t = samples[i];
      final v = seq.transform(t);
      print('  [$label] transform(${t.toStringAsFixed(2)}) = '
          '${v.toStringAsFixed(3)}');

      bars.add(
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  v.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 8.5,
                    color: color.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.0),
                Container(
                  height: 95.0 * v.clamp(0.0, 1.2) + 3.0,
                  color: color.shade400,
                ),
                SizedBox(height: 2.0),
                Text(
                  t.toStringAsFixed(1),
                  style: TextStyle(fontSize: 8.0, color: color.shade900),
                ),
              ],
            ),
          ),
        ),
      );
    }

    curveCharts.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.shade200, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.auto_graph, size: 16.0, color: color.shade700),
                SizedBox(width: 6.0),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    color: color.shade900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            SizedBox(
              height: 130.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: bars,
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created ${curveCharts.length} curve comparison charts');

  // ============================================================
  // SECTION 8: Code examples
  // ============================================================
  print('=== Section 8: Code Examples ===');

  final codePanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'TweenSequenceItem construction',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          '// 3-stage double sequence: 0 -> 1 -> 0.3 -> 1\n'
          'final seq = TweenSequence<double>([\n'
          '  TweenSequenceItem<double>(\n'
          '    tween: Tween<double>(begin: 0.0, end: 1.0),\n'
          '    weight: 1,\n'
          '  ),\n'
          '  TweenSequenceItem<double>(\n'
          '    tween: Tween<double>(begin: 1.0, end: 0.3),\n'
          '    weight: 1,\n'
          '  ),\n'
          '  TweenSequenceItem<double>(\n'
          '    tween: Tween<double>(begin: 0.3, end: 1.0),\n'
          '    weight: 1,\n'
          '  ),\n'
          ']);\n'
          'final value = seq.transform(0.5);',
          Colors.green.shade300,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// CurveTween chained inside an item\n'
          'TweenSequenceItem<double>(\n'
          '  tween: Tween<double>(begin: 0.0, end: 1.0)\n'
          '      .chain(CurveTween(curve: Curves.easeInOut)),\n'
          '  weight: 1,\n'
          ');',
          Colors.purple.shade300,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// ConstantTween for a hold segment\n'
          'TweenSequenceItem<double>(\n'
          '  tween: ConstantTween<double>(1.0),\n'
          '  weight: 2, // 50% of total when sum is 4\n'
          ');',
          Colors.amber.shade300,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// Works for any type — Color, Offset, Size, ...\n'
          'TweenSequence<Color?>([\n'
          '  TweenSequenceItem(\n'
          '    tween: ColorTween(begin: Colors.red, end: Colors.blue),\n'
          '    weight: 1,\n'
          '  ),\n'
          ']);',
          Colors.cyan.shade300,
        ),
      ],
    ),
  );

  print('Created code panel');

  // ============================================================
  // SECTION 9: Summary takeaways
  // ============================================================
  print('=== Section 9: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.deepPurple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.timeline,
          'Composable',
          'Chain any number of TweenSequenceItems into a single Animatable.',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.tune,
          'Weight controls share',
          'Each item gets weight / sum of the timeline. Units are arbitrary.',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.show_chart,
          'Per-segment curves',
          'Chain a CurveTween inside an item for easing on that stage only.',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.pause_circle,
          'Constant holds',
          'Use ConstantTween<T>(value) for a flat plateau inside the sequence.',
          Colors.brown,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.category,
          'Any type T',
          'Works for double, Color, Offset, Size, and any Tweenable type.',
          Colors.deepPurple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.calculate,
          'Pure transform(t)',
          'TweenSequence.transform(t) is a pure function — perfect for static demos.',
          Colors.green,
        ),
      ],
    ),
  );

  print('Created summary panel');

  print('TweenSequence Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header banner
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Icon(Icons.timeline, size: 56.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'TweenSequence<T>',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Multi-stage tween composition with weights and curves',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1
        Text(
          '1. TweenSequence concept',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: conceptCards),
        SizedBox(height: 32.0),

        // Section 2
        Text(
          '2. double sequence — 11 samples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        doubleBarChart,
        SizedBox(height: 32.0),

        // Section 3
        Text(
          '3. Weight effect comparison',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Column(children: weightCharts),
        SizedBox(height: 32.0),

        // Section 4
        Text(
          '4. ColorTween sequence',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        colorStrip,
        SizedBox(height: 32.0),

        // Section 5
        Text(
          '5. Offset sequence — path trace',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        offsetPath,
        SizedBox(height: 32.0),

        // Section 6
        Text(
          '6. ConstantTween — flat hold',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        constantChart,
        SizedBox(height: 32.0),

        // Section 7
        Text(
          '7. CurveTween chained inside items',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Column(children: curveCharts),
        SizedBox(height: 32.0),

        // Section 8
        Text(
          '8. Code examples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        codePanel,
        SizedBox(height: 32.0),

        // Section 9
        Text(
          '9. Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        summaryPanel,
      ],
    ),
  );
}

// Helper: dark monospace code block
Widget _codeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}

// Helper: build a summary item row
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
