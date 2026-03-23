// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Cupertino list widgets overview
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino list widgets test executing');

  // ===== 1. CupertinoListSection default =====
  print('--- CupertinoListSection ---');
  final defaultSection = CupertinoListSection(
    header: Text('Default Section'),
    children: [
      CupertinoListTile(title: Text('Item 1')),
      CupertinoListTile(title: Text('Item 2')),
      CupertinoListTile(title: Text('Item 3')),
    ],
  );
  print('  default section created');

  // ===== 2. CupertinoListSection.insetGrouped =====
  print('--- CupertinoListSection.insetGrouped ---');
  final insetSection = CupertinoListSection.insetGrouped(
    header: Text('Inset Grouped'),
    footer: Text('This is a footer'),
    children: [
      CupertinoListTile(
        leading: Icon(CupertinoIcons.person),
        title: Text('Profile'),
        trailing: CupertinoListTileChevron(),
      ),
      CupertinoListTile(
        leading: Icon(CupertinoIcons.gear),
        title: Text('Settings'),
        trailing: CupertinoListTileChevron(),
      ),
      CupertinoListTile(
        leading: Icon(CupertinoIcons.bell),
        title: Text('Notifications'),
        additionalInfo: Text('3'),
        trailing: CupertinoListTileChevron(),
      ),
    ],
  );
  print('  inset grouped section with footer created');

  // ===== 3. CupertinoListTile variations =====
  print('--- CupertinoListTile variations ---');
  final basicTile = CupertinoListTile(title: Text('Basic'));
  print('  basic tile created');

  final detailTile = CupertinoListTile(
    title: Text('Detail'),
    subtitle: Text('Subtitle text'),
    additionalInfo: Text('Info'),
    trailing: CupertinoListTileChevron(),
  );
  print('  detail tile created');

  final leadingTile = CupertinoListTile(
    leading: Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: CupertinoColors.activeBlue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(child: Icon(CupertinoIcons.star, color: CupertinoColors.white, size: 20.0)),
    ),
    title: Text('With Leading'),
    subtitle: Text('Custom leading widget'),
  );
  print('  leading tile created');

  // ===== 4. CupertinoListTile.notched =====
  print('--- CupertinoListTile.notched ---');
  final notchedTile = CupertinoListTile.notched(
    leading: Icon(CupertinoIcons.wifi),
    title: Text('Wi-Fi'),
    additionalInfo: Text('Connected'),
    trailing: CupertinoListTileChevron(),
  );
  print('  notched tile created');

  // ===== 5. Section with switches and controls =====
  print('--- Interactive list items ---');
  final interactiveSection = CupertinoListSection.insetGrouped(
    header: Text('Preferences'),
    children: [
      CupertinoListTile(
        title: Text('Airplane Mode'),
        leading: Icon(CupertinoIcons.airplane),
        trailing: CupertinoSwitch(value: false, onChanged: (v) {}),
      ),
      CupertinoListTile(
        title: Text('Bluetooth'),
        leading: Icon(CupertinoIcons.bluetooth),
        trailing: CupertinoSwitch(value: true, onChanged: (v) {}),
      ),
      CupertinoListTile(
        title: Text('Dark Mode'),
        leading: Icon(CupertinoIcons.moon),
        trailing: CupertinoSwitch(value: false, onChanged: (v) {}),
      ),
    ],
  );
  print('  interactive section with switches created');

  // ===== 6. Empty section =====
  print('--- Edge cases ---');
  final singleItemSection = CupertinoListSection.insetGrouped(
    children: [
      CupertinoListTile(title: Text('Only item')),
    ],
  );
  print('  single-item section created');

  // ===== 7. Long list =====
  print('--- Long list ---');
  final longItems = <CupertinoListTile>[];
  for (var i = 0; i < 15; i++) {
    longItems.add(CupertinoListTile(
      title: Text('Item $i'),
      trailing: CupertinoListTileChevron(),
    ));
  }
  print('  ${longItems.length}-item list created');

  print('Cupertino list widgets test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('List Widgets')),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              defaultSection,
              insetSection,
              CupertinoListSection.insetGrouped(
                header: Text('Tile Variations'),
                children: [basicTile, detailTile, leadingTile, notchedTile],
              ),
              interactiveSection,
              singleItemSection,
              CupertinoListSection.insetGrouped(
                header: Text('Long List'),
                children: longItems,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
