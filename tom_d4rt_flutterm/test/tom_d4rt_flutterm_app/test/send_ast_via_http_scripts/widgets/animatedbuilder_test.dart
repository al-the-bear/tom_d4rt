// D4rt test script: Tests AnimatedBuilder from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedBuilder test executing');

  // Test AnimatedBuilder with Opacity
  final builder1 = AnimatedBuilder(
    animation: AlwaysStoppedAnimation<double>(0.5),
    builder: (BuildContext context, Widget? child) {
      return Opacity(opacity: 0.5, child: child);
    },
    child: Container(width: 80, height: 80, color: Colors.blue),
  );
  print('AnimatedBuilder with Opacity(0.5) created');

  // Test AnimatedBuilder with full opacity
  final builder2 = AnimatedBuilder(
    animation: AlwaysStoppedAnimation<double>(1.0),
    builder: (BuildContext context, Widget? child) {
      return Opacity(opacity: 1.0, child: child);
    },
    child: Container(width: 80, height: 80, color: Colors.green),
  );
  print('AnimatedBuilder with AlwaysStoppedAnimation(1.0) created');

  // Test AnimatedBuilder with Transform.rotate
  final builder3 = AnimatedBuilder(
    animation: AlwaysStoppedAnimation<double>(0.75),
    builder: (BuildContext context, Widget? child) {
      return Transform.rotate(angle: 0.75, child: child);
    },
    child: Container(width: 60, height: 60, color: Colors.red),
  );
  print('AnimatedBuilder with Transform.rotate created');

  // Test AnimatedBuilder with Transform.scale
  final builder4 = AnimatedBuilder(
    animation: AlwaysStoppedAnimation<double>(1.2),
    builder: (BuildContext context, Widget? child) {
      return Transform.scale(scale: 1.2, child: child);
    },
    child: Container(width: 60, height: 60, color: Colors.orange),
  );
  print('AnimatedBuilder with Transform.scale created');

  // Test AnimatedBuilder without child
  final builder5 = AnimatedBuilder(
    animation: AlwaysStoppedAnimation<double>(0.3),
    builder: (BuildContext context, Widget? child) {
      return Container(
        width: 70,
        height: 70,
        color: Colors.purple,
        child: Center(child: Text('Built')),
      );
    },
  );
  print('AnimatedBuilder without child created');

  print('AnimatedBuilder test completed');
  return Column(children: [builder1, builder2, builder3, builder4, builder5]);
}
