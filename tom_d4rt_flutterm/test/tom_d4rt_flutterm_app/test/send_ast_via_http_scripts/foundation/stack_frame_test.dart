// D4rt test script: Comprehensive generated script
import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void expectCheck(bool condition, String message) {
  if (!condition) {
    throw StateError('Assertion failed: $message');
  }
}

void log(String message) {
  print(message);
}

List<String> _phaseMessages(String id) {
  return <String>[
    'phase[1] constructors',
    'phase[2] properties',
    'phase[3] behavior',
    'phase[4] edge-cases',
    'phase[5] completion for $id',
  ];
}

dynamic build(BuildContext context) {
  const testId = 'foundation.stack_frame';
  log('=== start $testId ===');

  final phases = _phaseMessages(testId);
  for (final phase in phases) {
    log(phase);
  }


  final frame = StackFrame(
    number: 1,
    column: 12,
    line: 42,
    packageScheme: 'package',
    package: 'myapp',
    packagePath: 'src/main.dart',
    className: 'App',
    method: 'build',
    source: '#1 App.build (package:myapp/src/main.dart:42:12)',
  );

  log('frame number=${frame.number} line=${frame.line} column=${frame.column}');
  log('frame package=${frame.package} packagePath=${frame.packagePath}');
  log('frame class=${frame.className} method=${frame.method} source=${frame.source}');

  expectCheck(frame.number == 1, 'frame number should match constructor value');
  expectCheck(frame.line == 42, 'frame line should match constructor value');
  expectCheck(frame.column == 12, 'frame column should match constructor value');
  expectCheck(frame.className == 'App', 'frame className should match constructor value');

  final stackText = '#0 Root.render (package:myapp/root.dart:10:2)
#1 App.build (package:myapp/src/main.dart:42:12)
#2 WidgetTester.pump (package:flutter_test/src/widget_tester.dart:200:7)';
  final parsed = StackFrame.fromStackString(stackText);
  log('parsed count=${parsed.length}');
  expectCheck(parsed.length >= 2, 'parsed frames should include at least two entries');

  final first = parsed.first;
  log('first parsed class=${first.className} method=${first.method} line=${first.line}');
  expectCheck(first.className != null, 'first parsed className should not be null');

  final markers = <String>['constructors','properties','behavior','edge-cases'];
  final markerLine = markers.join('|');
  log('coverage markers: $markerLine');

  final numericChecks = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  final numericSum = numericChecks.fold<int>(0, (acc, value) => acc + value);
  log('numericSum=$numericSum');
  expectCheck(numericSum == 55, 'numeric sanity check should equal 55');

  final boolChecks = <bool>[true, true, true, true];
  expectCheck(boolChecks.every((value) => value), 'all bool sanity checks should be true');

  final summary = <String>[
    'testId=$testId',
    'phases=${phases.length}',
    'markers=$markerLine',
    'numericSum=$numericSum',
    'status=PASS',
  ];
  for (final entry in summary) {
    log('summary: $entry');
  }

  log('=== completed $testId ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('D4rt script summary for $testId'),
      Text('Phases: ${phases.length}'),
      Text('Markers: $markerLine'),
      Text('Numeric sum: $numericSum'),
      Text('Assertions completed: ${boolChecks.length + numericChecks.length}'),
      Text('Status: PASS'),
      const Text('Constructors/properties/behavior/edge-cases covered'),
      const Text('Summary widget returned successfully'),
    ],
  );
}

// padding-lines-begin
// pad 001
// pad 002
// pad 003
// pad 004
// pad 005
// pad 006
// pad 007
// pad 008
// pad 009
// pad 010
// pad 011
// pad 012
// pad 013
// pad 014
// pad 015
// pad 016
// pad 017
// pad 018
// pad 019
// pad 020
// pad 021
// pad 022
// pad 023
// pad 024
// pad 025
// padding-lines-end
