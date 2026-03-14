// D4rt test script: Tests RepetitiveStackFrameFilter from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RepetitiveStackFrameFilter test executing');
  print('=' * 50);

  // Create basic RepetitiveStackFrameFilter
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
  print('\nRepetitiveStackFrameFilter created:');
  print('runtimeType: ${filter1.runtimeType}');
  print('is StackFilter: ${filter1 is StackFilter}');
  print('replacement: ${filter1.replacement}');

  // Examine frames
  print('\nFrames list:');
  print('frames.length: ${filter1.frames.length}');
  final frame = filter1.frames[0];
  print('frame[0].package: ${frame.package}');
  print('frame[0].className: ${frame.className}');
  print('frame[0].method: ${frame.method}');

  // Create with multiple frames
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
      PartialStackFrame(
        package: 'package:flutter/src/widgets/framework.dart',
        className: 'BuildOwner',
        method: 'buildScope',
      ),
    ],
    replacement: '...widget framework internals...',
  );
  print('\nMultiple frames filter:');
  print('frames.length: ${multiFilter.frames.length}');
  for (int i = 0; i < multiFilter.frames.length; i++) {
    final f = multiFilter.frames[i];
    print('  [$i]: ${f.className}.${f.method}');
  }

  // Create for async framework
  final asyncFilter = RepetitiveStackFrameFilter(
    frames: [
      PartialStackFrame(
        package: 'dart:async',
        className: '_Future',
        method: '_asyncRunCallback',
      ),
      PartialStackFrame(
        package: 'dart:async',
        className: '_Future',
        method: '_propagateToListeners',
      ),
    ],
    replacement: '...async stacktrace...',
  );
  print('\nAsync filter:');
  print('frames.length: ${asyncFilter.frames.length}');
  print('replacement: ${asyncFilter.replacement}');

  // Create with empty replacement
  final silentFilter = RepetitiveStackFrameFilter(
    frames: [
      PartialStackFrame(package: 'test', className: 'Test', method: 'run'),
    ],
    replacement: '',
  );
  print('\nEmpty replacement:');
  print('replacement isEmpty: ${silentFilter.replacement.isEmpty}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is StackFilter: ${filter1 is StackFilter}');
  print('is Object: ${filter1 is Object}');

  // Common Flutter filtering patterns
  print('\nCommon Flutter filtering patterns:');
  final renderFilter = RepetitiveStackFrameFilter(
    frames: [
      PartialStackFrame(
        package: 'package:flutter/src/rendering/object.dart',
        className: 'RenderObject',
        method: 'layout',
      ),
    ],
    replacement: '...render object layout...',
  );
  final bindingFilter = RepetitiveStackFrameFilter(
    frames: [
      PartialStackFrame(
        package: 'package:flutter/src/scheduler/binding.dart',
        className: 'SchedulerBinding',
        method: 'handleDrawFrame',
      ),
    ],
    replacement: '...scheduler binding...',
  );
  print('Render filter package: ${renderFilter.frames[0].package}');
  print('Binding filter class: ${bindingFilter.frames[0].className}');

  // Explain purpose
  print('\nRepetitiveStackFrameFilter purpose:');
  print('- Filters repetitive framework stack frames');
  print('- Extends StackFilter base class');
  print('- frames: list of PartialStackFrame patterns to match');
  print('- replacement: text to show instead of matched frames');
  print('- Simplifies error stack traces for debugging');
  print('- Used by FlutterError.defaultStackFilter');

  print('\n' + '=' * 50);
  print('RepetitiveStackFrameFilter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RepetitiveStackFrameFilter Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${filter1.runtimeType}'),
      Text('is StackFilter: ${filter1 is StackFilter}'),
      Text('Single frame: ${filter1.frames.length}'),
      Text('Multi frame: ${multiFilter.frames.length}'),
      Text('Purpose: Filter repetitive framework frames'),
    ],
  );
}
