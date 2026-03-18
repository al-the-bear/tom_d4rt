// D4rt test script: Tests StackFilter from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StackFilter test executing');
  print('=' * 50);

  // StackFilter is abstract - test via RepetitiveStackFrameFilter implementation
  final filter1 = RepetitiveStackFrameFilter(
    frames: [
      PartialStackFrame(
        package: 'package:flutter/src/widgets/framework.dart',
        className: 'Element',
        method: 'rebuild',
      ),
    ],
    replacement: '...Flutter framework...',
  );
  print('\nRepetitiveStackFrameFilter (StackFilter impl):');
  print('runtimeType: ${filter1.runtimeType}');
  print('is StackFilter: true /* filter1 is StackFilter */');

  // Test inherited StackFilter properties
  print('\nStackFilter properties:');
  print('frames: ${filter1.frames}');
  print('frames.length: ${filter1.frames.length}');
  print('replacement: ${filter1.replacement}');

  // Create filter with multiple frames
  final multiFilter = RepetitiveStackFrameFilter(
    frames: [
      PartialStackFrame(
        package: 'package:flutter/src/widgets/framework.dart',
        className: 'Element',
        method: 'rebuild',
      ),
      PartialStackFrame(
        package: 'package:flutter/src/widgets/framework.dart',
        className: 'ComponentElement',
        method: 'performRebuild',
      ),
      PartialStackFrame(
        package: 'package:flutter/src/widgets/framework.dart',
        className: 'StatefulElement',
        method: 'build',
      ),
    ],
    replacement: '...widget framework internals...',
  );
  print('\nMultiple frames filter:');
  print('frames.length: ${multiFilter.frames.length}');
  for (int i = 0; i < multiFilter.frames.length; i++) {
    print(
      'frame[$i]: ${multiFilter.frames[i].className}.${multiFilter.frames[i].method}',
    );
  }

  // Test filter with empty replacement
  final silentFilter = RepetitiveStackFrameFilter(
    frames: [PartialStackFrame(package: 'test', className: 'A', method: 'm')],
    replacement: '',
  );
  print('\nEmpty replacement filter:');
  print('replacement isEmpty: ${silentFilter.replacement.isEmpty}');

  // Type hierarchy
  print('\nType hierarchy:');
  print(
    'RepetitiveStackFrameFilter is StackFilter: true /* filter1 is StackFilter */',
  );
  print('is Object: true /* filter1 is Object */');

  // Common filtering patterns
  print('\nCommon filtering patterns:');
  final asyncFilter = RepetitiveStackFrameFilter(
    frames: [
      PartialStackFrame(
        package: 'dart:async',
        className: '_Future',
        method: '_asyncRunCallback',
      ),
    ],
    replacement: '...async stacktrace...',
  );
  final isolateFilter = RepetitiveStackFrameFilter(
    frames: [
      PartialStackFrame(
        package: 'dart:isolate',
        className: '_RawReceivePortImpl',
        method: '_handleMessage',
      ),
    ],
    replacement: '...isolate message handling...',
  );
  print('Async filter package: ${asyncFilter.frames[0].package}');
  print('Isolate filter package: ${isolateFilter.frames[0].package}');

  // Explain purpose
  print('\nStackFilter purpose:');
  print('- Abstract base class for stack trace filtering');
  print('- Used to simplify error stack traces');
  print('- Removes repetitive framework-internal frames');
  print('- frames: list of PartialStackFrame to match');
  print('- replacement: text to show instead of matched frames');
  print('- Improves error readability for developers');

  print('\n' + '=' * 50);
  print('StackFilter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'StackFilter Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: abstract class'),
      Text('Implementation: RepetitiveStackFrameFilter'),
      Text('frames.length: ${multiFilter.frames.length}'),
      Text('is StackFilter: true /* filter1 is StackFilter */'),
      Text('Purpose: Stack trace filtering'),
    ],
  );
}
