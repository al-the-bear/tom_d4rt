// D4rt test script: Tests Cupertino form controls from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino controls test executing');

  // ========== CupertinoFormSection ==========
  print('--- CupertinoFormSection ---');
  final formSection = CupertinoFormSection(
    header: Text('Account Settings'),
    footer: Text('Changes are saved automatically'),
    children: [
      CupertinoFormRow(
        prefix: Text('Username'),
        child: CupertinoTextField(placeholder: 'Enter username'),
      ),
      CupertinoFormRow(
        prefix: Text('Email'),
        child: CupertinoTextField(placeholder: 'Enter email'),
      ),
    ],
  );
  print('  formSection created');

  // ========== CupertinoFormSection.insetGrouped ==========
  print('--- CupertinoFormSection.insetGrouped ---');
  final insetGrouped = CupertinoFormSection.insetGrouped(
    header: Text('Preferences'),
    children: [
      CupertinoFormRow(
        prefix: Text('Notifications'),
        child: CupertinoSwitch(value: true, onChanged: (v) { print('switch: $v'); }),
      ),
      CupertinoFormRow(
        prefix: Text('Dark Mode'),
        child: CupertinoSwitch(value: false, onChanged: (v) { print('dark: $v'); }),
      ),
    ],
  );
  print('  insetGrouped created');

  // ========== CupertinoListSection ==========
  print('--- CupertinoListSection ---');
  final listSection = CupertinoListSection(
    header: Text('Items'),
    children: [
      CupertinoListTile(
        title: Text('Item 1'),
        leading: Icon(CupertinoIcons.star),
        trailing: CupertinoListTileChevron(),
      ),
      CupertinoListTile(
        title: Text('Item 2'),
        subtitle: Text('With subtitle'),
        leading: Icon(CupertinoIcons.heart),
        trailing: CupertinoListTileChevron(),
      ),
      CupertinoListTile(
        title: Text('Item 3'),
        additionalInfo: Text('Info'),
        trailing: CupertinoListTileChevron(),
      ),
    ],
  );
  print('  listSection created');

  // ========== CupertinoListSection.insetGrouped ==========
  print('--- CupertinoListSection.insetGrouped ---');
  final insetList = CupertinoListSection.insetGrouped(
    header: Text('Settings'),
    footer: Text('Tap to configure'),
    children: [
      CupertinoListTile(
        title: Text('General'),
        leading: Icon(CupertinoIcons.gear),
      ),
      CupertinoListTile(
        title: Text('Privacy'),
        leading: Icon(CupertinoIcons.lock),
      ),
    ],
  );
  print('  insetList created');

  // ========== CupertinoListTile variants ==========
  print('--- CupertinoListTile variants ---');
  final basicTile = CupertinoListTile(title: Text('Basic'));
  print('  basic tile created');

  final notchedTile = CupertinoListTile.notched(
    title: Text('Notched Tile'),
    leading: Icon(CupertinoIcons.person),
    subtitle: Text('A notched variant'),
    trailing: CupertinoListTileChevron(),
  );
  print('  notched tile created');

  print('Cupertino controls test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Controls Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              formSection,
              SizedBox(height: 16.0),
              insetGrouped,
              SizedBox(height: 16.0),
              listSection,
              SizedBox(height: 16.0),
              insetList,
            ],
          ),
        ),
      ),
    ),
  );
}
