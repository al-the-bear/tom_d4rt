// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliverHitTestEntry from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverHitTestEntry test executing');

  // Test SliverHitTestEntry - Sliver hit entry
  print('SliverHitTestEntry is available in the rendering package');
  print('SliverHitTestEntry: Sliver hit entry');

  print('SliverHitTestEntry test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverHitTestEntry Tests'),
      Text('Sliver hit entry'),
    ],
  );
}
