// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests MaterialBannerClosedReason from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialBannerClosedReason test executing');
  print('=' * 50);

  // MaterialBannerClosedReason is an enum with 4 values
  print('MaterialBannerClosedReason enum values:');
  for (final reason in MaterialBannerClosedReason.values) {
    print('  ${reason.name}: index=${reason.index}');
  }
  print('MaterialBannerClosedReason has ${MaterialBannerClosedReason.values.length} values');

  // Test first and last
  final first = MaterialBannerClosedReason.values.first;
  final last = MaterialBannerClosedReason.values.last;
  print('\nFirst value: $first (index ${first.index})');
  print('Last value: $last (index ${last.index})');

  // Test dismiss
  print('\nTesting MaterialBannerClosedReason.dismiss:');
  final dismiss = MaterialBannerClosedReason.dismiss;
  print('  name: ${dismiss.name}');
  print('  index: ${dismiss.index}');
  print('  toString: $dismiss');
  print('  Cause: SemanticsAction.dismiss');

  // Test swipe
  print('\nTesting MaterialBannerClosedReason.swipe:');
  final swipe = MaterialBannerClosedReason.swipe;
  print('  name: ${swipe.name}');
  print('  index: ${swipe.index}');
  print('  Cause: User swipe gesture');

  // Test hide
  print('\nTesting MaterialBannerClosedReason.hide:');
  final hide = MaterialBannerClosedReason.hide;
  print('  name: ${hide.name}');
  print('  index: ${hide.index}');
  print('  Cause: hideCurrentMaterialBanner() or close callback');

  // Test remove
  print('\nTesting MaterialBannerClosedReason.remove:');
  final remove = MaterialBannerClosedReason.remove;
  print('  name: ${remove.name}');
  print('  index: ${remove.index}');
  print('  Cause: removeCurrentMaterialBanner()');

  // Test equality
  print('\nEquality tests:');
  print('dismiss == dismiss: ${dismiss == dismiss}');
  print('dismiss == swipe: ${dismiss == swipe}');
  print('hide == remove: ${hide == remove}');

  // Usage context
  print('\nUsage context:');
  print('Returned by ScaffoldMessengerState banner methods');
  print('Used in MaterialBannerController.closed Future');

  // Example MaterialBanner
  print('\nMaterialBanner example:');
  final banner = MaterialBanner(
    content: Text('This is a material banner'),
    actions: [
      TextButton(onPressed: () {}, child: Text('OK')),
    ],
  );
  print('MaterialBanner created: ${banner.runtimeType}');

  // Switch statement usage
  String describeReason(MaterialBannerClosedReason reason) {
    switch (reason) {
      case MaterialBannerClosedReason.dismiss:
        return 'Dismissed by accessibility action';
      case MaterialBannerClosedReason.swipe:
        return 'Swiped away by user';
      case MaterialBannerClosedReason.hide:
        return 'Hidden programmatically';
      case MaterialBannerClosedReason.remove:
        return 'Removed from queue';
    }
  }
  print('\nReason descriptions:');
  for (final reason in MaterialBannerClosedReason.values) {
    print('  ${reason.name}: ${describeReason(reason)}');
  }

  // Index ordering
  print('\nIndex ordering:');
  print('dismiss.index: ${dismiss.index}');
  print('swipe.index: ${swipe.index}');
  print('hide.index: ${hide.index}');
  print('remove.index: ${remove.index}');

  print('\n' + '=' * 50);
  print('MaterialBannerClosedReason test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MaterialBannerClosedReason Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Values: ${MaterialBannerClosedReason.values.length}'),
      Text('dismiss, swipe, hide, remove'),
      Text('Used by ScaffoldMessenger'),
    ],
  );
}
