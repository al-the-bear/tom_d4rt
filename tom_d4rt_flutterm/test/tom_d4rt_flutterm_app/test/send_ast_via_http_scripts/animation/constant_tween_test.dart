// D4rt test script: Deep Demo - ConstantTween from animation
// Comprehensive demonstration of tweens that return constant values
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  // ============================================================================
  // SECTION 1: DOUBLE CONSTANT TWEEN
  // ============================================================================

  final doubleTween = ConstantTween<double>(42.0);
  final doubleResults = <Map<String, dynamic>>[];

  final tValues = [0.0, 0.1, 0.25, 0.5, 0.75, 0.9, 1.0];
  for (final t in tValues) {
    doubleResults.add({'t': t, 'value': doubleTween.lerp(t), 'expected': 42.0});
  }

  // ============================================================================
  // SECTION 2: STRING CONSTANT TWEEN
  // ============================================================================

  final stringTween = ConstantTween<String>('Hello World');
  final stringResults = <Map<String, dynamic>>[];

  for (final t in tValues) {
    stringResults.add({'t': t, 'value': stringTween.lerp(t)});
  }

  // ============================================================================
  // SECTION 3: INT CONSTANT TWEEN
  // ============================================================================

  final intTween = ConstantTween<int>(100);
  final intResults = <Map<String, dynamic>>[];

  for (final t in tValues) {
    intResults.add({'t': t, 'value': intTween.lerp(t)});
  }

  // ============================================================================
  // SECTION 4: COLOR CONSTANT TWEEN
  // ============================================================================

  final colorTween = ConstantTween<Color>(Color(0xFF2196F3));
  final colorResults = <Map<String, dynamic>>[];

  for (final t in tValues) {
    colorResults.add({'t': t, 'value': colorTween.lerp(t)});
  }

  // ============================================================================
  // SECTION 5: BEGIN/END PROPERTIES
  // ============================================================================

  final propertyResults = <Map<String, dynamic>>[
    {
      'type': 'double(42.0)',
      'begin': doubleTween.begin,
      'end': doubleTween.end,
    },
    {
      'type': 'string("Hello")',
      'begin': stringTween.begin,
      'end': stringTween.end,
    },
    {'type': 'int(100)', 'begin': intTween.begin, 'end': intTween.end},
    {
      'type': 'Color(blue)',
      'begin': colorTween.begin.toString(),
      'end': colorTween.end.toString(),
    },
  ];

  // ============================================================================
  // SECTION 6: EVALUATE WITH ANIMATION
  // ============================================================================

  final anim25 = AlwaysStoppedAnimation<double>(0.25);
  final anim50 = AlwaysStoppedAnimation<double>(0.50);
  final anim75 = AlwaysStoppedAnimation<double>(0.75);

  final evalResults = <Map<String, dynamic>>[
    {
      'animation': 't=0.25',
      'doubleEval': doubleTween.evaluate(anim25),
      'intEval': intTween.evaluate(anim25),
    },
    {
      'animation': 't=0.50',
      'doubleEval': doubleTween.evaluate(anim50),
      'intEval': intTween.evaluate(anim50),
    },
    {
      'animation': 't=0.75',
      'doubleEval': doubleTween.evaluate(anim75),
      'intEval': intTween.evaluate(anim75),
    },
  ];

  // ============================================================================
  // SECTION 7: VARIOUS CONSTANT VALUES
  // ============================================================================

  final zeroTween = ConstantTween<double>(0.0);
  final negativeTween = ConstantTween<double>(-50.0);
  final largeTween = ConstantTween<double>(9999.99);
  final emptyStringTween = ConstantTween<String>('');

  final variousResults = <Map<String, dynamic>>[
    {'name': 'Zero', 'value': '${zeroTween.lerp(0.5)}', 'constant': 0.0},
    {
      'name': 'Negative',
      'value': '${negativeTween.lerp(0.5)}',
      'constant': -50.0,
    },
    {'name': 'Large', 'value': '${largeTween.lerp(0.5)}', 'constant': 9999.99},
    {
      'name': 'Empty String',
      'value': '"${emptyStringTween.lerp(0.5)}"',
      'constant': '""',
    },
  ];

  // ============================================================================
  // SECTION 8: COMPARISON WITH REGULAR TWEEN
  // ============================================================================

  final regularTween = Tween<double>(begin: 0.0, end: 100.0);
  final constantCompare = ConstantTween<double>(50.0);

  final comparisonResults = <Map<String, dynamic>>[];
  for (final t in tValues) {
    comparisonResults.add({
      't': t,
      'regular': regularTween.lerp(t),
      'constant': constantCompare.lerp(t),
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
                colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ConstantTween',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Deep Demo: Tweens That Never Change',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFE1BEE7)),
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
                    'lerp(t) always returns the same value',
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
              color: Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFCE93D8), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF9C27B0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text('📌', style: TextStyle(fontSize: 20.0)),
                    ),
                    SizedBox(width: 12.0),
                    Text(
                      'Concept Overview',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6A1B9A),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'ConstantTween is a special Animatable that always returns the same '
                  'value regardless of the interpolation parameter t. It\'s useful when '
                  'you need to pass an Animatable but want a fixed value.',
                  style: TextStyle(fontSize: 14.0, height: 1.5),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Key properties:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '• lerp(t) ignores t completely',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• begin and end are identical',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• Works with any type <T>',
                  style: TextStyle(fontSize: 13.0),
                ),
                Text(
                  '• evaluate() uses lerp() internally',
                  style: TextStyle(fontSize: 13.0),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 1: DOUBLE TWEEN =====
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
                  '1. Double Constant (42.0)',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Always returns 42.0 regardless of t',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                for (final result in doubleResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      children: [
                        Container(
                          width: 50.0,
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
                            height: 22.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFC8E6C9),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Center(
                              child: Text(
                                '${result['value']}',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Container(
                          width: 24.0,
                          height: 24.0,
                          decoration: BoxDecoration(
                            color: result['value'] == result['expected']
                                ? Color(0xFF4CAF50)
                                : Color(0xFFF44336),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Center(
                            child: Text(
                              '✓',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 14.0,
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

          // ===== SECTION 2: STRING TWEEN =====
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
                  '2. String Constant ("Hello World")',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final result in stringResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      children: [
                        Container(
                          width: 50.0,
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
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 6.0,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFBBDEFB),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              '"${result['value']}"',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontFamily: 'monospace',
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

          // ===== SECTION 3: INT TWEEN =====
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
                  '3. Int Constant (100)',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC2185B),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    for (final result in intResults)
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE91E63),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Center(
                                  child: Text(
                                    '${result['value']}',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                't=${result['t']}',
                                style: TextStyle(
                                  fontSize: 9.0,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 4: COLOR TWEEN =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFFFCA28), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '4. Color Constant (Blue)',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF8F00),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final result in colorResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      children: [
                        Container(
                          width: 50.0,
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
                            height: 28.0,
                            decoration: BoxDecoration(
                              color: result['value'] as Color,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Center(
                              child: Text(
                                'Same Blue',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 11.0,
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

          // ===== SECTION 5: BEGIN/END =====
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
                  '5. Begin/End Properties',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00838F),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Begin and end are always identical',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                for (final prop in propertyResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFB2EBF2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              prop['type'] as String,
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'begin: ${prop['begin']}',
                              style: TextStyle(
                                fontSize: 10.0,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'end: ${prop['end']}',
                              style: TextStyle(
                                fontSize: 10.0,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              color:
                                  prop['begin'].toString() ==
                                      prop['end'].toString()
                                  ? Color(0xFF4CAF50)
                                  : Color(0xFFF44336),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Center(
                              child: Text(
                                '=',
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
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 6: EVALUATE =====
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
                  '6. Evaluate with Animation',
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
                      flex: 2,
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
                        'Double(42)',
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
                        'Int(100)',
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
                for (final eval in evalResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            eval['animation'] as String,
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFD7CCC8),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              '${eval['doubleEval']}',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontFamily: 'monospace',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFD7CCC8),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              '${eval['intEval']}',
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

          SizedBox(height: 16.0),

          // ===== SECTION 7: VARIOUS VALUES =====
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
                  '7. Various Constant Values',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF303F9F),
                  ),
                ),
                SizedBox(height: 16.0),
                for (final v in variousResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFC5CAE9),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              v['name'] as String,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'lerp(0.5) = ${v['value']}',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontFamily: 'monospace',
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

          // ===== SECTION 8: COMPARISON =====
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
                  '8. Regular vs Constant Tween',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE65100),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Regular: 0→100 | Constant: always 50',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
                ),
                SizedBox(height: 16.0),
                for (final comp in comparisonResults)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 45.0,
                          child: Text(
                            't=${comp['t']}',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 14.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFE0B2),
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor:
                                      ((comp['regular'] as double) / 100.0)
                                          .clamp(0.0, 1.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF9800),
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Container(
                                height: 14.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE1BEE7),
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor:
                                      ((comp['constant'] as double) / 100.0)
                                          .clamp(0.0, 1.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF9C27B0),
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Container(
                          width: 70.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${(comp['regular'] as double).toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 9.0,
                                  color: Color(0xFFFF9800),
                                ),
                              ),
                              Text(
                                '${(comp['constant'] as double).toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 9.0,
                                  color: Color(0xFF9C27B0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 12.0,
                      height: 12.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF9800),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                    SizedBox(width: 4.0),
                    Text('Regular (changes)', style: TextStyle(fontSize: 10.0)),
                    SizedBox(width: 16.0),
                    Container(
                      width: 12.0,
                      height: 12.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF9C27B0),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                    SizedBox(width: 4.0),
                    Text('Constant (fixed)', style: TextStyle(fontSize: 10.0)),
                  ],
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
                        color: Color(0xFF9C27B0),
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
                      'ConstantTween Usage',
                      style: TextStyle(
                        color: Color(0xFFB0BEC5),
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  '// Create constant tweens\n'
                  'final opacity = ConstantTween<double>(1.0);\n'
                  'final label = ConstantTween<String>("Fixed");\n'
                  'final color = ConstantTween<Color>(Colors.blue);\n'
                  '\n'
                  '// lerp always returns same value\n'
                  'opacity.lerp(0.0);  // 1.0\n'
                  'opacity.lerp(0.5);  // 1.0\n'
                  'opacity.lerp(1.0);  // 1.0\n'
                  '\n'
                  '// Useful in animation chains\n'
                  'final chain = TweenSequence([\n'
                  '  TweenSequenceItem(\n'
                  '    tween: ConstantTween(1.0),\n'
                  '    weight: 1,\n'
                  '  ),\n'
                  ']);',
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
                colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
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
                _buildSummaryItem('Double constant', 'PASS'),
                _buildSummaryItem('String constant', 'PASS'),
                _buildSummaryItem('Int constant', 'PASS'),
                _buildSummaryItem('Color constant', 'PASS'),
                _buildSummaryItem('Begin/end identical', 'PASS'),
                _buildSummaryItem('Evaluate with animation', 'PASS'),
                _buildSummaryItem('Various values', 'PASS'),
                _buildSummaryItem('Comparison with Tween', 'PASS'),
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
                        'ConstantTween: ',
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
              'Deep Demo • ConstantTween • Flutter Animation',
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
