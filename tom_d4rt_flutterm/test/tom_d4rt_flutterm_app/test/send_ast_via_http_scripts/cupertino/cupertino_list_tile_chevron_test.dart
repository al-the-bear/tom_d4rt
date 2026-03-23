// ignore_for_file: avoid_print
// D4rt test script: Tests CupertinoListTileChevron from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoListTileChevron test executing');

  // ===== 1. Standalone chevron =====
  print('--- Standalone CupertinoListTileChevron ---');
  final standalone = CupertinoListTileChevron();
  print('  standalone chevron created');
  print('  runtimeType: ${standalone.runtimeType}');

  // ===== 2. Inside a CupertinoListTile trailing =====
  print('--- As CupertinoListTile trailing ---');
  final tileWithChevron = CupertinoListTile(
    title: Text('Navigate'),
    trailing: CupertinoListTileChevron(),
  );
  print('  tile with trailing chevron created');

  // ===== 3. Multiple tiles with chevrons in a section =====
  print('--- Multiple tiles in section ---');
  final menuItems = ['General', 'Privacy', 'Notifications', 'Sounds', 'Display'];
  final tilesWithChevrons = <CupertinoListTile>[];
  for (final item in menuItems) {
    tilesWithChevrons.add(CupertinoListTile(
      leading: Icon(CupertinoIcons.circle, size: 20.0),
      title: Text(item),
      trailing: CupertinoListTileChevron(),
    ));
  }
  print('  created ${tilesWithChevrons.length} tiles with chevrons');

  // ===== 4. Chevron with additional trailing content =====
  print('--- Chevron alongside other trailing widgets ---');
  final tileWithBadge = CupertinoListTile(
    title: Text('Updates'),
    additionalInfo: Text('3'),
    trailing: CupertinoListTileChevron(),
  );
  print('  tile with badge + chevron created');

  // ===== 5. In notched list tile =====
  print('--- In notched CupertinoListTile ---');
  final notchedTile = CupertinoListTile.notched(
    title: Text('Notched Item'),
    leading: Icon(CupertinoIcons.gear),
    trailing: CupertinoListTileChevron(),
  );
  print('  notched tile with chevron created');

  // ===== 6. Chevron visual comparison: with vs without =====
  print('--- With vs without chevron ---');
  final withChevron = CupertinoListTile(
    title: Text('With chevron'),
    trailing: CupertinoListTileChevron(),
  );
  final withoutChevron = CupertinoListTile(
    title: Text('Without chevron'),
  );
  print('  comparison tiles created');

  print('CupertinoListTileChevron test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('ListTileChevron')),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CupertinoListSection.insetGrouped(
                header: Text('Standalone'),
                children: [
                  CupertinoListTile(
                    title: Text('Chevron widget'),
                    trailing: standalone,
                  ),
                ],
              ),
              CupertinoListSection.insetGrouped(
                header: Text('Basic usage'),
                children: [tileWithChevron],
              ),
              CupertinoListSection.insetGrouped(
                header: Text('Menu items'),
                children: tilesWithChevrons,
              ),
              CupertinoListSection.insetGrouped(
                header: Text('With additional info'),
                children: [tileWithBadge],
              ),
              CupertinoListSection.insetGrouped(
                header: Text('Notched'),
                children: [notchedTile],
              ),
              CupertinoListSection.insetGrouped(
                header: Text('Comparison'),
                children: [withChevron, withoutChevron],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
