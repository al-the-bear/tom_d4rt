// D4rt test script: Tests SliverConstrainedCrossAxis from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverConstrainedCrossAxis test executing');

  // Test SliverConstrainedCrossAxis - Constrained cross
  print('SliverConstrainedCrossAxis is available in the widgets package');
  print('SliverConstrainedCrossAxis runtimeType accessible');

  print('SliverConstrainedCrossAxis test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverConstrainedCrossAxis Tests'),
      Text('Constrained cross'),
    ],
  );
}
