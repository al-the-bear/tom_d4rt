// D4rt test script: Tests ObjectCreated from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ObjectCreated test executing');

  final obj = Object();
  final event = ObjectCreated(library: 'test', className: 'MyClass');
  print('ObjectCreated: ${event.runtimeType}');
  print('library: ${event.library}');
  print('className: ${event.className}');
  print('is ObjectEvent: ${event is ObjectEvent}');

  print('ObjectCreated test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('ObjectCreated Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('library: ${event.library}'),
    Text('className: ${event.className}'),
  ]);
}
