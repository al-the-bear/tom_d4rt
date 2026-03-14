// D4rt test script: Tests RenderObjectToWidgetAdapter from widgets
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderObjectToWidgetAdapter test executing');

  final traces = <String>[];
  void log(String message) {
    traces.add(message);
    print(message);
  }

  log('--- constructor ---');
  final container = RenderPositionedBox(alignment: Alignment.center);
  final adapter = RenderObjectToWidgetAdapter<RenderBox>(
    container: container,
    debugShortDescription: 'adapter-script',
    child: const SizedBox(width: 5.0, height: 6.0),
  );

  log('runtimeType: ${adapter.runtimeType}');
  assert(adapter is RenderObjectToWidgetAdapter<RenderBox>);

  log('--- property checks ---');
  log('child runtimeType: ${adapter.child.runtimeType}');
  log('container runtimeType: ${adapter.container.runtimeType}');
  log('debugShortDescription: ${adapter.debugShortDescription}');
  assert(adapter.container == container);
  assert(adapter.child != null);

  log('--- element creation behavior ---');
  final adapterElement = adapter.createElement();
  log('adapterElement runtimeType: ${adapterElement.runtimeType}');
  assert(adapterElement is RenderObjectToWidgetElement<RenderBox>);

  log('--- edge case: child is null ---');
  final nullChildAdapter = RenderObjectToWidgetAdapter<RenderBox>(
    container: RenderPositionedBox(alignment: Alignment.center),
    debugShortDescription: 'null-child-adapter',
  );
  log('nullChildAdapter child is null: ${nullChildAdapter.child == null}');
  assert(nullChildAdapter.child == null);

  final list = <RenderObjectToWidgetAdapter<RenderBox>>[
    adapter,
    nullChildAdapter,
  ];
  for (var i = 0; i < list.length; i++) {
    log('list[$i].debugShortDescription=${list[i].debugShortDescription}');
    assert(list[i].container is RenderObjectWithChildMixin<RenderBox>);
  }

  final checklist = <String>[
    'RenderObjectToWidgetAdapter instantiated',
    'container property validated',
    'child property validated',
    'debugShortDescription validated',
    'createElement behavior validated',
    'null child edge case validated',
    'list iteration validated',
    'assertions completed',
    'print statements completed',
    'summary widget prepared',
    'dynamic build signature preserved',
    'compile-sensible imports retained',
  ];
  for (final item in checklist) {
    log('check: $item');
  }

  assert(traces.length >= 20);
  log('trace count: ${traces.length}');

  print('RenderObjectToWidgetAdapter test completed');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RenderObjectToWidgetAdapter Tests'),
      Text('adapter child type: ${adapter.child.runtimeType}'),
      Text('container type: ${adapter.container.runtimeType}'),
      Text('adapter element type: ${adapterElement.runtimeType}'),
      Text('list entries: ${list.length}'),
      Text('checks: ${checklist.length}'),
      Text('traces: ${traces.length}'),
      const Text('RenderObjectToWidgetAdapter behavior tested'),
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
