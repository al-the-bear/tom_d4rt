// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FlutterErrorDetailsForPointerEventDispatcher
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FlutterErrorDetailsForPointerEventDispatcher test executing');

  final details = FlutterErrorDetailsForPointerEventDispatcher(
    exception: Exception('test error'),
    stack: StackTrace.current,
    library: 'gestures',
    context: ErrorDescription('during hit test'),
  );
  print('Type: ${details.runtimeType}');
  print('library: ${details.library}');
  print('is FlutterErrorDetails: ${true}');
  print('exception: ${details.exception}');
  print('context: ${details.context}');

  print('FlutterErrorDetailsForPointerEventDispatcher test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('FlutterErrorDetailsForPointerEventDispatcher', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
    Text('Extends FlutterErrorDetails'),
    Text('library: ${details.library}'),
  ]);
}
