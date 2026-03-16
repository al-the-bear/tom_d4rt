// D4rt test script: Tests ObjectEvent from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ObjectEvent test executing');

  // ObjectEvent is abstract, test via subtypes
  final obj1 = Object();
  final created = ObjectCreated(library: 'widgets', className: 'Text', object: obj1);
  print('ObjectCreated is ObjectEvent: ${created is ObjectEvent}');
  print('library: ${created.library}');
  print('className: ${created.className}');

  final obj2 = Object();
  final disposed = ObjectDisposed(object: obj2);
  print('ObjectDisposed is ObjectEvent: ${disposed is ObjectEvent}');

  print('ObjectEvent test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('ObjectEvent Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Abstract base: tested via Created+Disposed'),
    Text('ObjectCreated is ObjectEvent: true'),
    Text('ObjectDisposed is ObjectEvent: true'),
  ]);
}
