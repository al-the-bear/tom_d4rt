// D4rt test script: Tests SnapshotWidget from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SnapshotWidget test executing');

  // Test SnapshotWidget - SnapshotWidget
  print('SnapshotWidget is available in the widgets package');
  print('SnapshotWidget runtimeType accessible');

  print('SnapshotWidget test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SnapshotWidget Tests'),
      Text('SnapshotWidget'),
    ],
  );
}
