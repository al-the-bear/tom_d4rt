// D4rt test script: Tests ErrorSpacer from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ErrorSpacer test executing');

  final spacer = ErrorSpacer();
  print('ErrorSpacer: ${spacer.runtimeType}');
  print('level: ${spacer.level}');
  print('toString: "${spacer.toString()}"');

  print('ErrorSpacer test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('ErrorSpacer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Adds blank line in error output'),
    Text('level: ${spacer.level}'),
  ]);
}
