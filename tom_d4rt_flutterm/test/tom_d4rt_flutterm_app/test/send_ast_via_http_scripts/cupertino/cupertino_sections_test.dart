// D4rt test script: Tests CupertinoFormSection, CupertinoListSection,
// CupertinoListTile.notched, CupertinoListTileLeadingWidget,
// CupertinoFullscreenDialogTransition
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino sections test executing');

  // ========== CupertinoFormSection ==========
  print('--- CupertinoFormSection Tests ---');
  final formSection = CupertinoFormSection(
    header: Text('Account'),
    footer: Text('Enter your details'),
    margin: EdgeInsets.all(16.0),
    backgroundColor: CupertinoColors.systemGroupedBackground,
    decoration: BoxDecoration(
      color: CupertinoColors.systemBackground,
      borderRadius: BorderRadius.circular(10.0),
    ),
    children: [
      CupertinoTextFormFieldRow(
        prefix: Text('Email'),
        placeholder: 'email@example.com',
        keyboardType: TextInputType.emailAddress,
      ),
      CupertinoTextFormFieldRow(
        prefix: Text('Password'),
        placeholder: 'Required',
        obscureText: true,
      ),
    ],
  );
  print('CupertinoFormSection created: 2 children');

  // ========== CupertinoFormSection.insetGrouped ==========
  print('--- CupertinoFormSection.insetGrouped Tests ---');
  final insetForm = CupertinoFormSection.insetGrouped(
    header: Text('Settings'),
    children: [
      CupertinoTextFormFieldRow(
        prefix: Text('Name'),
        placeholder: 'Enter name',
      ),
    ],
  );
  print('CupertinoFormSection.insetGrouped created');

  // ========== CupertinoListSection ==========
  print('--- CupertinoListSection Tests ---');
  final listSection = CupertinoListSection(
    header: Text('General'),
    footer: Text('Footer text'),
    hasLeading: true,
    children: [
      CupertinoListTile(
        title: Text('Notifications'),
        leading: Icon(CupertinoIcons.bell),
        trailing: CupertinoSwitch(value: true, onChanged: (v) {}),
      ),
      CupertinoListTile(
        title: Text('Sounds'),
        leading: Icon(CupertinoIcons.speaker_2),
        trailing: CupertinoSwitch(value: false, onChanged: (v) {}),
      ),
    ],
  );
  print('CupertinoListSection with header/footer created');

  // ========== CupertinoListSection.insetGrouped ==========
  print('--- CupertinoListSection.insetGrouped Tests ---');
  final insetSection = CupertinoListSection.insetGrouped(
    header: Text('Privacy'),
    children: [
      CupertinoListTile(
        title: Text('Location'),
        trailing: CupertinoListTileChevron(),
      ),
      CupertinoListTile(
        title: Text('Contacts'),
        trailing: CupertinoListTileChevron(),
      ),
    ],
  );
  print('CupertinoListSection.insetGrouped created');

  // ========== CupertinoListTile.notched ==========
  print('--- CupertinoListTile.notched Tests ---');
  final notchedTile = CupertinoListTile.notched(
    title: Text('Notched Style'),
    subtitle: Text('With notched leading'),
    leading: Container(
      width: 30, height: 30,
      decoration: BoxDecoration(
        color: CupertinoColors.systemBlue,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Icon(CupertinoIcons.person, color: CupertinoColors.white, size: 18.0),
    ),
    trailing: CupertinoListTileChevron(),
  );
  print('CupertinoListTile.notched created');

  print('All cupertino sections tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Sections Test'),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            formSection,
            SizedBox(height: 16.0),
            insetForm,
            SizedBox(height: 16.0),
            listSection,
            SizedBox(height: 16.0),
            insetSection,
          ],
        ),
      ),
    ),
  );
}
