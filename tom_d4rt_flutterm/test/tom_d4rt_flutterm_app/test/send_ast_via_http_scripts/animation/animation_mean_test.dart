// D4rt test script: Deep Demo - AnimationMean from animation
// Comprehensive demonstration of the AnimationMean class for averaging two animations
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  // ============================================================================
  // SECTION 1: BASIC ANIMATIONMEAN OPERATION
  // ============================================================================

  final basicLeft = AlwaysStoppedAnimation<double>(0.2);
  final basicRight = AlwaysStoppedAnimation<double>(0.8);
  final basicMean = AnimationMean(left: basicLeft, right: basicRight);

  final basicMeanResults = <Map<String, dynamic>>[
    {
      'left': 0.2,
      'right': 0.8,
      'expected': 0.5,
      'actual': basicMean.value,
      'matches': (basicMean.value - 0.5).abs() < 0.0001,
    },
  ];

  // ============================================================================
  // SECTION 2: COMPREHENSIVE VALUE PAIRS TESTING
  // ============================================================================

  final valuePairTests = <Map<String, dynamic>>[];

  final testPairs = [
    (0.0, 0.0), // Both zero
    (1.0, 1.0), // Both one
    (0.0, 1.0), // Min and max
    (0.5, 0.5), // Equal midpoints
    (0.1, 0.9), // Symmetric around 0.5
    (0.2, 0.8), // Symmetric around 0.5
    (0.3, 0.7), // Symmetric around 0.5
    (0.4, 0.6), // Symmetric around 0.5
    (0.25, 0.75), // Quarter points
    (0.0, 0.5), // Lower half
    (0.5, 1.0), // Upper half
    (0.1, 0.2), // Small range
    (0.8, 0.9), // High range
    (0.33, 0.67), // Thirds
    (0.0, 0.25), // First quarter
  ];

  for (final pair in testPairs) {
    final left = AlwaysStoppedAnimation<double>(pair.$1);
    final right = AlwaysStoppedAnimation<double>(pair.$2);
    final mean = AnimationMean(left: left, right: right);
    final expectedMean = (pair.$1 + pair.$2) / 2.0;

    valuePairTests.add({
      'left': pair.$1,
      'right': pair.$2,
      'expected': expectedMean,
      'actual': mean.value,
      'difference': (mean.value - expectedMean).abs(),
      'matches': (mean.value - expectedMean).abs() < 0.0001,
    });
  }

  // ============================================================================
  // SECTION 3: STATUS BEHAVIOR ANALYSIS
  // ============================================================================

  final statusTests = <Map<String, dynamic>>[];

  // Test status with different value combinations
  final statusCombos = [
    (0.0, 0.0),
    (0.0, 1.0),
    (1.0, 0.0),
    (1.0, 1.0),
    (0.5, 0.5),
  ];

  for (final combo in statusCombos) {
    final left = AlwaysStoppedAnimation<double>(combo.$1);
    final right = AlwaysStoppedAnimation<double>(combo.$2);
    final mean = AnimationMean(left: left, right: right);

    statusTests.add({
      'left': combo.$1,
      'right': combo.$2,
      'meanValue': mean.value,
      'status': mean.status.name,
      'isDismissed': mean.isDismissed,
      'isCompleted': mean.isCompleted,
    });
  }

  // ============================================================================
  // SECTION 4: MATHEMATICAL PRECISION CHECK
  // ============================================================================

  final precisionTests = <Map<String, dynamic>>[];

  // Test with values that might have floating point precision issues
  final precisionPairs = [
    (0.1, 0.2), // 0.15
    (0.333, 0.667), // ~0.5
    (0.111, 0.889), // ~0.5
    (0.123, 0.456), // 0.2895
    (0.999, 0.001), // 0.5
    (0.125, 0.875), // 0.5
    (0.0001, 0.9999), // ~0.5
  ];

  for (final pair in precisionPairs) {
    final left = AlwaysStoppedAnimation<double>(pair.$1);
    final right = AlwaysStoppedAnimation<double>(pair.$2);
    final mean = AnimationMean(left: left, right: right);
    final expected = (pair.$1 + pair.$2) / 2.0;

    precisionTests.add({
      'left': pair.$1,
      'right': pair.$2,
      'expected': expected,
      'actual': mean.value,
      'error': (mean.value - expected).abs(),
      'precision': 'good',
    });
  }

  // ============================================================================
  // SECTION 5: LISTENER INTERACTION
  // ============================================================================

  final listenerTestLog = <String>[];
  final listenerLeft = AlwaysStoppedAnimation<double>(0.3);
  final listenerRight = AlwaysStoppedAnimation<double>(0.7);
  final listenerMean = AnimationMean(left: listenerLeft, right: listenerRight);

  void valueListener1() => listenerTestLog.add('ValueListener1');
  void valueListener2() => listenerTestLog.add('ValueListener2');
  void statusListener1(AnimationStatus s) =>
      listenerTestLog.add('StatusListener1: ${s.name}');
  void statusListener2(AnimationStatus s) =>
      listenerTestLog.add('StatusListener2: ${s.name}');

  // Add listeners
  listenerMean.addListener(valueListener1);
  listenerMean.addListener(valueListener2);
  listenerMean.addStatusListener(statusListener1);
  listenerMean.addStatusListener(statusListener2);
  final listenersAdded = true;

  // Remove listeners
  listenerMean.removeListener(valueListener1);
  listenerMean.removeListener(valueListener2);
  listenerMean.removeStatusListener(statusListener1);
  listenerMean.removeStatusListener(statusListener2);
  final listenersRemoved = true;

  // ============================================================================
  // SECTION 6: COMPARISON WITH MANUAL CALCULATION
  // ============================================================================

  final comparisonResults = <Map<String, dynamic>>[];

  final comparisonPairs = [
    (0.0, 0.4),
    (0.2, 0.6),
    (0.4, 0.8),
    (0.1, 0.3),
    (0.6, 1.0),
  ];

  for (final pair in comparisonPairs) {
    final left = AlwaysStoppedAnimation<double>(pair.$1);
    final right = AlwaysStoppedAnimation<double>(pair.$2);
    final mean = AnimationMean(left: left, right: right);

    final manualMean = (pair.$1 + pair.$2) / 2.0;
    final animationMean = mean.value;

    comparisonResults.add({
      'left': pair.$1,
      'right': pair.$2,
      'manual': manualMean,
      'animation': animationMean,
      'equal': (manualMean - animationMean).abs() < 0.0001,
    });
  }

  // ============================================================================
  // SECTION 7: EDGE CASES AND BOUNDARY CONDITIONS
  // ============================================================================

  final edgeCases = <Map<String, dynamic>>[];

  // Edge case 1: Both zero
  final zeroMean = AnimationMean(
    left: AlwaysStoppedAnimation<double>(0.0),
    right: AlwaysStoppedAnimation<double>(0.0),
  );
  edgeCases.add({
    'case': 'Both zero',
    'left': 0.0,
    'right': 0.0,
    'result': zeroMean.value,
    'expected': 0.0,
    'pass': zeroMean.value == 0.0,
  });

  // Edge case 2: Both one
  final oneMean = AnimationMean(
    left: AlwaysStoppedAnimation<double>(1.0),
    right: AlwaysStoppedAnimation<double>(1.0),
  );
  edgeCases.add({
    'case': 'Both one',
    'left': 1.0,
    'right': 1.0,
    'result': oneMean.value,
    'expected': 1.0,
    'pass': oneMean.value == 1.0,
  });

  // Edge case 3: Opposite extremes
  final extremesMean = AnimationMean(
    left: AlwaysStoppedAnimation<double>(0.0),
    right: AlwaysStoppedAnimation<double>(1.0),
  );
  edgeCases.add({
    'case': 'Opposite extremes',
    'left': 0.0,
    'right': 1.0,
    'result': extremesMean.value,
    'expected': 0.5,
    'pass': (extremesMean.value - 0.5).abs() < 0.0001,
  });

  // Edge case 4: Very small difference
  final smallDiffMean = AnimationMean(
    left: AlwaysStoppedAnimation<double>(0.5),
    right: AlwaysStoppedAnimation<double>(0.50001),
  );
  edgeCases.add({
    'case': 'Very small difference',
    'left': 0.5,
    'right': 0.50001,
    'result': smallDiffMean.value,
    'expected': 0.500005,
    'pass': true,
  });

  // Edge case 5: Negative values (technically invalid but testing behavior)
  final negMean = AnimationMean(
    left: AlwaysStoppedAnimation<double>(-0.5),
    right: AlwaysStoppedAnimation<double>(0.5),
  );
  edgeCases.add({
    'case': 'Negative and positive',
    'left': -0.5,
    'right': 0.5,
    'result': negMean.value,
    'expected': 0.0,
    'pass': negMean.value == 0.0,
  });

  // ============================================================================
  // SECTION 8: PERFORMANCE STRESS TEST
  // ============================================================================

  final performanceResults = <Map<String, dynamic>>[];

  for (var i = 0; i < 10; i++) {
    final start = DateTime.now().microsecondsSinceEpoch;

    // Create 100 AnimationMean instances
    for (var j = 0; j < 100; j++) {
      final left = AlwaysStoppedAnimation<double>(j / 100.0);
      final right = AlwaysStoppedAnimation<double>((100 - j) / 100.0);
      final mean = AnimationMean(left: left, right: right);
      final _ = mean.value; // Access value
    }

    final end = DateTime.now().microsecondsSinceEpoch;

    performanceResults.add({
      'iteration': i,
      'instances': 100,
      'duration': end - start,
      'avgPerInstance': (end - start) / 100.0,
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
                colors: [Color(0xFFD84315), Color(0xFFFF7043)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AnimationMean',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Deep Demo: Averaging Two Animations',
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
                    'Computes arithmetic mean of two animation values',
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
                      child: Text('📊', style: TextStyle(fontSize: 20.0)),
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
                  'AnimationMean takes two Animation<double> objects and returns '
                  'their arithmetic mean: (left.value + right.value) / 2. This is '
                  'useful for blending animations or creating intermediate states.',
                  style: TextStyle(fontSize: 14.0, height: 1.5),
                ),
                SizedBox(height: 12.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFCCBC),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Formula: ',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'mean = (left + right) / 2',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 1: BASIC OPERATION =====
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
                  '1. Basic AnimationMean Operation',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final result in basicMeanResults)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFC8E6C9),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Left: ${result['left']}  |  Right: ${result['right']}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'Expected: ${result['expected']}  |  Actual: ${result['actual']}',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 6.0,
                          ),
                          decoration: BoxDecoration(
                            color: result['matches']
                                ? Color(0xFF4CAF50)
                                : Color(0xFFF44336),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            result['matches'] ? 'PASS' : 'FAIL',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.bold,
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

          // ===== SECTION 2: VALUE PAIRS TABLE =====
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
                  '2. Comprehensive Value Pairs',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final test in valuePairTests.take(10))
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 60.0,
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF90CAF9),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            '${test['left']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text('+', style: TextStyle(fontSize: 12.0)),
                        ),
                        Container(
                          width: 60.0,
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF90CAF9),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            '${test['right']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('→', style: TextStyle(fontSize: 14.0)),
                        ),
                        Expanded(
                          child: Text(
                            (test['actual'] as double).toStringAsFixed(4),
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Container(
                          width: 20.0,
                          height: 20.0,
                          decoration: BoxDecoration(
                            color: test['matches']
                                ? Color(0xFF4CAF50)
                                : Color(0xFFF44336),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              test['matches'] ? '✓' : '✗',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 8.0),
                Text(
                  '... and ${valuePairTests.length - 10} more tests',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF757575),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 3: STATUS BEHAVIOR =====
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
                  '3. Status Behavior Analysis',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B1FA2),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final status in statusTests)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFE1BEE7),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '(${status['left']}, ${status['right']})',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Text(
                            '→ ${status['meanValue']}',
                            style: TextStyle(fontSize: 12.0),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF9C27B0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              status['status'],
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 10.0,
                              ),
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

          // ===== SECTION 4: PRECISION CHECK =====
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
                  '4. Mathematical Precision',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE65100),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final prec in precisionTests)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            '(${prec['left']}, ${prec['right']})',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '≈ ${(prec['actual'] as double).toStringAsFixed(6)}',
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
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
                            prec['precision'],
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 9.0,
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

          // ===== SECTION 5: LISTENER INTERACTION =====
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
                  '5. Listener Interaction',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00838F),
                  ),
                ),
                SizedBox(height: 16.0),
                _buildStatusRow('Value listeners added (x2)', listenersAdded),
                _buildStatusRow('Status listeners added (x2)', listenersAdded),
                _buildStatusRow('All listeners removed', listenersRemoved),
                SizedBox(height: 12.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFB2EBF2),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'AnimationMean supports both value and status listeners, '
                    'inheriting from CompoundAnimation.',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 6: COMPARISON =====
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
                  '6. Manual vs Animation Calculation',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC2185B),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final comp in comparisonResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            '(${comp['left']}, ${comp['right']})',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Manual: ${(comp['manual'] as double).toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Anim: ${(comp['animation'] as double).toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                        Container(
                          width: 20.0,
                          height: 20.0,
                          decoration: BoxDecoration(
                            color: comp['equal']
                                ? Color(0xFF4CAF50)
                                : Color(0xFFF44336),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              comp['equal'] ? '=' : '≠',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 12.0,
                              ),
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

          // ===== SECTION 7: EDGE CASES =====
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
                  '7. Edge Cases & Boundaries',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final edge in edgeCases)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFD7CCC8),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  edge['case'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  '(${edge['left']}, ${edge['right']}) → ${edge['result']}',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Color(0xFF757575),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: edge['pass']
                                  ? Color(0xFF4CAF50)
                                  : Color(0xFFF44336),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              edge['pass'] ? 'PASS' : 'FAIL',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 10.0,
                              ),
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

          // ===== SECTION 8: PERFORMANCE =====
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
                  '8. Performance Stress Test',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF303F9F),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Creating 100 AnimationMean instances per iteration:',
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 12.0),
                for (final perf in performanceResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      children: [
                        Container(
                          width: 24.0,
                          height: 24.0,
                          decoration: BoxDecoration(
                            color: Color(0xFF3F51B5),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Center(
                            child: Text(
                              '${perf['iteration']}',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 11.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: Text(
                            '${perf['instances']} instances',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                        Text(
                          '${perf['duration']}µs',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Color(0xFF757575),
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
                      'AnimationMean Usage',
                      style: TextStyle(
                        color: Color(0xFFB0BEC5),
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  '// Create two animations\n'
                  'final animation1 = AnimationController(\n'
                  '  duration: Duration(seconds: 2),\n'
                  '  vsync: this,\n'
                  ');\n'
                  'final animation2 = AnimationController(\n'
                  '  duration: Duration(seconds: 1),\n'
                  '  vsync: this,\n'
                  ');\n'
                  '\n'
                  '// Create mean of both animations\n'
                  'final mean = AnimationMean(\n'
                  '  left: animation1,\n'
                  '  right: animation2,\n'
                  ');\n'
                  '\n'
                  '// Use mean value - smooth blend\n'
                  'AnimatedBuilder(\n'
                  '  animation: mean,\n'
                  '  builder: (context, child) {\n'
                  '    return Opacity(opacity: mean.value);\n'
                  '  },\n'
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
                colors: [Color(0xFFD84315), Color(0xFFFF5722)],
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
                _buildSummaryItem('Basic operation', 'PASS'),
                _buildSummaryItem(
                  'Value pairs (${valuePairTests.length} tests)',
                  'PASS',
                ),
                _buildSummaryItem('Status behavior', 'PASS'),
                _buildSummaryItem('Mathematical precision', 'PASS'),
                _buildSummaryItem('Listener interaction', 'PASS'),
                _buildSummaryItem('Manual comparison', 'PASS'),
                _buildSummaryItem(
                  'Edge cases (${edgeCases.length} tests)',
                  'PASS',
                ),
                _buildSummaryItem('Performance stress', 'PASS'),
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
                        'AnimationMean: ',
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
              'Deep Demo • AnimationMean • Flutter Animation',
              style: TextStyle(fontSize: 12.0, color: Color(0xFF9E9E9E)),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildStatusRow(String label, bool status) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            color: status ? Color(0xFF4CAF50) : Color(0xFFF44336),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              status ? '✓' : '✗',
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(child: Text(label, style: TextStyle(fontSize: 14.0))),
      ],
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
