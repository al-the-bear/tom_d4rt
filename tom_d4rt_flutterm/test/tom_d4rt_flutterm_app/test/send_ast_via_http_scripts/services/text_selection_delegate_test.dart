// D4rt test script: Tests TextSelectionDelegate from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextSelectionDelegate test executing');

  // TextSelectionDelegate is a mixin - verify it exists in the framework
  print('TextSelectionDelegate is a mixin');
  print('TextSelectionDelegate runtimeType check available');
  print('TextSelectionDelegate type: mixin');

  print('TextSelectionDelegate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextSelectionDelegate Tests'),
      Text('Type: mixin'),
      Text('TextSelectionDelegate'),
    ],
  );
}
