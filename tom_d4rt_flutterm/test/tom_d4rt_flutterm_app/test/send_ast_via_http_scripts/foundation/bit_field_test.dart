// D4rt test script: Tests BitField from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BitField test executing');

  final bf = BitField<int>(8);
  print('BitField created: ${bf.runtimeType}');

  bf.reset();
  print('After reset: ${bf.runtimeType}');

  bf.reset(true);
  print('After reset true: ${bf.runtimeType}');

  final bf2 = BitField<int>.filled(16, true);
  print('Filled 16 true: ${bf2.runtimeType}');

  print('BitField test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('BitField Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Construction OK'),
    Text('Reset operations OK'),
  ]);
}
