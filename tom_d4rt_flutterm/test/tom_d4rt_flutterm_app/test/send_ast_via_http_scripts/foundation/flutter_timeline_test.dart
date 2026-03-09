// D4rt test script: Tests FlutterTimeline from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FlutterTimeline test executing');

  // FlutterTimeline is a utility for tracing
  print('FlutterTimeline type: ${FlutterTimeline}');

  // startSync/finishSync
  FlutterTimeline.startSync('test_event');
  FlutterTimeline.finishSync();
  print('startSync/finishSync OK');

  // debugReset
  FlutterTimeline.debugReset();
  print('debugReset OK');

  print('FlutterTimeline test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('FlutterTimeline Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('startSync/finishSync OK'),
    Text('debugReset OK'),
  ]);
}
