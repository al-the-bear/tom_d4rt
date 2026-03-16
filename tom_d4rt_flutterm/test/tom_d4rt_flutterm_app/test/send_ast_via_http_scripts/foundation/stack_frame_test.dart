// D4rt test script: Tests StackFrame from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StackFrame test executing');

  final frame = StackFrame(
    number: 0,
    column: 12,
    line: 42,
    packageScheme: 'package',
    package: 'myapp',
    packagePath: 'src/main.dart',
    className: 'App',
    method: 'build',
    source: '#0      App.build (package:myapp/src/main.dart:42:12)',
  );
  print('StackFrame type: ${frame.runtimeType}');
  print('number: ${frame.number}');
  print('line: ${frame.line}');
  print('column: ${frame.column}');
  print('package: ${frame.package}');
  print('packagePath: ${frame.packagePath}');
  print('className: ${frame.className}');
  print('method: ${frame.method}');
  print('source: ${frame.source}');

  final parsed = StackFrame.fromStackString(
    '#1      MyWidget.build (package:myapp/widgets.dart:10:5)',
  );
  print('Parsed frames: ${parsed.length}');
  if (parsed.isNotEmpty) {
    print('Parsed first method: ${parsed.first.method}');
    print('Parsed first line: ${parsed.first.line}');
  }

  print('StackFrame test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('StackFrame Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('line=${frame.line}, col=${frame.column}'),
    Text('${frame.className}.${frame.method}'),
  ]);
}
