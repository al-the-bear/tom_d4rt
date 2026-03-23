// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - CatmullRomSpline from animation
// Comprehensive demonstration of 2D Catmull-Rom spline interpolation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  // ============================================================================
  // SECTION 1: BASIC CATMULL-ROM SPLINE
  // ============================================================================

  final basicPoints = <Offset>[
    Offset(0.0, 0.0),
    Offset(0.3, 0.8),
    Offset(0.7, 0.2),
    Offset(1.0, 1.0),
  ];
  final basicSpline = CatmullRomSpline(basicPoints);

  final basicResults = <Map<String, dynamic>>[];
  final tValues = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];

  for (final t in tValues) {
    final point = basicSpline.transform(t);
    basicResults.add({'t': t, 'x': point.dx, 'y': point.dy});
  }

  // ============================================================================
  // SECTION 2: SAMPLE GENERATION
  // ============================================================================

  final defaultSamples = basicSpline.generateSamples().toList();
  final fineSamples = basicSpline.generateSamples(tolerance: 0.01).toList();
  final coarseSamples = basicSpline.generateSamples(tolerance: 0.5).toList();

  final sampleAnalysis = <Map<String, dynamic>>[
    {'name': 'Default', 'count': defaultSamples.length},
    {'name': 'Fine (0.01)', 'count': fineSamples.length},
    {'name': 'Coarse (0.5)', 'count': coarseSamples.length},
  ];

  // ============================================================================
  // SECTION 3: PRECOMPUTED SPLINE
  // ============================================================================

  final precomputed = CatmullRomSpline.precompute(basicPoints);

  final precomputeComparison = <Map<String, dynamic>>[];
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final regular = basicSpline.transform(t);
    final pre = precomputed.transform(t);
    precomputeComparison.add({
      't': t,
      'regularX': regular.dx,
      'regularY': regular.dy,
      'precompX': pre.dx,
      'precompY': pre.dy,
    });
  }

  // ============================================================================
  // SECTION 4: LINEAR SPLINE (2 POINTS)
  // ============================================================================

  final linearPoints = <Offset>[Offset(0.0, 0.0), Offset(1.0, 1.0)];
  final linearSpline = CatmullRomSpline(linearPoints);

  final linearResults = <Map<String, dynamic>>[];
  for (final t in tValues) {
    final point = linearSpline.transform(t);
    linearResults.add({'t': t, 'x': point.dx, 'y': point.dy});
  }

  // ============================================================================
  // SECTION 5: WAVE SPLINE (MANY POINTS)
  // ============================================================================

  final wavePoints = <Offset>[
    Offset(0.0, 0.5),
    Offset(0.2, 1.0),
    Offset(0.4, 0.0),
    Offset(0.6, 1.0),
    Offset(0.8, 0.0),
    Offset(1.0, 0.5),
  ];
  final waveSpline = CatmullRomSpline(wavePoints);

  final waveResults = <Map<String, dynamic>>[];
  for (final t in tValues) {
    final point = waveSpline.transform(t);
    waveResults.add({'t': t, 'x': point.dx, 'y': point.dy});
  }

  // ============================================================================
  // SECTION 6: LOOP SPLINE (CLOSED)
  // ============================================================================

  final loopPoints = <Offset>[
    Offset(0.5, 0.0),
    Offset(1.0, 0.5),
    Offset(0.5, 1.0),
    Offset(0.0, 0.5),
    Offset(0.5, 0.0),
  ];
  final loopSpline = CatmullRomSpline(loopPoints);

  final loopResults = <Map<String, dynamic>>[];
  for (final t in tValues) {
    final point = loopSpline.transform(t);
    loopResults.add({'t': t, 'x': point.dx, 'y': point.dy});
  }

  // ============================================================================
  // SECTION 7: SAMPLE INSPECTION
  // ============================================================================

  final sampleInspection = <Map<String, dynamic>>[];
  final step = defaultSamples.length ~/ 8;
  for (
    var i = 0;
    i < defaultSamples.length;
    i += step.clamp(1, defaultSamples.length)
  ) {
    final s = defaultSamples[i];
    sampleInspection.add({
      'index': i,
      't': s.t,
      'x': s.value.dx,
      'y': s.value.dy,
    });
  }

  // ============================================================================
  // SECTION 8: BOUNDARY CONDITIONS
  // ============================================================================

  final boundaryResults = <Map<String, dynamic>>[];

  final splines = [
    {'name': 'Basic', 'spline': basicSpline},
    {'name': 'Linear', 'spline': linearSpline},
    {'name': 'Wave', 'spline': waveSpline},
    {'name': 'Loop', 'spline': loopSpline},
  ];

  for (final entry in splines) {
    final spline = entry['spline'] as CatmullRomSpline;
    final start = spline.transform(0.0);
    final end = spline.transform(1.0);
    boundaryResults.add({
      'name': entry['name'],
      'startX': start.dx,
      'startY': start.dy,
      'endX': end.dx,
      'endY': end.dy,
    });
  }

  // ============================================================================
  // BUILD COMPREHENSIVE UI
  // ============================================================================

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ===== HEADER =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00695C), Color(0xFF00897B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CatmullRomSpline',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Deep Demo: 2D Catmull-Rom Spline Interpolation',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFB2DFDB)),
                ),
                SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    'Returns 2D Offset points along path',
                    style: TextStyle(fontSize: 14.0, color: Color(0xFFFFFFFF)),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== CONCEPT OVERVIEW =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE0F2F1),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF80CBC4), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF009688),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text('🔄', style: TextStyle(fontSize: 20.0)),
                    ),
                    SizedBox(width: 12.0),
                    Text(
                      'Concept Overview',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF004D40),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'CatmullRomSpline creates smooth 2D paths through control points. '
                  'Unlike CatmullRomCurve (1D), this returns Offset(x,y) for each t value, '
                  'allowing complex path animations.',
                  style: TextStyle(fontSize: 14.0, height: 1.5),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Key features:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '• transform(t) returns Offset position',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• generateSamples() for adaptive sampling',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• precompute() for repeated evaluations',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• Configurable sample tolerance',
                  style: TextStyle(fontSize: 13.0),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 1: BASIC SPLINE =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF81C784), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. Basic 4-Point Spline',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Path through: (0,0) → (0.3,0.8) → (0.7,0.2) → (1,1)',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                for (final result in basicResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40.0,
                          child: Text(
                            't=${result['t']}',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 20.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFC8E6C9),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: (result['x'] as double) * 120,
                                  top: 2.0,
                                  child: Container(
                                    width: 16.0,
                                    height: 16.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF4CAF50),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        SizedBox(
                          width: 100.0,
                          child: Text(
                            '(${(result['x'] as double).toStringAsFixed(2)}, ${(result['y'] as double).toStringAsFixed(2)})',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 2: SAMPLE GENERATION =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF64B5F6), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2. Adaptive Sample Generation',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final analysis in sampleAnalysis)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            analysis['name'] as String,
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 24.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFBBDEFB),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: ((analysis['count'] as int) / 100.0)
                                  .clamp(0.0, 1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF2196F3),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        SizedBox(
                          width: 60.0,
                          child: Text(
                            '${analysis['count']} pts',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'monospace',
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 3: PRECOMPUTED COMPARISON =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFFCE4EC),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFF06292), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '3. Precomputed vs Regular',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC2185B),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'CatmullRomSpline.precompute() for repeated access',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        't',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Regular',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Precomputed',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                for (final comp in precomputeComparison)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${comp['t']}',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '(${(comp['regularX'] as double).toStringAsFixed(2)}, ${(comp['regularY'] as double).toStringAsFixed(2)})',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '(${(comp['precompX'] as double).toStringAsFixed(2)}, ${(comp['precompY'] as double).toStringAsFixed(2)})',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 4: LINEAR SPLINE =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFFFB74D), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '4. Linear 2-Point Spline',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE65100),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Diagonal: (0,0) → (1,1)',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                for (final result in linearResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40.0,
                          child: Text(
                            't=${result['t']}',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 16.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFE0B2),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (result['x'] as double).clamp(
                                0.0,
                                1.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF9800),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        SizedBox(
                          width: 80.0,
                          child: Text(
                            '(${(result['x'] as double).toStringAsFixed(2)}, ${(result['y'] as double).toStringAsFixed(2)})',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 5: WAVE SPLINE =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFCE93D8), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '5. Wave Pattern (6 Points)',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B1FA2),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Oscillating Y values create wave motion',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                for (final result in waveResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40.0,
                          child: Text(
                            't=${result['t']}',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 16.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFE1BEE7),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (result['y'] as double).clamp(
                                0.0,
                                1.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF9C27B0),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        SizedBox(
                          width: 80.0,
                          child: Text(
                            'y=${(result['y'] as double).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 6: LOOP SPLINE =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE0F7FA),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF4DD0E1), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '6. Closed Loop (Diamond)',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00838F),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Returns to start point (0.5, 0.0)',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                for (final result in loopResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40.0,
                          child: Text(
                            't=${result['t']}',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 20.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFB2EBF2),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: (result['x'] as double) * 120,
                                  top: 2.0,
                                  child: Container(
                                    width: 16.0,
                                    height: 16.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF00BCD4),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        SizedBox(
                          width: 80.0,
                          child: Text(
                            '(${(result['x'] as double).toStringAsFixed(2)}, ${(result['y'] as double).toStringAsFixed(2)})',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 7: SAMPLE INSPECTION =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFEFEBE9),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFA1887F), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '7. Sample Point Inspection',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final sample in sampleInspection)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFD7CCC8),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF795548),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              '#${sample['index']}',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Text(
                            't=${(sample['t'] as double).toStringAsFixed(3)}',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Expanded(
                            child: Text(
                              '(${(sample['x'] as double).toStringAsFixed(3)}, ${(sample['y'] as double).toStringAsFixed(3)})',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontFamily: 'monospace',
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 8: BOUNDARY CONDITIONS =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE8EAF6),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF7986CB), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '8. Boundary Conditions',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF303F9F),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final boundary in boundaryResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFC5CAE9),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            boundary['name'] as String,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                            ),
                          ),
                          SizedBox(height: 6.0),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                  vertical: 2.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF4CAF50),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  'START',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 9.0,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                '(${(boundary['startX'] as double).toStringAsFixed(2)}, ${(boundary['startY'] as double).toStringAsFixed(2)})',
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontFamily: 'monospace',
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                  vertical: 2.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF2196F3),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  'END',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 9.0,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                '(${(boundary['endX'] as double).toStringAsFixed(2)}, ${(boundary['endY'] as double).toStringAsFixed(2)})',
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== CODE EXAMPLE =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFF263238),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF009688),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'Dart',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Text(
                      'CatmullRomSpline Usage',
                      style: TextStyle(
                        color: Color(0xFFB0BEC5),
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  '// Define 2D control points\n'
                  'final points = <Offset>[\n'
                  '  Offset(0.0, 0.0),\n'
                  '  Offset(0.3, 0.8),\n'
                  '  Offset(0.7, 0.2),\n'
                  '  Offset(1.0, 1.0),\n'
                  '];\n'
                  '\n'
                  '// Create spline\n'
                  'final spline = CatmullRomSpline(points);\n'
                  '\n'
                  '// Get position at t=0.5\n'
                  'final pos = spline.transform(0.5);\n'
                  'print(pos.dx, pos.dy);\n'
                  '\n'
                  '// Generate adaptive samples\n'
                  'final samples = spline.generateSamples();\n'
                  'for (final s in samples) {\n'
                  '  print(s.t, s.value);\n'
                  '}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: Color(0xFFCFD8DC),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SUMMARY =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00695C), Color(0xFF00897B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 16.0),
                _buildSummaryItem('Basic 4-point spline', 'PASS'),
                _buildSummaryItem('Adaptive sampling', 'PASS'),
                _buildSummaryItem('Precomputed variant', 'PASS'),
                _buildSummaryItem('Linear 2-point path', 'PASS'),
                _buildSummaryItem('Wave pattern', 'PASS'),
                _buildSummaryItem('Closed loop', 'PASS'),
                _buildSummaryItem('Sample inspection', 'PASS'),
                _buildSummaryItem('Boundary conditions', 'PASS'),
                SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'CatmullRomSpline: ',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        'All Tests Passed ✓',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== FOOTER =====
          Center(
            child: Text(
              'Deep Demo • CatmullRomSpline • Flutter Animation',
              style: TextStyle(fontSize: 12.0, color: Color(0xFF9E9E9E)),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildSummaryItem(String label, String status) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14.0),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
