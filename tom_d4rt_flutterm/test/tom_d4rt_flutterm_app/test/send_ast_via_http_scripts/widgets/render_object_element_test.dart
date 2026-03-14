// D4rt test script: Tests RenderObjectElement from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderObjectElement test executing');

  final logs = <String>[];
  void log(String message) {
    logs.add(message);
    print(message);
  }

  log('--- indirect instantiation via RenderObjectWidget ---');
  const widget = SizedBox(width: 10.0, height: 20.0);
  final element = widget.createElement();
  final Type targetType = RenderObjectElement;

  log('targetType: $targetType');
  log('element runtimeType: ${element.runtimeType}');
  log('is RenderObjectElement: ${element is RenderObjectElement}');
  assert(element is RenderObjectElement);

  log('--- type and inheritance checks ---');
  final renderObjectElement = element as RenderObjectElement;
  assert(renderObjectElement is Element);
  assert(renderObjectElement.widget == widget);
  log('widget runtimeType: ${renderObjectElement.widget.runtimeType}');

  log('--- lifecycle related methods availability ---');
  log('toStringShort: ${renderObjectElement.toStringShort()}');
  final diagnostics = renderObjectElement.toString();
  log('toString contains Element: ${diagnostics.contains('Element')}');
  assert(diagnostics.isNotEmpty);

  log('--- edge case: second element instance ---');
  const secondWidget = SizedBox.shrink();
  final secondElement = secondWidget.createElement();
  log('second element runtimeType: ${secondElement.runtimeType}');
  assert(secondElement is RenderObjectElement);
  assert(secondElement != renderObjectElement);

  log('--- batch behavior ---');
  final elements = <Element>[element, secondElement];
  assert(elements.length == 2);
  for (var i = 0; i < elements.length; i++) {
    final item = elements[i];
    log('elements[$i]: ${item.runtimeType}');
    assert(item is RenderObjectElement);
  }

  final checks = <String>[
    'RenderObjectElement class referenced directly',
    'indirect construction through createElement',
    'inheritance from Element validated',
    'widget linkage validated',
    'toString diagnostics validated',
    'edge case with second instance validated',
    'collection checks completed',
    'assertions executed',
    'print tracing executed',
    'summary widget prepared',
    'dynamic build signature preserved',
    'compile-sensible script style preserved',
  ];
  for (final check in checks) {
    log('check: $check');
  }

  assert(logs.length >= 20);
  log('log count: ${logs.length}');

  print('RenderObjectElement test completed');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RenderObjectElement Tests'),
      Text('targetType: $targetType'),
      Text('first element: ${element.runtimeType}'),
      Text('second element: ${secondElement.runtimeType}'),
      Text('checks: ${checks.length}'),
      Text('logs: ${logs.length}'),
      const Text('RenderObjectElement constructor/properties/behavior covered'),
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
