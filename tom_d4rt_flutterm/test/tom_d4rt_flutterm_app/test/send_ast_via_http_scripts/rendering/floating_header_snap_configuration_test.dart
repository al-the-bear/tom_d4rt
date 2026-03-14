// D4rt test script: Tests FloatingHeaderSnapConfiguration from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FloatingHeaderSnapConfiguration test executing');

  // ========== Basic FloatingHeaderSnapConfiguration creation ==========
  print('--- Basic FloatingHeaderSnapConfiguration ---');
  final config1 = FloatingHeaderSnapConfiguration(
    curve: Curves.easeInOut,
    duration: Duration(milliseconds: 300),
  );
  print('  created: ${config1.runtimeType}');
  print('  curve: ${config1.curve}');
  print('  duration: ${config1.duration}');

  // ========== Different curves ==========
  print('--- Different curves ---');
  final linearConfig = FloatingHeaderSnapConfiguration(
    curve: Curves.linear,
    duration: Duration(milliseconds: 200),
  );
  print('  linear curve: ${linearConfig.curve}');
  print('  linear duration: ${linearConfig.duration}');

  final bounceConfig = FloatingHeaderSnapConfiguration(
    curve: Curves.bounceOut,
    duration: Duration(milliseconds: 500),
  );
  print('  bounce curve: ${bounceConfig.curve}');
  print('  bounce duration: ${bounceConfig.duration}');

  final elasticConfig = FloatingHeaderSnapConfiguration(
    curve: Curves.elasticOut,
    duration: Duration(milliseconds: 400),
  );
  print('  elastic curve: ${elasticConfig.curve}');
  print('  elastic duration: ${elasticConfig.duration}');

  // ========== Duration variations ==========
  print('--- Duration variations ---');
  final shortDuration = FloatingHeaderSnapConfiguration(
    curve: Curves.easeIn,
    duration: Duration(milliseconds: 100),
  );
  print('  short duration: ${shortDuration.duration.inMilliseconds}ms');

  final longDuration = FloatingHeaderSnapConfiguration(
    curve: Curves.easeOut,
    duration: Duration(milliseconds: 1000),
  );
  print('  long duration: ${longDuration.duration.inMilliseconds}ms');

  final zeroDuration = FloatingHeaderSnapConfiguration(
    curve: Curves.ease,
    duration: Duration.zero,
  );
  print('  zero duration: ${zeroDuration.duration.inMilliseconds}ms');

  // ========== Comparing configurations ==========
  print('--- Comparing configurations ---');
  final configA = FloatingHeaderSnapConfiguration(
    curve: Curves.easeInOut,
    duration: Duration(milliseconds: 300),
  );
  final configB = FloatingHeaderSnapConfiguration(
    curve: Curves.easeInOut,
    duration: Duration(milliseconds: 300),
  );
  print('  configA.curve: ${configA.curve}');
  print('  configB.curve: ${configB.curve}');
  print('  same curve type: ${configA.curve == configB.curve}');
  print('  same duration: ${configA.duration == configB.duration}');

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  config1.runtimeType: ${config1.runtimeType}');
  print('  linearConfig.runtimeType: ${linearConfig.runtimeType}');

  print('FloatingHeaderSnapConfiguration test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'FloatingHeaderSnapConfiguration Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Basic config: ${config1.runtimeType}'),
          Text('Curve: ${config1.curve}'),
          Text('Duration: ${config1.duration.inMilliseconds}ms'),
          Text('Linear curve: ${linearConfig.curve}'),
          Text('Bounce curve: ${bounceConfig.curve}'),
          Text('Short duration: ${shortDuration.duration.inMilliseconds}ms'),
          Text('Long duration: ${longDuration.duration.inMilliseconds}ms'),
        ],
      ),
    ),
  );
}
