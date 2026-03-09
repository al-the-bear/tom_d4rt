// D4rt test script: Tests Summary annotation from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Summary test executing');

  final s = Summary('A brief description of the class.');
  print('Summary: ${s.runtimeType}');
  print('text: ${s.text}');

  final s2 = Summary('Another summary.');
  print('s2 text: ${s2.text}');

  print('Summary test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('Summary Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Annotation class for docs'),
    Text('text: ${s.text}'),
  ]);
}
