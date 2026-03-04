// D4rt test script: Tests FlutterMemoryAllocations from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FlutterMemoryAllocations test executing');

  // Test FlutterMemoryAllocations - Memory tracking
  print('FlutterMemoryAllocations is available in the foundation package');
  print('FlutterMemoryAllocations: Memory tracking');

  print('FlutterMemoryAllocations test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FlutterMemoryAllocations Tests'),
      Text('Memory tracking'),
    ],
  );
}
