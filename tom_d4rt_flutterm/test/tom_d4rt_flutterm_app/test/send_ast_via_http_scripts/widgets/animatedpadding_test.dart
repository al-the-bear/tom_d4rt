// D4rt test script: Tests AnimatedPadding from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedPadding test executing');

  // Test AnimatedPadding with EdgeInsets.all
  final padAll = AnimatedPadding(
    padding: EdgeInsets.all(16),
    duration: Duration(milliseconds: 300),
    child: Container(color: Colors.blue, width: 80, height: 80),
  );
  print('AnimatedPadding(EdgeInsets.all(16)) created');

  // Test AnimatedPadding with symmetric horizontal
  final padSymH = AnimatedPadding(
    padding: EdgeInsets.symmetric(horizontal: 32),
    duration: Duration(milliseconds: 300),
    child: Container(color: Colors.green, width: 80, height: 80),
  );
  print('AnimatedPadding(EdgeInsets.symmetric(horizontal: 32)) created');

  // Test AnimatedPadding with only top and left
  final padOnly = AnimatedPadding(
    padding: EdgeInsets.only(top: 20, left: 10),
    duration: Duration(milliseconds: 300),
    child: Container(color: Colors.red, width: 80, height: 80),
  );
  print('AnimatedPadding(EdgeInsets.only(top: 20, left: 10)) created');

  // Test AnimatedPadding with Curves.easeIn
  final padCurve = AnimatedPadding(
    padding: EdgeInsets.all(24),
    duration: Duration(milliseconds: 500),
    curve: Curves.easeIn,
    child: Container(color: Colors.orange, width: 80, height: 80),
  );
  print('AnimatedPadding with Curves.easeIn created');

  // Test AnimatedPadding with Curves.bounceOut
  final padBounce = AnimatedPadding(
    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    duration: Duration(milliseconds: 400),
    curve: Curves.bounceOut,
    child: Container(color: Colors.purple, width: 80, height: 80),
  );
  print('AnimatedPadding with Curves.bounceOut created');

  print('AnimatedPadding test completed');
  return Column(children: [
    padAll,
    padSymH,
    padOnly,
    padCurve,
    padBounce,
  ]);
}
