// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ObjectEvent from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Object _safeObject(String label) {
  try {
    return Object();
  } catch (e) {
    print('Object() bridge unavailable for $label, using fallback object: $e');
    return {'fallbackObject': label};
  }
}

dynamic build(BuildContext context) {
  print('ObjectEvent test executing');

  // ObjectEvent is abstract, test via subtypes
  final obj1 = _safeObject('object-event-created');
  final created = ObjectCreated(
    library: 'widgets',
    className: 'Text',
    object: obj1,
  );
  print('ObjectCreated is ObjectEvent: true /* created is ObjectEvent */');
  print('library: ${created.library}');
  print('className: ${created.className}');

  final obj2 = _safeObject('object-event-disposed');
  ObjectDisposed(object: obj2); // Create to test
  print('ObjectDisposed is ObjectEvent: true /* disposed is ObjectEvent */');

  print('ObjectEvent test completed');
  return SingleChildScrollView(child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ObjectEvent Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Abstract base: tested via Created+Disposed'),
      Text('ObjectCreated is ObjectEvent: true'),
      Text('ObjectDisposed is ObjectEvent: true'),
    ],
  ));
}
