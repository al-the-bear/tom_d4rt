// D4rt test script: Tests RepetitiveStackFrameFilter from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RepetitiveStackFrameFilter test executing');

  final filter = RepetitiveStackFrameFilter(
    frames: [
      PartialStackFrame(package: 'package:flutter/src/widgets/framework.dart', className: 'Element', method: 'rebuild'),
    ],
    replacement: '...Flutter framework...',
  );
  print('RepetitiveStackFrameFilter: ${filter.runtimeType}');
  print('is StackFilter: ${filter is StackFilter}');
  print('replacement: ...Flutter framework...');

  print('RepetitiveStackFrameFilter test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('RepetitiveStackFrameFilter Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Filters repetitive framework frames'),
    Text('is StackFilter: ${filter is StackFilter}'),
  ]);
}
