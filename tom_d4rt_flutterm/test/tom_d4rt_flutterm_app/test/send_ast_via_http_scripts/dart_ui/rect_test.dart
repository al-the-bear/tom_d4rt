// D4rt test script: Tests Rect from dart:ui
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Rect test executing');

  // Test Rect.fromLTWH
  final rect1 = Rect.fromLTWH(10.0, 20.0, 200.0, 100.0);
  print(
    'Rect.fromLTWH: left=${rect1.left}, top=${rect1.top}, width=${rect1.width}, height=${rect1.height}',
  );

  // Test Rect.fromLTRB
  final rect2 = Rect.fromLTRB(0.0, 0.0, 150.0, 150.0);
  print(
    'Rect.fromLTRB: ${rect2.left}, ${rect2.top}, ${rect2.right}, ${rect2.bottom}',
  );

  // Test Rect.fromCenter
  final rect3 = Rect.fromCenter(
    center: Offset(100.0, 100.0),
    width: 80.0,
    height: 60.0,
  );
  print('Rect.fromCenter: center=(${rect3.center.dx}, ${rect3.center.dy})');

  // Test Rect.fromCircle
  final rect4 = Rect.fromCircle(center: Offset(50.0, 50.0), radius: 25.0);
  print('Rect.fromCircle: size=${rect4.width}x${rect4.height}');

  // Test Rect.zero
  final zero = Rect.zero;
  print('Rect.zero: ${zero.width}x${zero.height}');

  // Test Rect properties
  print('rect1.size: ${rect1.size.width}x${rect1.size.height}');
  print('rect1.topLeft: ${rect1.topLeft.dx}, ${rect1.topLeft.dy}');
  print('rect1.bottomRight: ${rect1.bottomRight.dx}, ${rect1.bottomRight.dy}');

  // Test Rect operations
  final inflated = rect2.inflate(10.0);
  print('inflated: ${inflated.width}x${inflated.height}');

  final deflated = rect2.deflate(10.0);
  print('deflated: ${deflated.width}x${deflated.height}');

  print('Rect test completed');

  return Container(
    width: rect1.width,
    height: rect1.height,
    margin: EdgeInsets.only(left: rect1.left, top: rect1.top),
    color: Colors.purple,
    child: Center(
      child: Text(
        'Rect: ${rect1.width.toInt()}x${rect1.height.toInt()}',
        style: TextStyle(color: Colors.white, fontSize: 14.0),
      ),
    ),
  );
}
