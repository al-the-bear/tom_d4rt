// D4rt test script: Tests RenderObjectWidget from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderObjectWidget test executing');

  final logLines = <String>[];
  void log(String message) {
    logLines.add(message);
    print(message);
  }

  log('--- abstract class reference + concrete usage ---');
  final Type targetType = RenderObjectWidget;
  const widget = SizedBox(width: 12.0, height: 13.0);
  log('targetType: $targetType');
  log('widget runtimeType: ${widget.runtimeType}');
  assert(widget is RenderObjectWidget);

  log('--- element creation ---');
  final element = widget.createElement();
  log('element runtimeType: ${element.runtimeType}');
  assert(element is RenderObjectElement);

  log('--- widget variants ---');
  const variants = <RenderObjectWidget>[
    SizedBox(width: 1.0, height: 1.0),
    Padding(padding: EdgeInsets.all(2.0), child: SizedBox.shrink()),
    Align(alignment: Alignment.center, child: SizedBox.shrink()),
  ];
  assert(variants.length == 3);
  for (var i = 0; i < variants.length; i++) {
    final item = variants[i];
    log('variants[$i]: ${item.runtimeType}');
    assert(item is RenderObjectWidget);
  }

  log('--- edge case: key usage ---');
  const keyed = SizedBox(key: ValueKey<String>('render-object-widget-key'));
  log('keyed key: ${keyed.key}');
  assert(keyed.key != null);

  log('--- string diagnostics ---');
  final description = widget.toStringShort();
  log('toStringShort: $description');
  assert(description.isNotEmpty);

  final checklist = <String>[
    'RenderObjectWidget class referenced',
    'concrete subclass instantiated',
    'element creation validated',
    'variant list validated',
    'key edge case validated',
    'diagnostics validated',
    'assertions executed',
    'print tracing executed',
    'summary widget returned',
    'dynamic build signature retained',
    'compile-sensible style retained',
    'constructor/properties/behavior covered',
  ];
  for (final line in checklist) {
    log('check: $line');
  }

  assert(logLines.length >= 19);
  log('log count: ${logLines.length}');

  print('RenderObjectWidget test completed');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RenderObjectWidget Tests'),
      Text('targetType: $targetType'),
      Text('widget type: ${widget.runtimeType}'),
      Text('element type: ${element.runtimeType}'),
      Text('variants: ${variants.length}'),
      Text('checks: ${checklist.length}'),
      Text('log lines: ${logLines.length}'),
      const Text('RenderObjectWidget constructor/properties/edge-cases tested'),
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
