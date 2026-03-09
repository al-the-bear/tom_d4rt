// D4rt test script: Tests Category annotation from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Category test executing');

  final cat = Category('widgets');
  print('Category: ${cat.runtimeType}');
  print('sections: ${cat.sections}');

  final cat2 = Category('animation');
  print('cat2 sections: ${cat2.sections}');

  print('Category test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('Category Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Annotation class for documentation'),
    Text('sections: ${cat.sections}'),
  ]);
}
