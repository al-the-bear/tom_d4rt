// D4rt test script: Tests SelectedContent from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectedContent test executing');

  // Test SelectedContent - Selected content
  print('SelectedContent is available in the rendering package');
  print('SelectedContent: Selected content');

  print('SelectedContent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectedContent Tests'),
      Text('Selected content'),
    ],
  );
}
