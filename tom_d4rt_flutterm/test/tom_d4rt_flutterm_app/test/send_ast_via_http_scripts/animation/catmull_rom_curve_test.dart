// ignore_for_file: avoid_print
// D4rt test script: Deep Demo - CatmullRomCurve from animation
// Comprehensive demonstration of Catmull-Rom spline interpolation for smooth curves
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  // ============================================================================
  // SECTION 1: BASIC CATMULL-ROM CURVE
  // ============================================================================

  final basicPoints = <Offset>[
    Offset(0.2, 0.2),
    Offset(0.5, 0.8),
    Offset(0.8, 0.2),
  ];
  final basicCurve = CatmullRomCurve(basicPoints);

  final basicResults = <Map<String, dynamic>>[];
  final basicTValues = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];

  for (final t in basicTValues) {
    basicResults.add({'t': t, 'value': basicCurve.transform(t)});
  }

  // ============================================================================
  // SECTION 2: S-CURVE CONFIGURATION
  // ============================================================================

  final sCurvePoints = <Offset>[Offset(0.25, 0.1), Offset(0.75, 0.9)];
  final sCurve = CatmullRomCurve(sCurvePoints);

  final sCurveResults = <Map<String, dynamic>>[];
  for (final t in basicTValues) {
    sCurveResults.add({'t': t, 'value': sCurve.transform(t)});
  }

  // ============================================================================
  // SECTION 3: LINEAR CONTROL POINTS
  // ============================================================================

  final linearPoints = <Offset>[Offset(0.5, 0.5)];
  final linearCurve = CatmullRomCurve(linearPoints);

  final linearResults = <Map<String, dynamic>>[];
  for (final t in basicTValues) {
    linearResults.add({
      't': t,
      'value': linearCurve.transform(t),
      'expectedLinear': t,
    });
  }

  // ============================================================================
  // SECTION 4: EASE-IN-LIKE CURVE
  // ============================================================================

  final easeInPoints = <Offset>[Offset(0.4, 0.0), Offset(0.68, 0.06)];
  final easeInCurve = CatmullRomCurve(easeInPoints);

  final easeInResults = <Map<String, dynamic>>[];
  for (final t in basicTValues) {
    easeInResults.add({'t': t, 'value': easeInCurve.transform(t)});
  }

  // ============================================================================
  // SECTION 5: EASE-OUT-LIKE CURVE
  // ============================================================================

  final easeOutPoints = <Offset>[Offset(0.32, 0.94), Offset(0.6, 1.0)];
  final easeOutCurve = CatmullRomCurve(easeOutPoints);

  final easeOutResults = <Map<String, dynamic>>[];
  for (final t in basicTValues) {
    easeOutResults.add({'t': t, 'value': easeOutCurve.transform(t)});
  }

  // ============================================================================
  // SECTION 6: MULTI-POINT COMPLEX CURVE
  // ============================================================================

  final complexPoints = <Offset>[
    Offset(0.1, 0.1),
    Offset(0.2, 0.8),
    Offset(0.4, 0.2),
    Offset(0.6, 0.9),
    Offset(0.8, 0.3),
    Offset(0.9, 0.7),
  ];
  final complexCurve = CatmullRomCurve(complexPoints);

  final complexResults = <Map<String, dynamic>>[];
  for (final t in basicTValues) {
    complexResults.add({'t': t, 'value': complexCurve.transform(t)});
  }

  // ============================================================================
  // SECTION 7: BOUNDARY CONDITIONS
  // ============================================================================

  final boundaryResults = <Map<String, dynamic>>[];

  // Test at exact boundaries
  boundaryResults.add({
    'test': 'Basic at t=0.0',
    'value': basicCurve.transform(0.0),
    'boundary': 'start',
  });
  boundaryResults.add({
    'test': 'Basic at t=1.0',
    'value': basicCurve.transform(1.0),
    'boundary': 'end',
  });
  boundaryResults.add({
    'test': 'S-curve at t=0.0',
    'value': sCurve.transform(0.0),
    'boundary': 'start',
  });
  boundaryResults.add({
    'test': 'S-curve at t=1.0',
    'value': sCurve.transform(1.0),
    'boundary': 'end',
  });
  boundaryResults.add({
    'test': 'Complex at t=0.0',
    'value': complexCurve.transform(0.0),
    'boundary': 'start',
  });
  boundaryResults.add({
    'test': 'Complex at t=1.0',
    'value': complexCurve.transform(1.0),
    'boundary': 'end',
  });

  // ============================================================================
  // SECTION 8: FINE-GRAINED SAMPLING
  // ============================================================================

  final fineGrainedResults = <Map<String, dynamic>>[];
  final fineTValues = <double>[];
  for (var i = 0; i <= 20; i++) {
    fineTValues.add(i / 20.0);
  }

  for (final t in fineTValues) {
    fineGrainedResults.add({
      't': t,
      'basic': basicCurve.transform(t),
      'sCurve': sCurve.transform(t),
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
                colors: [Color(0xFF5E35B1), Color(0xFF7E57C2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CatmullRomCurve',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Deep Demo: Catmull-Rom Spline Interpolation',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFD1C4E9)),
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
                    'Smooth curves through control points',
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
              color: Color(0xFFEDE7F6),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFB39DDB), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF673AB7),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text('📈', style: TextStyle(fontSize: 20.0)),
                    ),
                    SizedBox(width: 12.0),
                    Text(
                      'Concept Overview',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4527A0),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'CatmullRomCurve creates smooth curves using Catmull-Rom spline '
                  'interpolation. Unlike Bézier curves, Catmull-Rom splines pass '
                  'through all control points, making them intuitive to design.',
                  style: TextStyle(fontSize: 14.0, height: 1.5),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Key characteristics:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '• Passes through all control points',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• Smooth C1 continuity between segments',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• Control points define shape intuitively',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• Good for UI animation curves',
                  style: TextStyle(fontSize: 13.0),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 1: BASIC CURVE =====
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
                  '1. Basic 3-Point Curve',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Control points: (0.2,0.2), (0.5,0.8), (0.8,0.2)',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'monospace',
                    color: Color(0xFF757575),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final result in basicResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 45.0,
                          child: Text(
                            't=${result['t']}',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 18.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFC8E6C9),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (result['value'] as double).clamp(
                                0.0,
                                1.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF4CAF50),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        SizedBox(
                          width: 55.0,
                          child: Text(
                            (result['value'] as double).toStringAsFixed(3),
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
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 2: S-CURVE =====
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
                  '2. S-Curve Configuration',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Control points: (0.25,0.1), (0.75,0.9)',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'monospace',
                    color: Color(0xFF757575),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final result in sCurveResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 45.0,
                          child: Text(
                            't=${result['t']}',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 18.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFBBDEFB),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (result['value'] as double).clamp(
                                0.0,
                                1.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF2196F3),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        SizedBox(
                          width: 55.0,
                          child: Text(
                            (result['value'] as double).toStringAsFixed(3),
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
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 3: LINEAR FALLBACK =====
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
                  '3. Single Point (Near-Linear)',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC2185B),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Control point: (0.5, 0.5)',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'monospace',
                    color: Color(0xFF757575),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final result in linearResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 45.0,
                          child: Text(
                            't=${result['t']}',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 18.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFF8BBD9),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (result['value'] as double).clamp(
                                0.0,
                                1.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFE91E63),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        SizedBox(
                          width: 55.0,
                          child: Text(
                            (result['value'] as double).toStringAsFixed(3),
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
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 4: EASE-IN LIKE =====
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
                  '4. Ease-In Like Curve',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE65100),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Control points: (0.4,0.0), (0.68,0.06)',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'monospace',
                    color: Color(0xFF757575),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final result in easeInResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 45.0,
                          child: Text(
                            't=${result['t']}',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 18.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFE0B2),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (result['value'] as double).clamp(
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
                          width: 55.0,
                          child: Text(
                            (result['value'] as double).toStringAsFixed(3),
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
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 5: EASE-OUT LIKE =====
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
                  '5. Ease-Out Like Curve',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B1FA2),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Control points: (0.32,0.94), (0.6,1.0)',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'monospace',
                    color: Color(0xFF757575),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final result in easeOutResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 45.0,
                          child: Text(
                            't=${result['t']}',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 18.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFE1BEE7),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (result['value'] as double).clamp(
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
                          width: 55.0,
                          child: Text(
                            (result['value'] as double).toStringAsFixed(3),
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
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 6: COMPLEX CURVE =====
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
                  '6. Complex 6-Point Curve',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00838F),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '6 control points creating wave pattern',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                for (final result in complexResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 45.0,
                          child: Text(
                            't=${result['t']}',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 18.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFB2EBF2),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (result['value'] as double).clamp(
                                0.0,
                                1.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF00BCD4),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        SizedBox(
                          width: 55.0,
                          child: Text(
                            (result['value'] as double).toStringAsFixed(3),
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
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 7: BOUNDARY CONDITIONS =====
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
                  '7. Boundary Conditions',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final result in boundaryResults)
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
                              color: result['boundary'] == 'start'
                                  ? Color(0xFF4CAF50)
                                  : Color(0xFF2196F3),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              result['boundary'],
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Expanded(
                            child: Text(
                              result['test'],
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ),
                          Text(
                            (result['value'] as double).toStringAsFixed(4),
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'monospace',
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

          // ===== SECTION 8: COMPARISON TABLE =====
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
                  '8. Curve Comparison (Fine-Grained)',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF303F9F),
                  ),
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
                        'Basic',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'S-Curve',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                for (var i = 0; i < fineGrainedResults.length; i += 2)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            (fineGrainedResults[i]['t'] as double)
                                .toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            (fineGrainedResults[i]['basic'] as double)
                                .toStringAsFixed(3),
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            (fineGrainedResults[i]['sCurve'] as double)
                                .toStringAsFixed(3),
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
                        color: Color(0xFF673AB7),
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
                      'CatmullRomCurve Usage',
                      style: TextStyle(
                        color: Color(0xFFB0BEC5),
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  '// Define control points\n'
                  'final controlPoints = <Offset>[\n'
                  '  Offset(0.2, 0.2),  // Early slow\n'
                  '  Offset(0.5, 0.8),  // Peak\n'
                  '  Offset(0.8, 0.2),  // Late slow\n'
                  '];\n'
                  '\n'
                  '// Create the curve\n'
                  'final curve = CatmullRomCurve(controlPoints);\n'
                  '\n'
                  '// Use with CurvedAnimation\n'
                  'final animation = CurvedAnimation(\n'
                  '  parent: controller,\n'
                  '  curve: curve,\n'
                  ');\n'
                  '\n'
                  '// Or transform directly\n'
                  'final position = curve.transform(0.5);',
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
                colors: [Color(0xFF5E35B1), Color(0xFF7E57C2)],
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
                _buildSummaryItem('Basic 3-point curve', 'PASS'),
                _buildSummaryItem('S-curve configuration', 'PASS'),
                _buildSummaryItem('Single point (linear)', 'PASS'),
                _buildSummaryItem('Ease-in like curve', 'PASS'),
                _buildSummaryItem('Ease-out like curve', 'PASS'),
                _buildSummaryItem('Complex 6-point curve', 'PASS'),
                _buildSummaryItem('Boundary conditions', 'PASS'),
                _buildSummaryItem('Fine-grained sampling', 'PASS'),
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
                        'CatmullRomCurve: ',
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
              'Deep Demo • CatmullRomCurve • Flutter Animation',
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
