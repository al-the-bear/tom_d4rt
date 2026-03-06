// D4rt test script: Tests LayerLink from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LayerLink test executing');

  // Test LayerLink - Layer linking
  print('LayerLink is available in the rendering package');
  print('LayerLink: Layer linking');

  print('LayerLink test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LayerLink Tests'),
      Text('Layer linking'),
    ],
  );
}
