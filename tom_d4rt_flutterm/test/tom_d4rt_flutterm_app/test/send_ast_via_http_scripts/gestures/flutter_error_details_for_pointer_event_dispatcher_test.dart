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
  print('is FlutterErrorDetails: ${details is FlutterErrorDetails}');
  print('exception: ${details.exception}');
  print('context: ${details.context}');

  print('FlutterErrorDetailsForPointerEventDispatcher test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('FlutterErrorDetailsForPointerEventDispatcher', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
    Text('Extends FlutterErrorDetails'),
    Text('library: ${details.library}'),
  ]);
}
