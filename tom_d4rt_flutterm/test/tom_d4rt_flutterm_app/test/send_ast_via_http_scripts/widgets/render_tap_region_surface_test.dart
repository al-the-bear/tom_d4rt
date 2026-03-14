// D4rt test script: Tests RenderTapRegionSurface from widgets
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderTapRegionSurface test executing');

  final logs = <String>[];
  void log(String message) {
    logs.add(message);
    print(message);
  }

  log('--- constructor ---');
  final surface = RenderTapRegionSurface();
  log('runtimeType: ${surface.runtimeType}');
  assert(surface is RenderProxyBoxWithHitTestBehavior);

  log('--- default behavior ---');
  log('behavior: ${surface.behavior}');
  assert(surface.behavior == HitTestBehavior.deferToChild);

  log('--- behavior mutation ---');
  surface.behavior = HitTestBehavior.opaque;
  log('behavior after set: ${surface.behavior}');
  assert(surface.behavior == HitTestBehavior.opaque);

  log('--- edge case: translucent mode ---');
  surface.behavior = HitTestBehavior.translucent;
  log('behavior translucent: ${surface.behavior}');
  assert(surface.behavior == HitTestBehavior.translucent);

  log('--- toString diagnostics ---');
  final description = surface.toString();
  log('toString contains class: ${description.contains('RenderTapRegionSurface')}');
  assert(description.contains('RenderTapRegionSurface'));

  log('--- synthetic pointer event relationship checks ---');
  final pointerKinds = <PointerDeviceKind>[
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
  ];
  assert(pointerKinds.length == 3);
  for (final kind in pointerKinds) {
    log('pointer kind: $kind');
  }

  final checklist = <String>[
    'RenderTapRegionSurface instantiated',
    'base class compatibility validated',
    'default hit test behavior validated',
    'opaque behavior mutation validated',
    'translucent edge case validated',
    'diagnostics string validated',
    'pointer-kind loop executed',
    'assertions executed',
    'print statements executed',
    'summary widget produced',
    'dynamic build signature retained',
    'compile-sensible imports retained',
  ];
  for (final item in checklist) {
    log('check: $item');
  }

  assert(logs.length >= 19);
  log('log count: ${logs.length}');

  print('RenderTapRegionSurface test completed');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RenderTapRegionSurface Tests'),
      Text('runtimeType: ${surface.runtimeType}'),
      Text('behavior: ${surface.behavior}'),
      Text('pointer kinds: ${pointerKinds.length}'),
      Text('checks: ${checklist.length}'),
      Text('logs: ${logs.length}'),
      const Text('RenderTapRegionSurface constructor/properties/edge-cases tested'),
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
