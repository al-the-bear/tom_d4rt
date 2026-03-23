// ignore_for_file: avoid_print
// D4rt test script: Tests AnimationStyle from animation
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimationStyle test executing');

  // ========== ANIMATIONSTYLE ==========
  print('--- AnimationStyle Tests ---');

  // Create AnimationStyle with duration and curve
  final style1 = AnimationStyle(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );
  print('AnimationStyle(duration=300ms, curve=easeInOut):');
  print('  duration: ${style1.duration}');
  print('  curve: ${style1.curve}');
  print('  reverseDuration: ${style1.reverseDuration}');
  print('  reverseCurve: ${style1.reverseCurve}');

  // Create AnimationStyle with all parameters
  final style2 = AnimationStyle(
    duration: Duration(milliseconds: 500),
    reverseDuration: Duration(milliseconds: 250),
    curve: Curves.easeIn,
    reverseCurve: Curves.easeOut,
  );
  print(
    'AnimationStyle(duration=500ms, reverseDuration=250ms, curve=easeIn, reverseCurve=easeOut):',
  );
  print('  duration: ${style2.duration}');
  print('  reverseDuration: ${style2.reverseDuration}');
  print('  curve: ${style2.curve}');
  print('  reverseCurve: ${style2.reverseCurve}');

  // Create AnimationStyle with only duration
  final style3 = AnimationStyle(duration: Duration(milliseconds: 200));
  print('AnimationStyle(duration=200ms):');
  print('  duration: ${style3.duration}');
  print('  curve: ${style3.curve}');

  // Create AnimationStyle with only curve
  final style4 = AnimationStyle(curve: Curves.bounceOut);
  print('AnimationStyle(curve=bounceOut):');
  print('  duration: ${style4.duration}');
  print('  curve: ${style4.curve}');

  // AnimationStyle.noAnimation
  final noAnim = AnimationStyle.noAnimation;
  print('AnimationStyle.noAnimation:');
  print('  duration: ${noAnim.duration}');
  print('  curve: ${noAnim.curve}');

  // Test different duration values
  final shortStyle = AnimationStyle(
    duration: Duration(milliseconds: 100),
    curve: Curves.linear,
  );
  print('Short style (100ms): duration=${shortStyle.duration}');

  final longStyle = AnimationStyle(
    duration: Duration(seconds: 2),
    curve: Curves.fastOutSlowIn,
  );
  print('Long style (2s): duration=${longStyle.duration}');

  // Test with various curves
  final curveStyles = [
    ('linear', Curves.linear),
    ('ease', Curves.ease),
    ('easeIn', Curves.easeIn),
    ('easeOut', Curves.easeOut),
    ('bounceIn', Curves.bounceIn),
    ('elasticOut', Curves.elasticOut),
  ];

  for (final entry in curveStyles) {
    final name = entry.$1;
    final curve = entry.$2;
    final s = AnimationStyle(
      duration: Duration(milliseconds: 300),
      curve: curve,
    );
    print('AnimationStyle with $name: curve=${s.curve}');
  }

  // ========== USE IN WIDGET ==========
  print('--- AnimationStyle in Widget ---');

  // AnimationStyle can be used with AnimatedContainer and similar widgets
  print('Building widget tree with AnimationStyle');

  return Container(
    padding: EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AnimationStyle Test Results',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
          ),
          SizedBox(height: 16.0),
          // Show different animation styles visually
          Text(
            'Duration: 300ms, Curve: easeInOut',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 8.0),
          AnimatedContainer(
            duration: style1.duration ?? Duration(milliseconds: 300),
            curve: style1.curve ?? Curves.linear,
            width: 200.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: Color(0xFF2196F3),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                'Style 1',
                style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0),
              ),
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'Duration: 500ms, Curve: easeIn',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 8.0),
          AnimatedContainer(
            duration: style2.duration ?? Duration(milliseconds: 500),
            curve: style2.curve ?? Curves.linear,
            width: 250.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                'Style 2',
                style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0),
              ),
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'Duration: 200ms (default curve)',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 8.0),
          AnimatedContainer(
            duration: style3.duration ?? Duration(milliseconds: 200),
            curve: style3.curve ?? Curves.linear,
            width: 150.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: Color(0xFFFF9800),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                'Style 3',
                style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFF5F5F5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AnimationStyle Summary:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                ),
                SizedBox(height: 4.0),
                Text(
                  '• Controls duration and curve of animations',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• Can specify reverse duration/curve separately',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• AnimationStyle.noAnimation disables animation',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• Used with AnimatedContainer, ExpansionTile, etc.',
                  style: TextStyle(fontSize: 11.0),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
