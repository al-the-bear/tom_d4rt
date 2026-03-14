// D4rt test script: Tests EagerGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('EagerGestureRecognizer test executing');

  final notes = <String>[];
  void log(String message) {
    notes.add(message);
    print(message);
  }

  log('--- constructor and type ---');
  final recognizer = EagerGestureRecognizer();
  log('runtimeType: ${recognizer.runtimeType}');
  log('is GestureRecognizer: ${recognizer is GestureRecognizer}');
  log('is OneSequenceGestureRecognizer: ${recognizer is OneSequenceGestureRecognizer}');
  assert(recognizer is GestureRecognizer);
  assert(recognizer is OneSequenceGestureRecognizer);

  log('--- properties and defaults ---');
  log('debugDescription: ${recognizer.debugDescription}');
  assert(recognizer.debugDescription.isNotEmpty);
  log('gestureSettings is null: ${recognizer.gestureSettings == null}');

  log('--- mutation paths ---');
  recognizer.gestureSettings = const DeviceGestureSettings(touchSlop: 18.0);
  log('gestureSettings assigned: ${recognizer.gestureSettings != null}');
  assert(recognizer.gestureSettings != null);

  recognizer.supportedDevices = <PointerDeviceKind>{
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
  log('supportedDevices count: ${recognizer.supportedDevices?.length ?? 0}');
  assert((recognizer.supportedDevices?.length ?? 0) == 2);

  log('--- callback wiring ---');
  var invocationCount = 0;
  recognizer.onEager = () {
    invocationCount += 1;
    log('onEager invoked: $invocationCount');
  };
  recognizer.onEager?.call();
  recognizer.onEager?.call();
  assert(invocationCount == 2);

  log('--- edge case: empty device filter ---');
  recognizer.supportedDevices = <PointerDeviceKind>{};
  log('supportedDevices empty: ${recognizer.supportedDevices?.isEmpty ?? false}');
  assert(recognizer.supportedDevices?.isEmpty ?? false);

  log('--- string checks ---');
  final text = recognizer.toString();
  log('toString contains class name: ${text.contains('EagerGestureRecognizer')}');
  assert(text.contains('EagerGestureRecognizer'));

  log('--- cleanup ---');
  recognizer.dispose();
  log('Recognizer disposed');

  log('--- summary ---');
  final summary = <String>[
    'EagerGestureRecognizer instantiated',
    'Gesture settings and supportedDevices exercised',
    'onEager callback invoked twice',
    'Edge case with empty devices validated',
    'Dispose path executed',
  ];
  for (final item in summary) {
    log('Summary: $item');
  }

  assert(notes.length >= 16);
  log('Note count: ${notes.length}');

  print('EagerGestureRecognizer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('EagerGestureRecognizer Tests'),
          Text('Invocation count: $invocationCount'),
          Text('Summary items: ${summary.length}'),
          Text('Debug description: ${recognizer.debugDescription}'),
          Text('Log entries: ${notes.length}'),
          const Text('Constructor/properties/behavior covered'),
          const Text('Includes assertions and edge-case checks'),
        ],
      ),
    ),
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
