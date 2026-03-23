// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MaterialBanner from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialBanner test executing');

  // ========== MATERIALBANNER ==========
  print('--- MaterialBanner Tests ---');

  // Test basic MaterialBanner
  final basicBanner = MaterialBanner(
    content: Text('This is a banner message'),
    actions: [
      TextButton(
        onPressed: () {
          print('Action pressed');
        },
        child: Text('ACTION'),
      ),
    ],
  );
  print('Basic MaterialBanner created');

  // Test MaterialBanner with leading
  final leadingBanner = MaterialBanner(
    leading: Icon(Icons.info),
    content: Text('Banner with leading icon'),
    actions: [TextButton(onPressed: () {}, child: Text('OK'))],
  );
  print('MaterialBanner with leading created');

  // Test MaterialBanner with contentTextStyle
  final styledBanner = MaterialBanner(
    content: Text('Styled banner content'),
    contentTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    ),
    actions: [TextButton(onPressed: () {}, child: Text('DISMISS'))],
  );
  print('MaterialBanner with contentTextStyle created');

  // Test MaterialBanner with backgroundColor
  final backgroundBanner = MaterialBanner(
    backgroundColor: Colors.yellow.shade100,
    content: Text('Banner with custom background'),
    actions: [TextButton(onPressed: () {}, child: Text('GOT IT'))],
  );
  print('MaterialBanner with backgroundColor created');

  // Test MaterialBanner with surfaceTintColor
  final tintBanner = MaterialBanner(
    surfaceTintColor: Colors.purple,
    content: Text('Banner with surface tint'),
    actions: [TextButton(onPressed: () {}, child: Text('OK'))],
  );
  print('MaterialBanner with surfaceTintColor created');

  // Test MaterialBanner with shadowColor
  final shadowBanner = MaterialBanner(
    shadowColor: Colors.black,
    elevation: 4.0,
    content: Text('Banner with shadow'),
    actions: [TextButton(onPressed: () {}, child: Text('CLOSE'))],
  );
  print('MaterialBanner with shadowColor created');

  // Test MaterialBanner with dividerColor
  final dividerBanner = MaterialBanner(
    dividerColor: Colors.red,
    content: Text('Banner with divider color'),
    actions: [TextButton(onPressed: () {}, child: Text('ACTION'))],
  );
  print('MaterialBanner with dividerColor created');

  // Test MaterialBanner with padding
  final paddedBanner = MaterialBanner(
    padding: EdgeInsets.all(24.0),
    content: Text('Banner with custom padding'),
    actions: [TextButton(onPressed: () {}, child: Text('OK'))],
  );
  print('MaterialBanner with padding created');

  // Test MaterialBanner with leadingPadding
  final leadingPaddedBanner = MaterialBanner(
    leading: Icon(Icons.warning),
    leadingPadding: EdgeInsets.only(right: 24.0),
    content: Text('Banner with leading padding'),
    actions: [TextButton(onPressed: () {}, child: Text('DISMISS'))],
  );
  print('MaterialBanner with leadingPadding created');

  // Test MaterialBanner with forceActionsBelow
  final actionsBelowBanner = MaterialBanner(
    forceActionsBelow: true,
    content: Text('Banner with actions forced below'),
    actions: [
      TextButton(onPressed: () {}, child: Text('UNDO')),
      TextButton(onPressed: () {}, child: Text('DISMISS')),
    ],
  );
  print('MaterialBanner with forceActionsBelow created');

  // Test MaterialBanner with overflowAlignment
  final overflowBanner = MaterialBanner(
    forceActionsBelow: true,
    overflowAlignment: OverflowBarAlignment.start,
    content: Text('Banner with overflow alignment'),
    actions: [
      TextButton(onPressed: () {}, child: Text('ACTION 1')),
      TextButton(onPressed: () {}, child: Text('ACTION 2')),
      TextButton(onPressed: () {}, child: Text('ACTION 3')),
    ],
  );
  print('MaterialBanner with overflowAlignment created');

  // Test MaterialBanner with elevation
  final elevatedBanner = MaterialBanner(
    elevation: 8.0,
    content: Text('Elevated banner'),
    actions: [TextButton(onPressed: () {}, child: Text('OK'))],
  );
  print('MaterialBanner with elevation created');

  // Test MaterialBanner with onVisible callback
  final visibleBanner = MaterialBanner(
    onVisible: () {
      print('Banner became visible');
    },
    content: Text('Banner with onVisible callback'),
    actions: [TextButton(onPressed: () {}, child: Text('GOT IT'))],
  );
  print('MaterialBanner with onVisible created');

  // Test MaterialBanner with multiple actions
  final multiActionBanner = MaterialBanner(
    leading: Icon(Icons.new_releases, color: Colors.orange),
    content: Text('Important update available!'),
    actions: [
      TextButton(onPressed: () {}, child: Text('LATER')),
      TextButton(onPressed: () {}, child: Text('UPDATE NOW')),
    ],
  );
  print('MaterialBanner with multiple actions created');

  // Test MaterialBanner with animation
  final animationBanner = MaterialBanner(
    animation: AlwaysStoppedAnimation<double>(1.0),
    content: Text('Banner with animation'),
    actions: [TextButton(onPressed: () {}, child: Text('OK'))],
  );
  print('MaterialBanner with animation created');

  print('MaterialBanner test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'MaterialBanner Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text('Basic Banner:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        basicBanner,

        SizedBox(height: 24.0),
        Text(
          'Banner with Leading:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        leadingBanner,

        SizedBox(height: 24.0),
        Text('Styled Banner:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        styledBanner,

        SizedBox(height: 24.0),
        Text(
          'Banner with Custom Background:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        backgroundBanner,

        SizedBox(height: 24.0),
        Text('Elevated Banner:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        elevatedBanner,

        SizedBox(height: 24.0),
        Text(
          'Banner with Actions Below:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        actionsBelowBanner,

        SizedBox(height: 24.0),
        Text(
          'Multi-Action Banner:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        multiActionBanner,
      ],
    ),
  );
}
