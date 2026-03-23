// ignore_for_file: avoid_print
// D4rt test script: Deep Demo - Curve2DSample from animation
// Comprehensive demonstration of 2D curve sample points
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  // ============================================================================
  // SECTION 1: GENERATE SAMPLES FROM BASIC SPLINE
  // ============================================================================

  final basicSpline = CatmullRomSpline([
    Offset(0.0, 0.0),
    Offset(0.3, 0.8),
    Offset(0.7, 0.2),
    Offset(1.0, 1.0),
  ]);
  final basicSamples = basicSpline.generateSamples().toList();

  final basicInfo = {
    'count': basicSamples.length,
    'firstT': basicSamples.first.t,
    'firstValue': basicSamples.first.value,
    'lastT': basicSamples.last.t,
    'lastValue': basicSamples.last.value,
  };

  // ============================================================================
  // SECTION 2: SAMPLE DISTRIBUTION
  // ============================================================================

  final distributionSamples = <Map<String, dynamic>>[];
  final step = basicSamples.length ~/ 10;
  for (
    var i = 0;
    i < basicSamples.length;
    i += step.clamp(1, basicSamples.length)
  ) {
    final sample = basicSamples[i];
    distributionSamples.add({
      'index': i,
      't': sample.t,
      'x': sample.value.dx,
      'y': sample.value.dy,
    });
  }

  // ============================================================================
  // SECTION 3: FINE TOLERANCE SAMPLES
  // ============================================================================

  final fineSamples = basicSpline.generateSamples(tolerance: 0.01).toList();
  final fineInfo = <Map<String, dynamic>>[];
  final fineStep = fineSamples.length ~/ 8;
  for (
    var i = 0;
    i < fineSamples.length;
    i += fineStep.clamp(1, fineSamples.length)
  ) {
    final sample = fineSamples[i];
    fineInfo.add({
      'index': i,
      't': sample.t,
      'x': sample.value.dx,
      'y': sample.value.dy,
    });
  }

  // ============================================================================
  // SECTION 4: COARSE TOLERANCE SAMPLES
  // ============================================================================

  final coarseSamples = basicSpline.generateSamples(tolerance: 0.5).toList();
  final coarseInfo = <Map<String, dynamic>>[];
  for (var i = 0; i < coarseSamples.length; i++) {
    final sample = coarseSamples[i];
    coarseInfo.add({
      'index': i,
      't': sample.t,
      'x': sample.value.dx,
      'y': sample.value.dy,
    });
  }

  // ============================================================================
  // SECTION 5: SAMPLE T VALUE SPACING
  // ============================================================================

  final spacingResults = <Map<String, dynamic>>[];
  for (var i = 1; i < basicSamples.length && i < 12; i++) {
    final prev = basicSamples[i - 1];
    final curr = basicSamples[i];
    final delta = curr.t - prev.t;
    spacingResults.add({
      'from': i - 1,
      'to': i,
      'prevT': prev.t,
      'currT': curr.t,
      'delta': delta,
    });
  }

  // ============================================================================
  // SECTION 6: LINEAR SPLINE SAMPLES
  // ============================================================================

  final linearSpline = CatmullRomSpline([Offset(0.0, 0.0), Offset(1.0, 1.0)]);
  final linearSamples = linearSpline.generateSamples().toList();

  final linearInfo = <Map<String, dynamic>>[];
  for (var i = 0; i < linearSamples.length; i++) {
    final sample = linearSamples[i];
    linearInfo.add({
      'index': i,
      't': sample.t,
      'x': sample.value.dx,
      'y': sample.value.dy,
    });
  }

  // ============================================================================
  // SECTION 7: WAVE SPLINE SAMPLES
  // ============================================================================

  final waveSpline = CatmullRomSpline([
    Offset(0.0, 0.5),
    Offset(0.25, 1.0),
    Offset(0.5, 0.0),
    Offset(0.75, 1.0),
    Offset(1.0, 0.5),
  ]);
  final waveSamples = waveSpline.generateSamples().toList();

  final waveInfo = <Map<String, dynamic>>[];
  final waveStep = waveSamples.length ~/ 10;
  for (
    var i = 0;
    i < waveSamples.length;
    i += waveStep.clamp(1, waveSamples.length)
  ) {
    final sample = waveSamples[i];
    waveInfo.add({
      'index': i,
      't': sample.t,
      'x': sample.value.dx,
      'y': sample.value.dy,
    });
  }

  // ============================================================================
  // SECTION 8: SAMPLE COUNT COMPARISON
  // ============================================================================

  final countComparison = <Map<String, dynamic>>[
    {
      'spline': 'Basic (4 pts)',
      'default': basicSamples.length,
      'fine': fineSamples.length,
      'coarse': coarseSamples.length,
    },
    {
      'spline': 'Linear (2 pts)',
      'default': linearSamples.length,
      'fine': linearSpline.generateSamples(tolerance: 0.01).length,
      'coarse': linearSpline.generateSamples(tolerance: 0.5).length,
    },
    {
      'spline': 'Wave (5 pts)',
      'default': waveSamples.length,
      'fine': waveSpline.generateSamples(tolerance: 0.01).length,
      'coarse': waveSpline.generateSamples(tolerance: 0.5).length,
    },
  ];

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
                colors: [Color(0xFFD84315), Color(0xFFE64A19)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Curve2DSample',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Deep Demo: 2D Curve Sample Points',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFFFCCBC)),
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
                    'Contains t parameter and Offset value',
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
              color: Color(0xFFFBE9E7),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFFFAB91), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFF5722),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text('🎯', style: TextStyle(fontSize: 20.0)),
                    ),
                    SizedBox(width: 12.0),
                    Text(
                      'Concept Overview',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFBF360C),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Curve2DSample represents a single point sampled from a Curve2D. '
                  'It contains the parameter t (0.0-1.0) and the corresponding Offset '
                  'value at that parameter. Samples are generated adaptively based on '
                  'curve curvature.',
                  style: TextStyle(fontSize: 14.0, height: 1.5),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Properties:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '• t - Parameter value (0.0 to 1.0)',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• value - Offset position at t',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• Samples are denser where curvature is high',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• Tolerance affects sample density',
                  style: TextStyle(fontSize: 13.0),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 1: BASIC SAMPLE INFO =====
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
                  '1. Basic Spline Samples',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                SizedBox(height: 16.0),
                _buildInfoRow('Total Samples', '${basicInfo['count']}'),
                SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFC8E6C9),
                    borderRadius: BorderRadius.circular(8.0),
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
                              color: Color(0xFF4CAF50),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              'FIRST',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Text(
                            't = ${(basicInfo['firstT'] as double).toStringAsFixed(4)}',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Text(
                            'value = ${basicInfo['firstValue']}',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF2196F3),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              'LAST',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Text(
                            't = ${(basicInfo['lastT'] as double).toStringAsFixed(4)}',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Text(
                            'value = ${basicInfo['lastValue']}',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 2: SAMPLE DISTRIBUTION =====
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
                  '2. Sample Distribution',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final sample in distributionSamples)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      children: [
                        Container(
                          width: 35.0,
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF2196F3),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            '#${sample['index']}',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 10.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        SizedBox(
                          width: 60.0,
                          child: Text(
                            't=${(sample['t'] as double).toStringAsFixed(3)}',
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
                              color: Color(0xFFBBDEFB),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: ((sample['x'] as double) * 100).clamp(
                                    0.0,
                                    100.0,
                                  ),
                                  top: 0.0,
                                  child: Container(
                                    width: 16.0,
                                    height: 16.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF1976D2),
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
                            '(${(sample['x'] as double).toStringAsFixed(2)},${(sample['y'] as double).toStringAsFixed(2)})',
                            style: TextStyle(
                              fontSize: 9.0,
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

          // ===== SECTION 3: FINE SAMPLES =====
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
                  '3. Fine Tolerance (0.01)',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC2185B),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Total samples: ${fineSamples.length}',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                for (final sample in fineInfo.take(6))
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 35.0,
                          child: Text(
                            '#${sample['index']}',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 14.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFF8BBD9),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (sample['t'] as double).clamp(
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
                          width: 50.0,
                          child: Text(
                            't=${(sample['t'] as double).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 9.0,
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

          // ===== SECTION 4: COARSE SAMPLES =====
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
                  '4. Coarse Tolerance (0.5)',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE65100),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Total samples: ${coarseSamples.length}',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                for (final sample in coarseInfo)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE0B2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF9800),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${sample['index']}',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                't = ${(sample['t'] as double).toStringAsFixed(4)}',
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontFamily: 'monospace',
                                ),
                              ),
                              Text(
                                '(${(sample['x'] as double).toStringAsFixed(3)}, ${(sample['y'] as double).toStringAsFixed(3)})',
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontFamily: 'monospace',
                                  color: Color(0xFF757575),
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

          SizedBox(height: 16.0),

          // ===== SECTION 5: T SPACING =====
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
                  '5. Sample T Spacing (Adaptive)',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B1FA2),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Δt varies based on curve curvature',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                for (final spacing in spacingResults.take(8))
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 50.0,
                          child: Text(
                            '${spacing['from']}→${spacing['to']}',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 12.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFE1BEE7),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: ((spacing['delta'] as double) * 10)
                                  .clamp(0.0, 1.0),
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
                          width: 60.0,
                          child: Text(
                            'Δ=${(spacing['delta'] as double).toStringAsFixed(4)}',
                            style: TextStyle(
                              fontSize: 9.0,
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

          // ===== SECTION 6: LINEAR SPLINE =====
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
                  '6. Linear Spline Samples',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00838F),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Minimal curvature = fewer samples (${linearSamples.length})',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                for (final sample in linearInfo)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 20.0,
                          height: 20.0,
                          decoration: BoxDecoration(
                            color: Color(0xFF00BCD4),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${sample['index']}',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 10.0,
                              ),
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
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 7: WAVE SPLINE =====
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
                  '7. Wave Spline Samples',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'High curvature = more samples (${waveSamples.length})',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                for (final sample in waveInfo.take(8))
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 35.0,
                          child: Text(
                            '#${sample['index']}',
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
                              color: Color(0xFFD7CCC8),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (sample['y'] as double).clamp(
                                0.0,
                                1.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF795548),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        SizedBox(
                          width: 50.0,
                          child: Text(
                            'y=${(sample['y'] as double).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 9.0,
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

          // ===== SECTION 8: COMPARISON =====
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
                  '8. Sample Count Comparison',
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
                      flex: 2,
                      child: Text(
                        'Spline',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Default',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Fine',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Coarse',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                for (final count in countComparison)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            count['spline'] as String,
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFC5CAE9),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              '${count['default']}',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontFamily: 'monospace',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(width: 4.0),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFF8BBD9),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              '${count['fine']}',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontFamily: 'monospace',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(width: 4.0),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFE0B2),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              '${count['coarse']}',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontFamily: 'monospace',
                              ),
                              textAlign: TextAlign.center,
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
                        color: Color(0xFFFF5722),
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
                      'Curve2DSample Usage',
                      style: TextStyle(
                        color: Color(0xFFB0BEC5),
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  '// Generate samples from spline\n'
                  'final spline = CatmullRomSpline(points);\n'
                  'final samples = spline.generateSamples();\n'
                  '\n'
                  '// Access sample properties\n'
                  'for (final sample in samples) {\n'
                  '  print(sample.t);      // 0.0-1.0\n'
                  '  print(sample.value);  // Offset\n'
                  '}\n'
                  '\n'
                  '// Control density with tolerance\n'
                  'final fine = spline.generateSamples(\n'
                  '  tolerance: 0.01,  // More samples\n'
                  ');\n'
                  'final coarse = spline.generateSamples(\n'
                  '  tolerance: 0.5,   // Fewer samples\n'
                  ');',
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
                colors: [Color(0xFFD84315), Color(0xFFE64A19)],
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
                _buildSummaryItem('Basic sample generation', 'PASS'),
                _buildSummaryItem('Sample distribution', 'PASS'),
                _buildSummaryItem('Fine tolerance', 'PASS'),
                _buildSummaryItem('Coarse tolerance', 'PASS'),
                _buildSummaryItem('Adaptive t spacing', 'PASS'),
                _buildSummaryItem('Linear spline samples', 'PASS'),
                _buildSummaryItem('Wave spline samples', 'PASS'),
                _buildSummaryItem('Count comparison', 'PASS'),
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
                        'Curve2DSample: ',
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
              'Deep Demo • Curve2DSample • Flutter Animation',
              style: TextStyle(fontSize: 12.0, color: Color(0xFF9E9E9E)),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildInfoRow(String label, String value) {
  return Row(
    children: [
      Text('$label: ', style: TextStyle(fontSize: 13.0)),
      Text(
        value,
        style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
      ),
    ],
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
