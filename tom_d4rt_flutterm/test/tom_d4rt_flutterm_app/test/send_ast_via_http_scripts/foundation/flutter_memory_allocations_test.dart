// ignore_for_file: avoid_print
// D4rt test script: Tests FlutterMemoryAllocations from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FlutterMemoryAllocations test executing');

  final fma = FlutterMemoryAllocations.instance;
  print('FlutterMemoryAllocations: ${fma.runtimeType}');

  var eventCount = 0;
  void listener(ObjectEvent event) {
    eventCount++;
  }

  fma.addListener(listener);
  print('Listener added');

  fma.removeListener(listener);
  print('Listener removed');
  print('Events received: $eventCount');

  print('FlutterMemoryAllocations test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FlutterMemoryAllocations Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Singleton instance'),
      Text('addListener/removeListener OK'),
    ],
  );
}
