// ignore_for_file: avoid_print
// D4rt test script: Tests ExpansionTile from Flutter material (focused coverage)
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ExpansionTile focused test executing');

  // Variation 1: Basic ExpansionTile
  final widget1 = ExpansionTile(
    title: Text('Basic Tile'),
    children: [
      ListTile(title: Text('Child 1')),
      ListTile(title: Text('Child 2')),
    ],
  );
  print('ExpansionTile(basic) created');

  // Variation 2: ExpansionTile with subtitle
  final widget2 = ExpansionTile(
    title: Text('Titled Tile'),
    subtitle: Text('Subtitle text'),
    children: [
      Padding(padding: EdgeInsets.all(16.0), child: Text('Expandable content')),
    ],
  );
  print('ExpansionTile(subtitle) created');

  // Variation 3: ExpansionTile with leading icon
  final widget3 = ExpansionTile(
    leading: Icon(Icons.settings),
    title: Text('Settings'),
    children: [
      ListTile(leading: Icon(Icons.volume_up), title: Text('Sound')),
      ListTile(leading: Icon(Icons.brightness_6), title: Text('Display')),
    ],
  );
  print('ExpansionTile(leading: Icon) created');

  // Variation 4: ExpansionTile with trailing
  final widget4 = ExpansionTile(
    title: Text('Custom Trailing'),
    trailing: Icon(Icons.arrow_downward, color: Colors.blue),
    children: [ListTile(title: Text('Content'))],
  );
  print('ExpansionTile(trailing: custom Icon) created');

  // Variation 5: ExpansionTile initiallyExpanded
  final widget5 = ExpansionTile(
    title: Text('Expanded By Default'),
    initiallyExpanded: true,
    children: [
      Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.green.shade50,
        child: Text('This content is visible immediately'),
      ),
    ],
  );
  print('ExpansionTile(initiallyExpanded: true) created');

  // Variation 6: ExpansionTile with backgroundColor and collapsedBackgroundColor
  final widget6 = ExpansionTile(
    title: Text('Colored Tile'),
    backgroundColor: Colors.blue.shade50,
    collapsedBackgroundColor: Colors.grey.shade100,
    children: [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Colored expanded content'),
      ),
    ],
  );
  print('ExpansionTile(backgroundColor, collapsedBackgroundColor) created');

  // Variation 7: ExpansionTile with textColor and collapsedTextColor
  final widget7 = ExpansionTile(
    title: Text('Styled Text'),
    textColor: Colors.blue,
    collapsedTextColor: Colors.grey,
    iconColor: Colors.blue,
    collapsedIconColor: Colors.grey,
    children: [ListTile(title: Text('Styled child'))],
  );
  print(
    'ExpansionTile(textColor, collapsedTextColor, iconColor, collapsedIconColor) created',
  );

  // Variation 8: ExpansionTile with tilePadding and childrenPadding
  final widget8 = ExpansionTile(
    title: Text('Padded Tile'),
    tilePadding: EdgeInsets.symmetric(horizontal: 24.0),
    childrenPadding: EdgeInsets.all(16.0),
    expandedCrossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Child with padding'),
      SizedBox(height: 8),
      Text('Another child'),
    ],
  );
  print(
    'ExpansionTile(tilePadding, childrenPadding, expandedCrossAxisAlignment) created',
  );

  // Variation 9: ExpansionTile with controlAffinity
  final widget9 = ExpansionTile(
    title: Text('Leading Control'),
    controlAffinity: ListTileControlAffinity.leading,
    children: [ListTile(title: Text('Expansion arrow on the left'))],
  );
  print('ExpansionTile(controlAffinity: leading) created');

  // Variation 10: ExpansionTile with shape and collapsedShape
  final widget10 = ExpansionTile(
    title: Text('Shaped Tile'),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      side: BorderSide(color: Colors.blue),
    ),
    collapsedShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      side: BorderSide(color: Colors.grey),
    ),
    children: [ListTile(title: Text('Shaped content'))],
  );
  print('ExpansionTile(shape, collapsedShape) created');

  // Variation 11: ExpansionTile with onExpansionChanged callback
  final widget11 = ExpansionTile(
    title: Text('Callback Tile'),
    onExpansionChanged: (bool expanded) {
      print('Expansion changed: $expanded');
    },
    children: [ListTile(title: Text('Tracked expansion'))],
  );
  print('ExpansionTile(onExpansionChanged) created');

  print('ExpansionTile focused test completed');
  return SingleChildScrollView(
    child: Column(
      children: [
        widget1,
        widget2,
        widget3,
        widget4,
        widget5,
        widget6,
        widget7,
        widget8,
        widget9,
        widget10,
        widget11,
      ],
    ),
  );
}
