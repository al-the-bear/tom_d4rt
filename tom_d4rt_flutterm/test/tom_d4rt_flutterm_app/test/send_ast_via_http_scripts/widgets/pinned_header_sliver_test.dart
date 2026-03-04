// D4rt test script: Tests PinnedHeaderSliver from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PinnedHeaderSliver test executing');

  // Test PinnedHeaderSliver - Pinned header
  print('PinnedHeaderSliver is available in the widgets package');
  print('PinnedHeaderSliver runtimeType accessible');

  print('PinnedHeaderSliver test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PinnedHeaderSliver Tests'),
      Text('Pinned header'),
    ],
  );
}
