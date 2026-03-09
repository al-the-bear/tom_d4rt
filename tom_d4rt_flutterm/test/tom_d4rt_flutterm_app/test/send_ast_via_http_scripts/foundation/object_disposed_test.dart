// D4rt test script: Tests ObjectDisposed from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ObjectDisposed test executing');

  final event = ObjectDisposed(library: 'test', className: 'MyWidget');
  print('ObjectDisposed: ${event.runtimeType}');
  print('library: ${event.library}');
  print('className: ${event.className}');
  print('is ObjectEvent: ${event is ObjectEvent}');

  print('ObjectDisposed test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('ObjectDisposed Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('library: ${event.library}'),
    Text('className: ${event.className}'),
  ]);
}
