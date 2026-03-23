// ignore_for_file: avoid_print
// D4rt test script: Tests AlwaysStoppedAnimation from animation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AlwaysStoppedAnimation test executing');

  // ========== ALWAYSSTOPPEDANIMATION<double> ==========
  print('--- AlwaysStoppedAnimation<double> Tests ---');

  // Create with 0.5
  final anim1 = AlwaysStoppedAnimation<double>(0.5);
  print('AlwaysStoppedAnimation<double>(0.5):');
  print('  value: ${anim1.value}');
  print('  status: ${anim1.status}');

  // Create with 0.0
  final anim0 = AlwaysStoppedAnimation<double>(0.0);
  print('AlwaysStoppedAnimation<double>(0.0):');
  print('  value: ${anim0.value}');
  print('  status: ${anim0.status}');

  // Create with 1.0
  final anim1Full = AlwaysStoppedAnimation<double>(1.0);
  print('AlwaysStoppedAnimation<double>(1.0):');
  print('  value: ${anim1Full.value}');
  print('  status: ${anim1Full.status}');

  // Create with 0.75
  final anim75 = AlwaysStoppedAnimation<double>(0.75);
  print('AlwaysStoppedAnimation<double>(0.75):');
  print('  value: ${anim75.value}');
  print('  status: ${anim75.status}');

  // ========== ALWAYSSTOPPEDANIMATION<Color> ==========
  print('--- AlwaysStoppedAnimation<Color> Tests ---');

  final colorAnim = AlwaysStoppedAnimation<Color>(Color(0xFF2196F3));
  print('AlwaysStoppedAnimation<Color>(blue):');
  print('  value: ${colorAnim.value}');
  print('  status: ${colorAnim.status}');

  final redAnim = AlwaysStoppedAnimation<Color>(Color(0xFFFF0000));
  print('AlwaysStoppedAnimation<Color>(red):');
  print('  value: ${redAnim.value}');

  // ========== ALWAYSSTOPPEDANIMATION<int> ==========
  print('--- AlwaysStoppedAnimation<int> Tests ---');

  final intAnim = AlwaysStoppedAnimation<int>(42);
  print('AlwaysStoppedAnimation<int>(42):');
  print('  value: ${intAnim.value}');
  print('  status: ${intAnim.status}');

  // ========== ALWAYSSTOPPEDANIMATION<Offset> ==========
  print('--- AlwaysStoppedAnimation<Offset> Tests ---');

  final offsetAnim = AlwaysStoppedAnimation<Offset>(Offset(0.5, 0.3));
  print('AlwaysStoppedAnimation<Offset>(0.5, 0.3):');
  print('  value: ${offsetAnim.value}');
  print('  status: ${offsetAnim.status}');

  // ========== ALWAYSSTOPPEDANIMATION<Size> ==========
  print('--- AlwaysStoppedAnimation<Size> Tests ---');

  final sizeAnim = AlwaysStoppedAnimation<Size>(Size(100.0, 50.0));
  print('AlwaysStoppedAnimation<Size>(100, 50):');
  print('  value: ${sizeAnim.value}');

  // ========== USE IN TRANSITIONS ==========
  print('--- AlwaysStoppedAnimation in Transitions ---');

  // Use in FadeTransition
  print('Using in FadeTransition with opacity=0.5');
  print('Using in FadeTransition with opacity=1.0');

  // Use in SlideTransition
  print('Using in SlideTransition with offset=(0.0, 0.0)');

  // Use in RotationTransition
  print('Using in RotationTransition with turns=0.25');

  // Use in ScaleTransition
  print('Using in ScaleTransition with scale=0.8');

  // ========== STATUS CHECK ==========
  print('--- Status Consistency ---');
  final statuses = [anim0, anim1, anim1Full, anim75];
  for (final a in statuses) {
    print('  value=${a.value} -> status=${a.status}');
  }

  // ========== WIDGET TREE ==========
  return Container(
    padding: EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AlwaysStoppedAnimation Test Results',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
          ),
          SizedBox(height: 16.0),

          // FadeTransition with AlwaysStoppedAnimation
          Text(
            'FadeTransition (opacity=0.5):',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 4.0),
          FadeTransition(
            opacity: AlwaysStoppedAnimation<double>(0.5),
            child: Container(
              width: 200.0,
              height: 40.0,
              color: Color(0xFF2196F3),
              child: Center(
                child: Text(
                  '50% Opacity',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),

          // FadeTransition fully visible
          Text(
            'FadeTransition (opacity=1.0):',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 4.0),
          FadeTransition(
            opacity: AlwaysStoppedAnimation<double>(1.0),
            child: Container(
              width: 200.0,
              height: 40.0,
              color: Color(0xFF4CAF50),
              child: Center(
                child: Text(
                  '100% Opacity',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),

          // FadeTransition low opacity
          Text(
            'FadeTransition (opacity=0.2):',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 4.0),
          FadeTransition(
            opacity: AlwaysStoppedAnimation<double>(0.2),
            child: Container(
              width: 200.0,
              height: 40.0,
              color: Color(0xFFFF9800),
              child: Center(
                child: Text(
                  '20% Opacity',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),

          // SlideTransition
          Text(
            'SlideTransition (offset=0,0):',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 4.0),
          SlideTransition(
            position: AlwaysStoppedAnimation<Offset>(Offset(0.0, 0.0)),
            child: Container(
              width: 200.0,
              height: 40.0,
              color: Color(0xFF9C27B0),
              child: Center(
                child: Text(
                  'No Slide',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),

          // RotationTransition
          Text(
            'RotationTransition (turns=0.25):',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 4.0),
          SizedBox(
            width: 60.0,
            height: 60.0,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation<double>(0.25),
              child: Container(
                color: Color(0xFFE91E63),
                child: Center(
                  child: Text(
                    'R',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),

          // ScaleTransition
          Text(
            'ScaleTransition (scale=0.8):',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 4.0),
          ScaleTransition(
            scale: AlwaysStoppedAnimation<double>(0.8),
            child: Container(
              width: 200.0,
              height: 40.0,
              color: Color(0xFF009688),
              child: Center(
                child: Text(
                  '80% Scale',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),

          // Summary
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFF5F5F5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AlwaysStoppedAnimation Summary:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                ),
                SizedBox(height: 4.0),
                Text(
                  '• Provides a constant animation value',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• Status is always AnimationStatus.forward',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• Useful for static transition widgets',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• Supports any type: double, Color, Offset, etc.',
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
