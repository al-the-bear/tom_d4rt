// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MaterialBannerClosedReason from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialBannerClosedReason test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nMaterialBannerClosedReason values:');
  for (final value in MaterialBannerClosedReason.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('MaterialBannerClosedReason has ${MaterialBannerClosedReason.values.length} values');

  // First and last
  final first = MaterialBannerClosedReason.values.first;
  final last = MaterialBannerClosedReason.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('dismiss: ${MaterialBannerClosedReason.dismiss.name} (index ${MaterialBannerClosedReason.dismiss.index})');
  print('swipe: ${MaterialBannerClosedReason.swipe.name} (index ${MaterialBannerClosedReason.swipe.index})');
  print('hide: ${MaterialBannerClosedReason.hide.name} (index ${MaterialBannerClosedReason.hide.index})');
  print('remove: ${MaterialBannerClosedReason.remove.name} (index ${MaterialBannerClosedReason.remove.index})');

  // Usage description
  print('\nUsage context:');
  print('dismiss: Banner was dismissed by the user via an action button');
  print('swipe: Banner was dismissed by swiping (if swipeable)');
  print('hide: Banner was hidden programmatically via ScaffoldMessenger');
  print('remove: Banner was removed programmatically via ScaffoldMessenger');

  // Equality
  print('\nEquality tests:');
  print('dismiss == dismiss: ${MaterialBannerClosedReason.dismiss == MaterialBannerClosedReason.dismiss}');
  print('dismiss == swipe: ${MaterialBannerClosedReason.dismiss == MaterialBannerClosedReason.swipe}');
  print('dismiss == hide: ${MaterialBannerClosedReason.dismiss == MaterialBannerClosedReason.hide}');
  print('dismiss == remove: ${MaterialBannerClosedReason.dismiss == MaterialBannerClosedReason.remove}');
  print('identical: ${identical(MaterialBannerClosedReason.dismiss, MaterialBannerClosedReason.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is MaterialBannerClosedReason: ${first is MaterialBannerClosedReason}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in MaterialBannerClosedReason.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // MaterialBanner widget integration
  print('\nMaterialBanner widget:');
  final banner = MaterialBanner(
    content: Text('This is a banner message'),
    actions: [
      TextButton(onPressed: () {}, child: Text('DISMISS')),
    ],
  );
  print('MaterialBanner created');
  print('runtimeType: ${banner.runtimeType}');
  print('content: ${banner.content.runtimeType}');
  print('actions count: ${banner.actions.length}');

  // MaterialBanner with all properties
  final fullBanner = MaterialBanner(
    content: Text('Full banner with all properties'),
    leading: Icon(Icons.info),
    backgroundColor: Colors.yellow.shade100,
    padding: EdgeInsets.all(16),
    leadingPadding: EdgeInsets.only(right: 16),
    actions: [
      TextButton(onPressed: () {}, child: Text('ACTION 1')),
      TextButton(onPressed: () {}, child: Text('ACTION 2')),
    ],
  );
  print('\nFull MaterialBanner:');
  print('leading: ${fullBanner.leading?.runtimeType}');
  print('backgroundColor: ${fullBanner.backgroundColor}');
  print('padding: ${fullBanner.padding}');
  print('leadingPadding: ${fullBanner.leadingPadding}');
  print('actions count: ${fullBanner.actions.length}');

  print('\n' + '=' * 50);
  print('MaterialBannerClosedReason test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MaterialBannerClosedReason Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${MaterialBannerClosedReason.values.length}'),
      for (final v in MaterialBannerClosedReason.values)
        Text('  ${v.name} (${v.index})'),
      Text('MaterialBanner: basic & full'),
    ],
  );
}
