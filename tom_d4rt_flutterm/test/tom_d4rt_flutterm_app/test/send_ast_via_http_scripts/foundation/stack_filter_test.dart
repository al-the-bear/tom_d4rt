// D4rt test script: Tests StackFilter from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StackFilter test executing');

  // StackFilter is abstract — test via RepetitiveStackFrameFilter
  final filter = RepetitiveStackFrameFilter(
    frames: [PartialStackFrame(package: 'package:test', className: 'A', method: 'run')],
    replacement: '...',
  );
  print('StackFilter subtype: ${filter.runtimeType}');
  print('is StackFilter: ${filter is StackFilter}');

  print('StackFilter test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('StackFilter Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Abstract base for stack frame filtering'),
    Text('Impl: RepetitiveStackFrameFilter'),
  ]);
}
