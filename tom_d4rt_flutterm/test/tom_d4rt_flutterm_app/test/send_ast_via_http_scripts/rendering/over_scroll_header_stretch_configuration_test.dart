// D4rt test script: Tests OverScrollHeaderStretchConfiguration from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OverScrollHeaderStretchConfiguration test executing');

  // ========== Basic OverScrollHeaderStretchConfiguration creation ==========
  print('--- Basic OverScrollHeaderStretchConfiguration ---');
  final config1 = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 100.0,
  );
  print('  created: ${config1.runtimeType}');
  print('  stretchTriggerOffset: ${config1.stretchTriggerOffset}');

  // ========== Different stretchTriggerOffset values ==========
  print('--- Different stretchTriggerOffset values ---');
  final config50 = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 50.0,
  );
  print('  stretchTriggerOffset = 50: ${config50.stretchTriggerOffset}');

  final config100 = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 100.0,
  );
  print('  stretchTriggerOffset = 100: ${config100.stretchTriggerOffset}');

  final config150 = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 150.0,
  );
  print('  stretchTriggerOffset = 150: ${config150.stretchTriggerOffset}');

  final config200 = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 200.0,
  );
  print('  stretchTriggerOffset = 200: ${config200.stretchTriggerOffset}');

  // ========== onStretchTrigger callback ==========
  print('--- onStretchTrigger callback ---');
  bool triggered = false;
  final configWithCallback = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 100.0,
    onStretchTrigger: () async {
      triggered = true;
      print('  Stretch trigger activated!');
      return;
    },
  );
  print('  config with callback: ${configWithCallback.runtimeType}');
  print(
    '  has onStretchTrigger: ${configWithCallback.onStretchTrigger != null}',
  );

  // ========== Callback variations ==========
  print('--- Callback variations ---');
  int callCount = 0;
  final configCounter = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 80.0,
    onStretchTrigger: () async {
      callCount++;
      print('  callback count: $callCount');
    },
  );
  print(
    '  counter config: stretchTriggerOffset=${configCounter.stretchTriggerOffset}',
  );

  final configNoCallback = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 120.0,
  );
  print('  no callback config: ${configNoCallback.onStretchTrigger == null}');

  // ========== Small offset values ==========
  print('--- Small offset values ---');
  final config10 = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 10.0,
  );
  print('  small offset (10): ${config10.stretchTriggerOffset}');

  final config25 = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 25.0,
  );
  print('  small offset (25): ${config25.stretchTriggerOffset}');

  // ========== Large offset values ==========
  print('--- Large offset values ---');
  final config300 = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 300.0,
  );
  print('  large offset (300): ${config300.stretchTriggerOffset}');

  final config500 = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 500.0,
  );
  print('  large offset (500): ${config500.stretchTriggerOffset}');

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  config1.runtimeType: ${config1.runtimeType}');
  print('  configWithCallback.runtimeType: ${configWithCallback.runtimeType}');

  // ========== Multiple configurations ==========
  print('--- Multiple configurations ---');
  final offsets = [50.0, 75.0, 100.0, 125.0, 150.0];
  final configs = offsets.map((offset) {
    return OverScrollHeaderStretchConfiguration(
      stretchTriggerOffset: offset,
      onStretchTrigger: () async {
        print('  triggered at offset $offset');
      },
    );
  }).toList();
  for (int i = 0; i < configs.length; i++) {
    print('  config $i: offset=${configs[i].stretchTriggerOffset}');
  }

  print('OverScrollHeaderStretchConfiguration test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'OverScrollHeaderStretchConfiguration Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Type: ${config1.runtimeType}'),
          Text('stretchTriggerOffset: ${config1.stretchTriggerOffset}'),
          SizedBox(height: 8.0),
          Text('Different offsets:'),
          Text('  50.0: ${config50.stretchTriggerOffset}'),
          Text('  100.0: ${config100.stretchTriggerOffset}'),
          Text('  150.0: ${config150.stretchTriggerOffset}'),
          Text('  200.0: ${config200.stretchTriggerOffset}'),
          SizedBox(height: 8.0),
          Text('With callback: ${configWithCallback.onStretchTrigger != null}'),
          Text('No callback: ${configNoCallback.onStretchTrigger == null}'),
          SizedBox(height: 8.0),
          Text('Use case: SliverAppBar stretch effect'),
          Text('Triggers refresh on overscroll'),
        ],
      ),
    ),
  );
}
