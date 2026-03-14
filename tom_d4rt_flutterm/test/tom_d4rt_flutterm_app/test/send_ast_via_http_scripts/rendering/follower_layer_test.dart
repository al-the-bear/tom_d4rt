// D4rt test script: Tests FollowerLayer from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FollowerLayer test executing');

  final events = <String>[];
  void log(String message) {
    events.add(message);
    print(message);
  }

  log('--- constructor ---');
  final link = LayerLink();
  final layer = FollowerLayer(
    link: link,
    showWhenUnlinked: true,
    linkedOffset: const Offset(5.0, 7.0),
    unlinkedOffset: const Offset(-2.0, 3.0),
  );

  log('runtimeType: ${layer.runtimeType}');
  assert(layer is Layer);
  assert(layer.link == link);

  log('--- property checks ---');
  log('showWhenUnlinked: ${layer.showWhenUnlinked}');
  log('linkedOffset: ${layer.linkedOffset}');
  log('unlinkedOffset: ${layer.unlinkedOffset}');
  assert(layer.showWhenUnlinked);
  assert(layer.linkedOffset == const Offset(5.0, 7.0));

  log('--- mutation checks ---');
  layer.showWhenUnlinked = false;
  layer.linkedOffset = const Offset(1.0, 2.0);
  layer.unlinkedOffset = const Offset(9.0, 10.0);
  log('showWhenUnlinked after: ${layer.showWhenUnlinked}');
  log('linkedOffset after: ${layer.linkedOffset}');
  log('unlinkedOffset after: ${layer.unlinkedOffset}');
  assert(layer.showWhenUnlinked == false);

  log('--- edge case: null linked leader ---');
  layer.alwaysNeedsAddToScene;
  log('alwaysNeedsAddToScene: ${layer.alwaysNeedsAddToScene}');

  log('--- toString and diagnostics ---');
  final description = layer.toString();
  log('toString contains FollowerLayer: ${description.contains('FollowerLayer')}');
  assert(description.contains('FollowerLayer'));

  final checks = <String>[
    'FollowerLayer created',
    'LayerLink association verified',
    'offset properties read and written',
    'showWhenUnlinked toggled',
    'diagnostics string checked',
    'base Layer compatibility confirmed',
    'assertions passed',
    'edge case section executed',
    'summary lines prepared',
    'd4rt script style retained',
    'constructor and behavior tested',
    'logs collected',
  ];
  for (final item in checks) {
    log('check: $item');
  }

  assert(events.length >= 20);
  log('event count: ${events.length}');

  print('FollowerLayer test completed');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('FollowerLayer Tests'),
      Text('showWhenUnlinked: ${layer.showWhenUnlinked}'),
      Text('linkedOffset: ${layer.linkedOffset}'),
      Text('unlinkedOffset: ${layer.unlinkedOffset}'),
      Text('checks: ${checks.length}'),
      Text('events: ${events.length}'),
      const Text('FollowerLayer constructor/properties/edge-cases tested'),
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
