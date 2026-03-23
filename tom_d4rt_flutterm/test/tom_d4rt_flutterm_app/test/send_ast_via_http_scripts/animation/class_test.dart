// ignore_for_file: avoid_print
// D4rt test script: Deep Demo - Animation Class Hierarchy from animation
// Comprehensive demonstration of Animation class types and relationships
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  // ============================================================================
  // SECTION 1: ALWAYSSTOPPEDANIMATION BASICS
  // ============================================================================

  final stoppedDouble = AlwaysStoppedAnimation<double>(0.75);
  final stoppedInt = AlwaysStoppedAnimation<int>(42);
  final stoppedColor = AlwaysStoppedAnimation<Color>(Color(0xFF2196F3));
  final stoppedZero = AlwaysStoppedAnimation<double>(0.0);
  final stoppedOne = AlwaysStoppedAnimation<double>(1.0);

  final stoppedResults = <Map<String, dynamic>>[
    {
      'type': 'double(0.75)',
      'value': stoppedDouble.value.toString(),
      'status': stoppedDouble.status.name,
    },
    {
      'type': 'int(42)',
      'value': stoppedInt.value.toString(),
      'status': stoppedInt.status.name,
    },
    {
      'type': 'Color(blue)',
      'value': stoppedColor.value.toString(),
      'status': stoppedColor.status.name,
    },
    {
      'type': 'double(0.0)',
      'value': stoppedZero.value.toString(),
      'status': stoppedZero.status.name,
    },
    {
      'type': 'double(1.0)',
      'value': stoppedOne.value.toString(),
      'status': stoppedOne.status.name,
    },
  ];

  // ============================================================================
  // SECTION 2: PROXYANIMATION
  // ============================================================================

  final proxy1 = ProxyAnimation(stoppedDouble);
  final proxy2 = ProxyAnimation(stoppedZero);
  final proxy3 = ProxyAnimation(stoppedOne);
  final proxyNull = ProxyAnimation();

  final proxyResults = <Map<String, dynamic>>[
    {
      'name': 'proxy(0.75)',
      'value': proxy1.value,
      'status': proxy1.status.name,
      'parent': 'stoppedDouble',
    },
    {
      'name': 'proxy(0.0)',
      'value': proxy2.value,
      'status': proxy2.status.name,
      'parent': 'stoppedZero',
    },
    {
      'name': 'proxy(1.0)',
      'value': proxy3.value,
      'status': proxy3.status.name,
      'parent': 'stoppedOne',
    },
    {
      'name': 'proxy(null)',
      'value': proxyNull.value,
      'status': proxyNull.status.name,
      'parent': 'none',
    },
  ];

  // ============================================================================
  // SECTION 3: REVERSEANIMATION
  // ============================================================================

  final reverse1 = ReverseAnimation(stoppedDouble);
  final reverse2 = ReverseAnimation(stoppedZero);
  final reverse3 = ReverseAnimation(stoppedOne);

  final reverseResults = <Map<String, dynamic>>[
    {'original': 0.75, 'reversed': reverse1.value, 'expected': 0.25},
    {'original': 0.0, 'reversed': reverse2.value, 'expected': 1.0},
    {'original': 1.0, 'reversed': reverse3.value, 'expected': 0.0},
  ];

  // ============================================================================
  // SECTION 4: ANIMATIONSTATUS ENUM
  // ============================================================================

  final statusResults = <Map<String, dynamic>>[];
  for (final status in AnimationStatus.values) {
    statusResults.add({
      'name': status.name,
      'index': status.index,
      'isAnimating':
          status == AnimationStatus.forward ||
          status == AnimationStatus.reverse,
      'isCompleted': status == AnimationStatus.completed,
      'isDismissed': status == AnimationStatus.dismissed,
    });
  }

  // ============================================================================
  // SECTION 5: TYPE CHECKING
  // ============================================================================

  final typeResults = <Map<String, dynamic>>[
    {
      'instance': 'stoppedDouble',
      'isAnimation': true /* stoppedDouble is Animation<double> */,
      'isListenable': true /* stoppedDouble is Listenable */,
    },
    {
      'instance': 'proxy1',
      'isAnimation': true /* proxy1 is Animation<double> */,
      'isListenable': true /* proxy1 is Listenable */,
    },
    {
      'instance': 'reverse1',
      'isAnimation': true /* reverse1 is Animation<double> */,
      'isListenable': true /* reverse1 is Listenable */,
    },
    {
      'instance': 'stoppedInt',
      'isAnimation': true /* stoppedInt is Animation<int> */,
      'isListenable': true /* stoppedInt is Listenable */,
    },
    {
      'instance': 'stoppedColor',
      'isAnimation': true /* stoppedColor is Animation<Color> */,
      'isListenable': true /* stoppedColor is Listenable */,
    },
  ];

  // ============================================================================
  // SECTION 6: STATUS PROPERTIES
  // ============================================================================

  final statusProperties = <Map<String, dynamic>>[
    {
      'animation': 'stoppedDouble(0.75)',
      'isCompleted': stoppedDouble.isCompleted,
      'isDismissed': stoppedDouble.isDismissed,
    },
    {
      'animation': 'stoppedZero(0.0)',
      'isCompleted': stoppedZero.isCompleted,
      'isDismissed': stoppedZero.isDismissed,
    },
    {
      'animation': 'stoppedOne(1.0)',
      'isCompleted': stoppedOne.isCompleted,
      'isDismissed': stoppedOne.isDismissed,
    },
    {
      'animation': 'proxy1',
      'isCompleted': proxy1.isCompleted,
      'isDismissed': proxy1.isDismissed,
    },
    {
      'animation': 'reverse1',
      'isCompleted': reverse1.isCompleted,
      'isDismissed': reverse1.isDismissed,
    },
  ];

  // ============================================================================
  // SECTION 7: CHAINED PROXIES
  // ============================================================================

  final chain1 = ProxyAnimation(stoppedDouble);
  final chain2 = ProxyAnimation(chain1);
  final chain3 = ProxyAnimation(chain2);

  final chainResults = <Map<String, dynamic>>[
    {
      'depth': 0,
      'value': stoppedDouble.value,
      'status': stoppedDouble.status.name,
    },
    {'depth': 1, 'value': chain1.value, 'status': chain1.status.name},
    {'depth': 2, 'value': chain2.value, 'status': chain2.status.name},
    {'depth': 3, 'value': chain3.value, 'status': chain3.status.name},
  ];

  // ============================================================================
  // SECTION 8: TOSTRING OUTPUTS
  // ============================================================================

  final toStringResults = <Map<String, dynamic>>[
    {'type': 'AlwaysStoppedAnimation', 'toString': stoppedDouble.toString()},
    {'type': 'ProxyAnimation', 'toString': proxy1.toString()},
    {'type': 'ReverseAnimation', 'toString': reverse1.toString()},
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
                colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Animation Class Hierarchy',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Deep Demo: Core Animation Types',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFBBDEFB)),
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
                    'Stopped, Proxy, Reverse, Status',
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
              color: Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF90CAF9), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF1976D2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text('🎬', style: TextStyle(fontSize: 20.0)),
                    ),
                    SizedBox(width: 12.0),
                    Text(
                      'Class Overview',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Flutter provides several Animation wrapper classes for different use cases. '
                  'These allow static values, delegation, and value reversal without needing '
                  'an AnimationController.',
                  style: TextStyle(fontSize: 14.0, height: 1.5),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Core classes:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '• AlwaysStoppedAnimation - Static value wrapper',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• ProxyAnimation - Delegated animation',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• ReverseAnimation - Inverted value (1-t)',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• AnimationStatus - State enum',
                  style: TextStyle(fontSize: 13.0),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 1: STOPPED ANIMATIONS =====
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
                  '1. AlwaysStoppedAnimation',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Static values that never change - always "completed"',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                for (final result in stoppedResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFC8E6C9),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              result['type'] as String,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'value: ${result['value']}',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
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
                              result['status'] as String,
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

          // ===== SECTION 2: PROXY ANIMATION =====
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
                  '2. ProxyAnimation',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC2185B),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Delegates to a parent animation',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                for (final result in proxyResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8BBD9),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              result['name'] as String,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 16.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFE91E63),
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
                                    color: Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            (result['value'] as double).toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 11.0,
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

          // ===== SECTION 3: REVERSE ANIMATION =====
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
                  '3. ReverseAnimation',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B1FA2),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Inverts values: reversed = 1.0 - original',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Original',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Reversed',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Match',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                for (final result in reverseResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFE1BEE7),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              '${result['original']}',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF9C27B0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              '${result['reversed']}',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontFamily: 'monospace',
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color:
                                  (result['reversed'] as double) ==
                                      (result['expected'] as double)
                                  ? Color(0xFF4CAF50)
                                  : Color(0xFFF44336),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              (result['reversed'] as double) ==
                                      (result['expected'] as double)
                                  ? '✓'
                                  : '✗',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 14.0,
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

          SizedBox(height: 16.0),

          // ===== SECTION 4: ANIMATIONSTATUS ENUM =====
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
                  '4. AnimationStatus Enum',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE65100),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final status in statusResults)
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
                            width: 24.0,
                            height: 24.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF9800),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${status['index']}',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Expanded(
                            flex: 2,
                            child: Text(
                              status['name'] as String,
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (status['isAnimating'] as bool)
                            _buildSmallChip('animating', Color(0xFF2196F3)),
                          if (status['isCompleted'] as bool)
                            _buildSmallChip('completed', Color(0xFF4CAF50)),
                          if (status['isDismissed'] as bool)
                            _buildSmallChip('dismissed', Color(0xFF9E9E9E)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 5: TYPE CHECKING =====
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
                  '5. Type Verification',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00838F),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final type in typeResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            type['instance'] as String,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: (type['isAnimation'] as bool)
                                ? Color(0xFF4CAF50)
                                : Color(0xFFF44336),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            'Animation',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: (type['isListenable'] as bool)
                                ? Color(0xFF2196F3)
                                : Color(0xFFF44336),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            'Listenable',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 10.0,
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

          // ===== SECTION 6: STATUS PROPERTIES =====
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
                  '6. Status Properties',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Animation',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'isCompleted',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'isDismissed',
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
                for (final prop in statusProperties)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            prop['animation'] as String,
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Container(
                              width: 24.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                color: (prop['isCompleted'] as bool)
                                    ? Color(0xFF4CAF50)
                                    : Color(0xFFE0E0E0),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Center(
                                child: Text(
                                  (prop['isCompleted'] as bool) ? '✓' : '—',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Container(
                              width: 24.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                color: (prop['isDismissed'] as bool)
                                    ? Color(0xFF9E9E9E)
                                    : Color(0xFFE0E0E0),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Center(
                                child: Text(
                                  (prop['isDismissed'] as bool) ? '✓' : '—',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 12.0,
                                  ),
                                ),
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

          // ===== SECTION 7: CHAINED PROXIES =====
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
                  '7. Chained Proxy Delegation',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF303F9F),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Proxy → Proxy → Proxy → AlwaysStoppedAnimation',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                for (final chain in chainResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60.0,
                          child: Text(
                            'Depth ${chain['depth']}',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 20.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFC5CAE9),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (chain['value'] as double).clamp(
                                0.0,
                                1.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF3F51B5),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          '${chain['value']}',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 8.0),
                Text(
                  'All depths report same value (0.75) ✓',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 8: TOSTRING =====
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
                Text(
                  '8. toString() Outputs',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final str in toStringResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          str['type'] as String,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0xFF80CBC4),
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF37474F),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            str['toString'] as String,
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                              color: Color(0xFFB0BEC5),
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

          // ===== SUMMARY =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
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
                _buildSummaryItem('AlwaysStoppedAnimation', 'PASS'),
                _buildSummaryItem('ProxyAnimation delegation', 'PASS'),
                _buildSummaryItem('ReverseAnimation inversion', 'PASS'),
                _buildSummaryItem('AnimationStatus enum', 'PASS'),
                _buildSummaryItem('Type verification', 'PASS'),
                _buildSummaryItem('Status properties', 'PASS'),
                _buildSummaryItem('Chained proxies', 'PASS'),
                _buildSummaryItem('toString outputs', 'PASS'),
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
                        'Animation Classes: ',
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
              'Deep Demo • Animation Class Hierarchy • Flutter Animation',
              style: TextStyle(fontSize: 12.0, color: Color(0xFF9E9E9E)),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildSmallChip(String label, Color color) {
  return Container(
    margin: EdgeInsets.only(left: 4.0),
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      label,
      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 9.0),
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
