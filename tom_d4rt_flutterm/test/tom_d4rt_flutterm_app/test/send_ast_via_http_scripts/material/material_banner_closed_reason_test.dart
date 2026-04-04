// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MaterialBannerClosedReason from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialBannerClosedReason test executing');
  print('=' * 50);

  // MaterialBannerClosedReason enum for banner dismissal
  print('MaterialBannerClosedReason overview:');
  print('  - Enum for MaterialBanner close reasons');
  print('  - Used with ScaffoldMessengerState');
  print('  - Indicates why banner was dismissed');

  // All enum values
  print('\nAll MaterialBannerClosedReason values:');
  for (final value in MaterialBannerClosedReason.values) {
    print('  - ${value.name} (index: ${value.index})');
  }
  print('  Total: ${MaterialBannerClosedReason.values.length} values');

  // Test individual values
  print('\nTesting individual values:');
  const dismiss = MaterialBannerClosedReason.dismiss;
  const swipe = MaterialBannerClosedReason.swipe;
  const hide = MaterialBannerClosedReason.hide;
  const remove = MaterialBannerClosedReason.remove;

  print('  dismiss: $dismiss');
  print('    - User tapped dismiss button');
  print('    - Explicit user action');
  print('    - Most common case');

  print('  swipe: $swipe');
  print('    - User swiped banner away');
  print('    - Gesture-based dismissal');
  print('    - If swipe is enabled');

  print('  hide: $hide');
  print('    - Banner hidden programmatically');
  print('    - Using hideCurrentMaterialBanner');
  print('    - Still in queue');

  print('  remove: $remove');
  print('    - Banner removed programmatically');
  print('    - Using removeCurrentMaterialBanner');
  print('    - Completely removed from queue');

  // Usage with ScaffoldMessenger
  print('\nUsage with ScaffoldMessenger:');
  print('  final controller = ScaffoldMessenger.of(context)');
  print('    .showMaterialBanner(banner);');
  print('  controller.closed.then((reason) {');
  print('    if (reason == MaterialBannerClosedReason.dismiss) {');
  print('      print("User dismissed");');
  print('    }');
  print('  });');

  // First and last
  print('\nFirst and last:');
  final first = MaterialBannerClosedReason.values.first;
  final last = MaterialBannerClosedReason.values.last;
  print('  First: $first (index ${first.index})');
  print('  Last: $last (index ${last.index})');

  // Similar to SnackBarClosedReason
  print('\nSimilar to:');
  print('  SnackBarClosedReason for SnackBar dismissal');

  print('\n' + '=' * 50);
  print('MaterialBannerClosedReason test completed');

  return SingleChildScrollView(child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MaterialBannerClosedReason Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: enum'),
      Text('Values: dismiss, swipe, hide, remove'),
      Text('Use: Banner dismissal reason'),
    ],
  ));
}
