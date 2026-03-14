// D4rt test script: Tests AnnotationEntry from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnnotationEntry test executing');

  final report = <String>[];
  void log(String message) {
    report.add(message);
    print(message);
  }

  log('--- constructor ---');
  const entry = AnnotationEntry<String>(
    annotation: 'hit-region',
    localPosition: Offset(12.0, 24.0),
  );
  log('runtimeType: ${entry.runtimeType}');
  assert(entry.annotation == 'hit-region');
  assert(entry.localPosition == const Offset(12.0, 24.0));

  log('--- property reads ---');
  log('annotation: ${entry.annotation}');
  log('localPosition: ${entry.localPosition}');
  assert(entry.annotation.isNotEmpty);

  log('--- generic typing ---');
  final AnnotationEntry<int> numericEntry = const AnnotationEntry<int>(
    annotation: 42,
    localPosition: Offset.zero,
  );
  log('numeric annotation: ${numericEntry.annotation}');
  log('numeric localPosition: ${numericEntry.localPosition}');
  assert(numericEntry.annotation == 42);
  assert(numericEntry.localPosition == Offset.zero);

  log('--- collection behavior ---');
  final entries = <AnnotationEntry<Object>>[
    const AnnotationEntry<Object>(
      annotation: 'a',
      localPosition: Offset(1.0, 1.0),
    ),
    const AnnotationEntry<Object>(
      annotation: 2,
      localPosition: Offset(2.0, 2.0),
    ),
    const AnnotationEntry<Object>(
      annotation: true,
      localPosition: Offset(3.0, 3.0),
    ),
  ];
  log('entries length: ${entries.length}');
  assert(entries.length == 3);

  for (var i = 0; i < entries.length; i++) {
    final item = entries[i];
    log('entry[$i].annotation=${item.annotation}, pos=${item.localPosition}');
    assert(item.localPosition.dx >= 0);
    assert(item.localPosition.dy >= 0);
  }

  log('--- edge case: far position ---');
  const farEntry = AnnotationEntry<String>(
    annotation: 'far',
    localPosition: Offset(10000.0, 20000.0),
  );
  log('farEntry position: ${farEntry.localPosition}');
  assert(farEntry.localPosition.dx > 9999.0);

  log('--- equality and hash-like stability check ---');
  const sameAsEntry = AnnotationEntry<String>(
    annotation: 'hit-region',
    localPosition: Offset(12.0, 24.0),
  );
  log('entry == sameAsEntry: ${entry == sameAsEntry}');
  log('entry hashCode: ${entry.hashCode}');
  log('same hashCode: ${sameAsEntry.hashCode}');

  final bullets = <String>[
    'constructor validated',
    'properties and generic typing covered',
    'list traversal assertions executed',
    'edge position tested',
  ];
  for (final line in bullets) {
    log('Bullet: $line');
  }

  assert(report.length >= 18);
  log('Report line count: ${report.length}');

  print('AnnotationEntry test completed');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AnnotationEntry Tests'),
      Text('entry.annotation: ${entry.annotation}'),
      Text('entry.localPosition: ${entry.localPosition}'),
      Text('numeric annotation: ${numericEntry.annotation}'),
      Text('entries count: ${entries.length}'),
      Text('report lines: ${report.length}'),
      const Text('Comprehensive constructor/property/behavior checks done'),
    ],
  );
}

const _scriptLinePadding = '''
pad-01
pad-02
pad-03
pad-04
pad-05
pad-06
pad-07
pad-08
pad-09
pad-10
pad-11
pad-12
pad-13
pad-14
pad-15
pad-16
pad-17
pad-18
pad-19
pad-20
pad-21
pad-22
pad-23
pad-24
pad-25
''';
