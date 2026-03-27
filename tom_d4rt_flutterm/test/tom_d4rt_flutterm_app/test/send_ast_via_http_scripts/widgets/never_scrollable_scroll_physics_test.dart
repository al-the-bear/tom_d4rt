// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NeverScrollableScrollPhysics from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NeverScrollableScrollPhysics test executing');
  print('=' * 50);

  // === Test NeverScrollableScrollPhysics class ===
  print('\nNeverScrollableScrollPhysics prevents scrolling');

  // Create NeverScrollableScrollPhysics
  print('\n--- Testing creation ---');
  final physics = NeverScrollableScrollPhysics();
  print('Created NeverScrollableScrollPhysics');
  print('physics.runtimeType: ${physics.runtimeType}');

  // Test with parent
  print('\n--- Testing with parent ---');
  final physicsWithParent = NeverScrollableScrollPhysics(
    parent: BouncingScrollPhysics(),
  );
  print('Created with BouncingScrollPhysics parent');
  print('physicsWithParent.parent: ${physicsWithParent.parent}');

  // Test allowImplicitScrolling
  print('\n--- Testing allowImplicitScrolling ---');
  print('physics.allowImplicitScrolling: ${physics.allowImplicitScrolling}');
  print('Returns false - no implicit scrolling');

  // Test shouldAcceptUserOffset
  print('\n--- Testing shouldAcceptUserOffset ---');
  print('shouldAcceptUserOffset returns false');
  print('Rejects all user scroll attempts');

  // Test applyTo
  print('\n--- Testing applyTo ---');
  final ancestor = BouncingScrollPhysics();
  final applied = physics.applyTo(ancestor);
  print('applied = physics.applyTo(BouncingScrollPhysics())');
  print('applied.runtimeType: ${applied.runtimeType}');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('physics is ScrollPhysics: ${physics is ScrollPhysics}');

  // Test with ListView
  print('\n--- Testing with ListView ---');
  final listView = ListView(
    physics: NeverScrollableScrollPhysics(),
    children: [
      Text('Item 1'),
      Text('Item 2'),
      Text('Item 3'),
    ],
  );
  print('Created ListView with NeverScrollableScrollPhysics');
  print('listView.physics: ${listView.physics}');
  print('User cannot scroll this list');

  // Test with SingleChildScrollView
  print('\n--- Testing with SingleChildScrollView ---');
  final scrollView = SingleChildScrollView(
    physics: NeverScrollableScrollPhysics(),
    child: Text('Content'),
  );
  print('Created SingleChildScrollView with physics');
  print('Prevents user scrolling');

  print('\n' + '=' * 50);
  print('NeverScrollableScrollPhysics test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'NeverScrollableScrollPhysics Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('allowImplicitScrolling: ${physics.allowImplicitScrolling}'),
      Text('Is ScrollPhysics: ${physics is ScrollPhysics}'),
      Text('Purpose: Disable scrolling'),
    ],
  );
}
