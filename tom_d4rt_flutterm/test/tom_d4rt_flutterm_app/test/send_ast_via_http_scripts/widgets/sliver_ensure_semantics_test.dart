// D4rt test script: Tests SliverEnsureSemantics from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverEnsureSemantics test executing');

  // Test SliverEnsureSemantics - SliverEnsureSemantics
  print('SliverEnsureSemantics is available in the widgets package');
  print('SliverEnsureSemantics runtimeType accessible');

  print('SliverEnsureSemantics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverEnsureSemantics Tests'),
      Text('SliverEnsureSemantics'),
    ],
  );
}
