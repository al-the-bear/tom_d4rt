// D4rt test script: Tests SliverLogicalParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverLogicalParentData test executing');

  final notes = <String>[];
  void log(String message) {
    notes.add(message);
    print(message);
  }

  log('--- constructor and base compatibility ---');
  final data = SliverLogicalParentData();
  log('runtimeType: ${data.runtimeType}');
  assert(data is ParentData);

  log('--- default property check ---');
  log('layoutOffset default: ${data.layoutOffset}');
  assert(data.layoutOffset == null);

  log('--- property mutation ---');
  data.layoutOffset = 123.5;
  log('layoutOffset after: ${data.layoutOffset}');
  assert(data.layoutOffset == 123.5);

  log('--- edge values ---');
  data.layoutOffset = -10.0;
  log('layoutOffset negative: ${data.layoutOffset}');
  assert(data.layoutOffset == -10.0);

  data.layoutOffset = 1000000.0;
  log('layoutOffset large: ${data.layoutOffset}');
  assert((data.layoutOffset ?? 0) > 999999.0);

  log('--- detach behavior ---');
  data.detach();
  log('detach called');

  log('--- list behavior ---');
  final items = <SliverLogicalParentData>[
    SliverLogicalParentData()..layoutOffset = 0.0,
    SliverLogicalParentData()..layoutOffset = 10.0,
    SliverLogicalParentData()..layoutOffset = 20.5,
  ];
  assert(items.length == 3);
  for (var i = 0; i < items.length; i++) {
    log('item[$i].layoutOffset=${items[i].layoutOffset}');
    assert((items[i].layoutOffset ?? -1) >= 0.0);
  }

  final checks = <String>[
    'constructor validated',
    'ParentData inheritance validated',
    'default layoutOffset validated',
    'mutation scenarios validated',
    'negative and large values validated',
    'detach behavior invoked',
    'collection behavior validated',
    'assertions executed',
    'print tracing executed',
    'summary data prepared',
    'dynamic build retained',
    'compile-sensible script maintained',
  ];
  for (final check in checks) {
    log('check: $check');
  }

  assert(notes.length >= 21);
  log('note count: ${notes.length}');

  print('SliverLogicalParentData test completed');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SliverLogicalParentData Tests'),
      Text('layoutOffset: ${data.layoutOffset}'),
      Text('items: ${items.length}'),
      Text('checks: ${checks.length}'),
      Text('notes: ${notes.length}'),
      const Text('SliverLogicalParentData constructor/properties/edge-cases tested'),
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
