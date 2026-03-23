// ignore_for_file: avoid_print
// D4rt test script: Tests AnimatedSize from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedSize test executing');

  // Test AnimatedSize with default settings
  final size1 = AnimatedSize(
    duration: Duration(milliseconds: 300),
    child: Container(width: 100, height: 100, color: Colors.blue),
  );
  print('AnimatedSize(duration: 300ms) created');

  // Test AnimatedSize with curve
  final size2 = AnimatedSize(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeIn,
    child: Container(width: 120, height: 80, color: Colors.green),
  );
  print('AnimatedSize with Curves.easeIn created');

  // Test AnimatedSize with alignment topLeft
  final size3 = AnimatedSize(
    duration: Duration(milliseconds: 300),
    alignment: Alignment.topLeft,
    child: Container(width: 90, height: 90, color: Colors.red),
  );
  print('AnimatedSize with Alignment.topLeft created');

  // Test AnimatedSize with clipBehavior hardEdge
  final size4 = AnimatedSize(
    duration: Duration(milliseconds: 300),
    clipBehavior: Clip.hardEdge,
    child: Container(width: 80, height: 80, color: Colors.orange),
  );
  print('AnimatedSize with Clip.hardEdge created');

  // Test AnimatedSize with easeInOut and center alignment
  final size5 = AnimatedSize(
    duration: Duration(milliseconds: 400),
    curve: Curves.easeInOut,
    alignment: Alignment.center,
    child: Container(width: 110, height: 70, color: Colors.purple),
  );
  print('AnimatedSize with Curves.easeInOut and Alignment.center created');

  print('AnimatedSize test completed');
  return Column(children: [size1, size2, size3, size4, size5]);
}
