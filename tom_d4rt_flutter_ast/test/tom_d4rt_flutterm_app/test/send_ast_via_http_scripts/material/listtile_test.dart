// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ListTile widget from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ListTile test executing');

  // Test basic ListTile
  final basicTile = ListTile(title: Text('Basic ListTile'));
  print('Basic ListTile created');

  // Test ListTile with subtitle
  final subtitleTile = ListTile(
    title: Text('Title'),
    subtitle: Text('Subtitle text goes here'),
  );
  print('ListTile with subtitle created');

  // Test ListTile with leading
  final leadingTile = ListTile(
    leading: Icon(Icons.person),
    title: Text('With Leading Icon'),
  );
  print('ListTile with leading icon created');

  // Test ListTile with trailing
  final trailingTile = ListTile(
    title: Text('With Trailing'),
    trailing: Icon(Icons.arrow_forward_ios),
  );
  print('ListTile with trailing icon created');

  // Test ListTile with leading and trailing
  final fullTile = ListTile(
    leading: CircleAvatar(child: Text('A')),
    title: Text('Full ListTile'),
    subtitle: Text('With all components'),
    trailing: Icon(Icons.more_vert),
  );
  print('Full ListTile with all components created');

  // Test ListTile with onTap
  final tappableTile = ListTile(
    leading: Icon(Icons.touch_app),
    title: Text('Tappable Tile'),
    onTap: () {
      print('ListTile tapped');
    },
  );
  print('ListTile with onTap created');

  // Test ListTile with onLongPress
  final longPressTile = ListTile(
    title: Text('Long Press Tile'),
    onLongPress: () {
      print('ListTile long pressed');
    },
  );
  print('ListTile with onLongPress created: $longPressTile');

  // Test ListTile with selected
  final selectedTile = ListTile(
    leading: Icon(Icons.check_circle),
    title: Text('Selected Tile'),
    selected: true,
    selectedTileColor: Colors.blue.shade50,
    selectedColor: Colors.blue,
  );
  print('ListTile with selected=true created');

  // Test ListTile with enabled
  final disabledTile = ListTile(title: Text('Disabled Tile'), enabled: false);
  print('ListTile with enabled=false created');

  // Test ListTile with dense
  final denseTile = ListTile(title: Text('Dense Tile'), dense: true);
  print('ListTile with dense=true created');

  // Test ListTile with visualDensity
  final compactTile = ListTile(
    title: Text('Compact Tile'),
    visualDensity: VisualDensity.compact,
  );
  print('ListTile with visualDensity=compact created: $compactTile');

  // Test ListTile with contentPadding
  final paddedTile = ListTile(
    title: Text('Custom Padding'),
    contentPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
  );
  print('ListTile with contentPadding created');

  // Test ListTile with tileColor
  final coloredTile = ListTile(
    title: Text('Colored Tile'),
    tileColor: Colors.amber.shade100,
  );
  print('ListTile with tileColor created');

  // Test ListTile with shape
  final shapedTile = ListTile(
    title: Text('Shaped Tile'),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      side: BorderSide(color: Colors.grey),
    ),
    tileColor: Colors.grey.shade100,
  );
  print('ListTile with shape created');

  // Test ListTile with isThreeLine
  final threeLineTile = ListTile(
    isThreeLine: true,
    leading: CircleAvatar(child: Icon(Icons.email)),
    title: Text('Three Line Tile'),
    subtitle: Text(
      'This is a subtitle that can span multiple lines to show more information about this item',
    ),
  );
  print('ListTile with isThreeLine=true created');

  // Test ListTile with minLeadingWidth
  final minLeadingTile = ListTile(
    leading: Icon(Icons.star),
    title: Text('Min Leading Width'),
    minLeadingWidth: 56.0,
  );
  print('ListTile with minLeadingWidth=56 created: $minLeadingTile');

  // Test ListTile with minVerticalPadding
  final verticalPaddingTile = ListTile(
    title: Text('Vertical Padding'),
    minVerticalPadding: 20.0,
  );
  print('ListTile with minVerticalPadding=20 created: $verticalPaddingTile');

  // Test ListTile with horizontalTitleGap
  final titleGapTile = ListTile(
    leading: Icon(Icons.folder),
    title: Text('Title Gap'),
    horizontalTitleGap: 24.0,
  );
  print('ListTile with horizontalTitleGap=24 created: $titleGapTile');

  // Test ListTile with style
  final styledListTile = ListTile(
    style: ListTileStyle.drawer,
    leading: Icon(Icons.settings),
    title: Text('Drawer Style'),
  );
  print('ListTile with style=drawer created: $styledListTile');

  // Test ListTile with focusColor and hoverColor
  final hoverTile = ListTile(
    title: Text('Hover/Focus Colors'),
    focusColor: Colors.green.withOpacity(0.2),
    hoverColor: Colors.green.withOpacity(0.1),
    onTap: () {},
  );
  print('ListTile with hover/focus colors created: $hoverTile');

  // Test ListTile with splashColor
  final splashTile = ListTile(
    title: Text('Splash Color'),
    splashColor: Colors.purple.withOpacity(0.3),
    onTap: () {},
  );
  print('ListTile with splashColor created: $splashTile');

  print('ListTile test completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'ListTile Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        basicTile,
        Divider(height: 1.0),
        subtitleTile,
        Divider(height: 1.0),
        leadingTile,
        Divider(height: 1.0),
        trailingTile,
        Divider(height: 1.0),
        fullTile,
        Divider(height: 1.0),
        tappableTile,
        Divider(height: 1.0),
        selectedTile,
        Divider(height: 1.0),
        disabledTile,
        Divider(height: 1.0),
        denseTile,
        Divider(height: 1.0),
        coloredTile,
        Divider(height: 1.0),
        shapedTile,
        Divider(height: 1.0),
        threeLineTile,
        Divider(height: 1.0),
        paddedTile,
      ],
    ),
  );
}
