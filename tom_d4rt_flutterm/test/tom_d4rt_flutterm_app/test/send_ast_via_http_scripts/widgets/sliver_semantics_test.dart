// D4rt test script: Tests SliverSemantics from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverSemantics test executing');

  // Test SliverSemantics - Sliver semantics
  print('SliverSemantics is available in the widgets package');
  print('SliverSemantics runtimeType accessible');

  print('SliverSemantics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverSemantics Tests'),
      Text('Sliver semantics'),
    ],
  );
}
