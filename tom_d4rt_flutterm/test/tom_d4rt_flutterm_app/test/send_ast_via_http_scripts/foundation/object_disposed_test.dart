// D4rt test script: Tests ObjectDisposed from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ObjectDisposed test executing');

  final obj = Object();
  final event = ObjectDisposed(object: obj);
  print('ObjectDisposed: ${event.runtimeType}');
  print('object: ${event.object}');
  print('is ObjectEvent: ${event is ObjectEvent}');

  print('ObjectDisposed test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('ObjectDisposed Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('object: ${event.object}'),
  ]);
}
