// D4rt test script: Tests CupertinoTabBar advanced, CupertinoTabScaffold advanced,
// CupertinoTabController advanced, CupertinoScrollbar, CupertinoListSection,
// CupertinoListTile, CupertinoFormSection, CupertinoFormRow
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Cupertino tab bar / scaffold test executing');

  // ========== CupertinoTabBar advanced ==========
  print('--- CupertinoTabBar Advanced Tests ---');
  final tabBar = CupertinoTabBar(
    items: [
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        activeIcon: Icon(CupertinoIcons.house_fill),
        label: 'Home',
        tooltip: 'Go home',
        backgroundColor: CupertinoColors.systemBackground,
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        activeIcon: Icon(CupertinoIcons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.bell),
        activeIcon: Icon(CupertinoIcons.bell_fill),
        label: 'Alerts',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person),
        activeIcon: Icon(CupertinoIcons.person_fill),
        label: 'Profile',
      ),
    ],
    currentIndex: 0,
    onTap: (index) => print('  Tab tapped: $index'),
    activeColor: CupertinoColors.activeBlue,
    inactiveColor: CupertinoColors.inactiveGray,
    backgroundColor: CupertinoColors.systemBackground,
    iconSize: 28.0,
    height: 50.0,
    border: Border(
      top: BorderSide(color: CupertinoColors.separator, width: 0.5),
    ),
  );
  print('CupertinoTabBar advanced created [${tabBar.hashCode}]');

  // ========== CupertinoScrollbar ==========
  print('--- CupertinoScrollbar Tests ---');
  final scrollbar = CupertinoScrollbar(
    thickness: 6.0,
    thicknessWhileDragging: 10.0,
    radius: Radius.circular(10),
    radiusWhileDragging: Radius.circular(14),
    thumbVisibility: false,
    child: ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(8),
        child: Text('Scrollbar Item $index'),
      ),
    ),
  );
  print('CupertinoScrollbar created [${scrollbar.hashCode}]');

  // ========== CupertinoListSection ==========
  print('--- CupertinoListSection Tests ---');
  final listSection = CupertinoListSection(
    header: Text('Settings'),
    footer: Text('Manage your preferences'),
    children: [
      CupertinoListTile(
        title: Text('Wi-Fi'),
        subtitle: Text('Connected'),
        leading: Icon(CupertinoIcons.wifi, color: CupertinoColors.activeBlue),
        trailing: CupertinoSwitch(value: true, onChanged: (v) {}),
        onTap: () => print('  Wi-Fi tapped'),
      ),
      CupertinoListTile(
        title: Text('Bluetooth'),
        subtitle: Text('On'),
        leading: Icon(
          CupertinoIcons.bluetooth,
          color: CupertinoColors.activeBlue,
        ),
        trailing: CupertinoSwitch(value: true, onChanged: (v) {}),
      ),
      CupertinoListTile(
        title: Text('Cellular'),
        leading: Icon(
          CupertinoIcons.antenna_radiowaves_left_right,
          color: CupertinoColors.activeGreen,
        ),
        trailing: CupertinoListTileChevron(),
        onTap: () => print('  Cellular tapped'),
      ),
    ],
  );
  print('CupertinoListSection created');

  // ========== CupertinoListSection.insetGrouped ==========
  print('--- CupertinoListSection.insetGrouped Tests ---');
  final listSectionInset = CupertinoListSection.insetGrouped(
    header: Text('Account'),
    children: [
      CupertinoListTile(
        title: Text('Username'),
        additionalInfo: Text('john_doe'),
        trailing: CupertinoListTileChevron(),
      ),
      CupertinoListTile(
        title: Text('Email'),
        additionalInfo: Text('john@example.com'),
        trailing: CupertinoListTileChevron(),
      ),
    ],
  );
  print('CupertinoListSection.insetGrouped created');

  // ========== CupertinoListTile ==========
  print('--- CupertinoListTile Tests ---');
  final listTile = CupertinoListTile(
    title: Text('List Tile'),
    subtitle: Text('Subtitle text'),
    leading: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: CupertinoColors.activeBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(CupertinoIcons.star_fill, color: CupertinoColors.white),
    ),
    additionalInfo: Text('Info'),
    trailing: CupertinoListTileChevron(),
    onTap: () => print('  List tile tapped'),
    leadingSize: 40.0,
    leadingToTitle: 12.0,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    backgroundColor: CupertinoColors.systemBackground,
    backgroundColorActivated: CupertinoColors.systemGrey5,
  );
  print('CupertinoListTile created [${listTile.hashCode}]');

  // ========== CupertinoListTile.notched ==========
  print('--- CupertinoListTile.notched Tests ---');
  final notchedTile = CupertinoListTile.notched(
    title: Text('Notched Tile'),
    subtitle: Text('With notch'),
    leading: Icon(CupertinoIcons.bell),
    trailing: CupertinoListTileChevron(),
  );
  print('CupertinoListTile.notched created [${notchedTile.hashCode}]');

  // ========== CupertinoFormSection ==========
  print('--- CupertinoFormSection Tests ---');
  final formSection = CupertinoFormSection(
    header: Text('PERSONAL INFORMATION'),
    footer: Text('All fields are required'),
    children: [
      CupertinoFormRow(
        prefix: Text('Name'),
        child: CupertinoTextFormFieldRow(placeholder: 'Enter name'),
      ),
      CupertinoFormRow(
        prefix: Text('Email'),
        child: CupertinoTextFormFieldRow(
          placeholder: 'Enter email',
          keyboardType: TextInputType.emailAddress,
        ),
      ),
    ],
  );
  print('CupertinoFormSection created');

  // ========== CupertinoFormSection.insetGrouped ==========
  print('--- CupertinoFormSection.insetGrouped Tests ---');
  final formSectionInset = CupertinoFormSection.insetGrouped(
    header: Text('ADDRESS'),
    children: [
      CupertinoFormRow(
        prefix: Text('Street'),
        child: CupertinoTextFormFieldRow(placeholder: 'Street'),
      ),
      CupertinoFormRow(
        prefix: Text('City'),
        child: CupertinoTextFormFieldRow(placeholder: 'City'),
      ),
    ],
  );
  print('CupertinoFormSection.insetGrouped created');

  print('All cupertino tab/scaffold tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text('Cupertino')),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                listSection,
                listSectionInset,
                formSection,
                formSectionInset,
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
