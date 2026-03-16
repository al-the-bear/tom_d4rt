// D4rt test script: Tests DiagnosticsStackTrace from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DiagnosticsStackTrace test executing');

  final trace = StackTrace.current;
  final dst = DiagnosticsStackTrace('Test trace', trace);
  print('DiagnosticsStackTrace: ${dst.runtimeType}');
  print('name: ${dst.name}');
  print('allowTruncate: ${dst.allowTruncate}');

  // With showSeparator
  final dst2 = DiagnosticsStackTrace('Another', trace, showSeparator: false);
  print('showSeparator: ${dst2.showSeparator}');
  print('level: ${dst2.level}');

  print('DiagnosticsStackTrace test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('DiagnosticsStackTrace Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Wraps StackTrace for diagnostics'),
    Text('allowTruncate: ${dst.allowTruncate}'),
  ]);
}
