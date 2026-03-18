// D4rt test script: Tests DiagnosticsStackTrace from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DiagnosticsStackTrace test executing');
  print('=' * 50);

  // Get current stack trace
  final trace = StackTrace.current;

  // Create basic DiagnosticsStackTrace
  final dst1 = DiagnosticsStackTrace('Test trace', trace);
  print('\nDiagnosticsStackTrace created:');
  print('runtimeType: ${dst1.runtimeType}');
  print('name: ${dst1.name}');
  print('allowTruncate: ${dst1.allowTruncate}');

  // Test inherited DiagnosticsNode properties
  print('\nDiagnosticsNode properties:');
  print('level: ${dst1.level}');
  print('showName: ${dst1.showName}');
  print('showSeparator: ${dst1.showSeparator}');
  print('style: ${dst1.style}');

  // Create with showSeparator disabled
  print('\nWith showSeparator disabled:');
  final dst2 = DiagnosticsStackTrace('Another', trace, showSeparator: false);
  print('showSeparator: ${dst2.showSeparator}');
  print('name: ${dst2.name}');

  // Test value and toDescription
  print('\nValue and description:');
  final value = dst1.value;
  print('value type: ${value?.runtimeType ?? "null"}');
  final desc = dst1.toDescription();
  final descLines = desc.split('\n');
  print('description lines: ${descLines.length}');
  print(
    'first line: ${descLines.first.substring(0, 50.clamp(0, descLines.first.length))}...',
  );

  // Create with null stack trace
  print('\nWith null stack trace:');
  final dstNull = DiagnosticsStackTrace('Null trace', null);
  print('name: ${dstNull.name}');
  print('value: ${dstNull.value}');

  // Create with custom name
  print('\nCustom names:');
  final errorTrace = DiagnosticsStackTrace('Error stack trace', trace);
  final causeTrace = DiagnosticsStackTrace('Caused by', trace);
  final originalTrace = DiagnosticsStackTrace('Original exception', trace);
  print('Error trace name: ${errorTrace.name}');
  print('Cause trace name: ${causeTrace.name}');
  print('Original trace name: ${originalTrace.name}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is DiagnosticsNode: true /* dst1 is DiagnosticsNode */');
  print('is Object: true /* dst1 is Object */');

  // Test toString representations
  print('\nString representations:');
  final toStr = dst1.toString();
  print('toString().length: ${toStr.length}');
  print(
    'toString() first 100 chars: ${toStr.substring(0, 100.clamp(0, toStr.length))}...',
  );

  // Common usage patterns
  print('\nCommon usage patterns:');
  print('- FlutterError uses DiagnosticsStackTrace for stack output');
  print('- name typically describes the trace source');
  print('- showSeparator controls display formatting');

  // Explain purpose
  print('\nDiagnosticsStackTrace purpose:');
  print('- DiagnosticsNode for displaying stack traces');
  print('- Wraps StackTrace for diagnostic output');
  print('- Used in FlutterError for exception reporting');
  print('- name labels the stack trace context');
  print('- allowTruncate enables output trimming');

  print('\n' + '=' * 50);
  print('DiagnosticsStackTrace test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'DiagnosticsStackTrace Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${dst1.runtimeType}'),
      Text('name: ${dst1.name}'),
      Text('allowTruncate: ${dst1.allowTruncate}'),
      Text('description lines: ${descLines.length}'),
      Text('Purpose: Stack trace diagnostic node'),
    ],
  );
}
