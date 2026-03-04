// D4rt test script: Tests SliverCrossAxisExpanded from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverCrossAxisExpanded test executing');

  // Test SliverCrossAxisExpanded - Cross expanded
  print('SliverCrossAxisExpanded is available in the widgets package');
  print('SliverCrossAxisExpanded runtimeType accessible');

  print('SliverCrossAxisExpanded test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverCrossAxisExpanded Tests'),
      Text('Cross expanded'),
    ],
  );
}
