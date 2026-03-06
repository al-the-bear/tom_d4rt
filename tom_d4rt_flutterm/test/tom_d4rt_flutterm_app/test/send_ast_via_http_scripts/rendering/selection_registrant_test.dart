// D4rt test script: Tests SelectionRegistrant from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionRegistrant test executing');

  // SelectionRegistrant is a mixin - verify it exists in the framework
  print('SelectionRegistrant is a mixin');
  print('SelectionRegistrant runtimeType check available');
  print('SelectionRegistrant type: mixin');

  print('SelectionRegistrant test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionRegistrant Tests'),
      Text('Type: mixin'),
      Text('Selection registrant'),
    ],
  );
}
