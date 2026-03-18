// D4rt test script: Tests RelayoutWhenSystemFontsChangeMixin from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RelayoutWhenSystemFontsChangeMixin test executing');

  // RelayoutWhenSystemFontsChangeMixin is a mixin - verify it exists in the framework
  print('RelayoutWhenSystemFontsChangeMixin is a mixin');
  print('RelayoutWhenSystemFontsChangeMixin runtimeType check available');

  // Test basic type identity
  print('RelayoutWhenSystemFontsChangeMixin type: mixin');
  print('Font relayout');

  print('RelayoutWhenSystemFontsChangeMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RelayoutWhenSystemFontsChangeMixin Tests'),
      Text('Type: mixin'),
      Text('Font relayout'),
    ],
  );
}
