// ignore_for_file: avoid_print
// D4rt test script: Tests RestorableCupertinoTabController from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('RestorableCupertinoTabController test executing');

  // ===== 1. Default constructor (initialIndex: 0) =====
  print('--- Default RestorableCupertinoTabController ---');
  final defaultCtrl = RestorableCupertinoTabController();
  print('  created: ${defaultCtrl.runtimeType}');

  // ===== 2. With custom initialIndex =====
  print('--- Custom initialIndex ---');
  final ctrl1 = RestorableCupertinoTabController(initialIndex: 1);
  print('  initialIndex: 1 controller created [${ctrl1.hashCode }]');

  final ctrl2 = RestorableCupertinoTabController(initialIndex: 2);
  print('  initialIndex: 2 controller created [${ctrl2.hashCode }]');

  final ctrl3 = RestorableCupertinoTabController(initialIndex: 3);
  print('  initialIndex: 3 controller created [${ctrl3.hashCode }]');

  // ===== 3. CupertinoTabScaffold with default controller =====
  print('--- CupertinoTabScaffold integration ---');
  final tabItems = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: 'Search'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: 'Settings'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: 'Profile'),
  ];
  print('  ${tabItems.length} tab items created');

  // ===== 4. Tab controller with CupertinoTabController =====
  print('--- CupertinoTabController comparison ---');
  final regularCtrl = CupertinoTabController(initialIndex: 0);
  print('  regular controller type: ${regularCtrl.runtimeType}');
  print('  regular controller index: ${regularCtrl.index}');

  final regularCtrl2 = CupertinoTabController(initialIndex: 2);
  print('  regular controller at index 2: ${regularCtrl2.index}');

  // ===== 5. Tab bar items =====
  print('--- CupertinoTabBar ---');
  final tabBar = CupertinoTabBar(
    items: tabItems,
    currentIndex: 0,
  );
  print('  tab bar created with ${tabItems.length} items [${tabBar.hashCode }]');

  // ===== 6. Multiple tab configurations =====
  print('--- Multiple tab configurations ---');
  final twoTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.doc), label: 'Files'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.folder), label: 'Folders'),
  ];
  final fiveTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: 'Search'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.cart), label: 'Cart'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: 'Account'),
  ];
  print('  2-tab config created [${fiveTabs.hashCode }] [${twoTabs.hashCode }]');
  print('  5-tab config created');

  // ===== 7. Tab scaffold with explicit controller =====
  print('--- Tab scaffold ---');
  final tabPages = [
    Center(child: Text('Home Page')),
    Center(child: Text('Search Page')),
    Center(child: Text('Settings Page')),
    Center(child: Text('Profile Page')),
  ];

  regularCtrl.dispose();
  regularCtrl2.dispose();

  print('RestorableCupertinoTabController test completed [${tabPages.hashCode }]');
  return CupertinoApp(
    home: CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: tabItems),
      tabBuilder: (context, index) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Tab $index'),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Tab $index Content', style: TextStyle(fontSize: 20.0)),
                  SizedBox(height: 8.0),
                  Text('RestorableCupertinoTabController'),
                  Text('Supports state restoration'),
                  SizedBox(height: 16.0),
                  Text('Controllers tested:'),
                  Text('  default (index 0)'),
                  Text('  index 1, 2, 3'),
                  Text('  2-tab, 4-tab, 5-tab configs'),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
