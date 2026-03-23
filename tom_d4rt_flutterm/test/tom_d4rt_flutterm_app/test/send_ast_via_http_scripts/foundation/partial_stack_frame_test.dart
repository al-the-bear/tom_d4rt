// ignore_for_file: avoid_print
// D4rt test script: Tests PartialStackFrame from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PartialStackFrame test executing');

  final psf = PartialStackFrame(
    package: 'package:flutter/src/widgets/framework.dart',
    className: 'Element',
    method: 'rebuild',
  );
  print('PartialStackFrame: ${psf.runtimeType}');
  print('package: ${psf.package}');
  print('className: ${psf.className}');
  print('method: ${psf.method}');

  // matches
  final frame = StackFrame(
    number: 0,
    column: 1,
    line: 100,
    packageScheme: 'package',
    package: 'flutter',
    packagePath: 'src/widgets/framework.dart',
    className: 'Element',
    method: 'rebuild',
    source:
        '#0      Element.rebuild (package:flutter/src/widgets/framework.dart:100:1)',
  );
  final matches = psf.matches(frame);
  print('matches frame: $matches');

  print('PartialStackFrame test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PartialStackFrame Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('package: ${psf.package}'),
      Text('className: ${psf.className}'),
      Text('method: ${psf.method}'),
    ],
  );
}
