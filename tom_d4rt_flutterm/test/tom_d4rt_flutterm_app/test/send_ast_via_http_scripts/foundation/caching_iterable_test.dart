// D4rt test script: Tests CachingIterable from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CachingIterable test executing');

  var callCount = 0;
  Iterable<int> gen() sync* {
    for (var i = 0; i < 5; i++) { callCount++; yield i; }
  }
  final ci = CachingIterable<int>(gen().iterator);
  print('CachingIterable: ${ci.runtimeType}');
  print('first iteration: ${ci.toList()}');
  print('callCount after first: $callCount');
  print('second iteration: ${ci.toList()}');
  print('callCount after second: $callCount'); // Same — cached
  print('length: ${ci.length}');

  print('CachingIterable test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('CachingIterable Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Items: ${ci.toList()}'),
    Text('Cached (callCount stable): $callCount'),
  ]);
}
