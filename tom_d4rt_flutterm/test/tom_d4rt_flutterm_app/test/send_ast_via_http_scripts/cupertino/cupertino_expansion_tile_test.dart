// ignore_for_file: avoid_print
// D4rt test script: Tests CupertinoExpansionTile from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoExpansionTile test executing');

  // ===== 1. Basic expansion tile with title and child =====
  print('--- Basic CupertinoExpansionTile ---');
  final basic = CupertinoExpansionTile(
    title: Text('Section Title'),
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Expanded content goes here'),
    ),
  );
  print('  basic tile created');
  print('  title type: ${basic.title.runtimeType}');
  print('  child type: ${basic.child.runtimeType}');

  // ===== 2. With fade transition mode =====
  print('--- Fade transition mode ---');
  final fadeTile = CupertinoExpansionTile(
    title: Text('Fade Section'),
    transitionMode: ExpansionTileTransitionMode.fade,
    child: Column(
      children: [
        Text('Line 1'),
        Text('Line 2'),
        Text('Line 3'),
      ],
    ),
  );
  print('  fade tile created');

  // ===== 3. Multiple tiles in a list =====
  print('--- Multiple expansion tiles ---');
  final tiles = <Widget>[];
  for (var i = 0; i < 5; i++) {
    tiles.add(CupertinoExpansionTile(
      title: Text('Section $i'),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Text('Content for section $i'),
      ),
    ));
  }
  print('  created ${tiles.length} tiles');

  // ===== 4. Rich title with icon and nested list content =====
  print('--- Rich content ---');
  final richTile = CupertinoExpansionTile(
    title: Row(
      children: [
        Icon(CupertinoIcons.settings, size: 20.0),
        SizedBox(width: 8.0),
        Text('Settings'),
      ],
    ),
    child: CupertinoListSection.insetGrouped(
      children: [
        CupertinoListTile(title: Text('General')),
        CupertinoListTile(title: Text('Privacy')),
        CupertinoListTile(title: Text('About')),
      ],
    ),
  );
  print('  rich expansion tile created');

  // ===== 5. Slide transition mode (explicit) =====
  print('--- Slide transition mode ---');
  final slideTile = CupertinoExpansionTile(
    title: Text('Slide Section'),
    transitionMode: ExpansionTileTransitionMode.scroll,
    child: Container(
      height: 100.0,
      color: CupertinoColors.systemGrey5,
      child: Center(child: Text('Slide content')),
    ),
  );
  print('  slide tile created');

  print('CupertinoExpansionTile test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('ExpansionTile Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              basic,
              SizedBox(height: 8.0),
              fadeTile,
              SizedBox(height: 8.0),
              ...tiles,
              SizedBox(height: 8.0),
              richTile,
              SizedBox(height: 8.0),
              slideTile,
            ],
          ),
        ),
      ),
    ),
  );
}
