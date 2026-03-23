// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NavigationDestination, NavigationRailDestination, NavigationDrawerDestination, DrawerHeader, UserAccountsDrawerHeader, AboutListTile from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Navigation destinations test executing');

  // ========== NAVIGATIONDESTINATION ==========
  print('--- NavigationDestination Tests ---');

  // Variation 1: Basic NavigationDestination (used inside NavigationBar)
  final widget1 = NavigationBar(
    destinations: [
      NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: 'Home',
      ),
      NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
      NavigationDestination(
        icon: Icon(Icons.person_outline),
        selectedIcon: Icon(Icons.person),
        label: 'Profile',
      ),
    ],
    selectedIndex: 0,
  );
  print('NavigationDestination(3 destinations with selectedIcon) created');

  // Variation 2: NavigationDestination with tooltip
  final widget2 = NavigationBar(
    destinations: [
      NavigationDestination(
        icon: Icon(Icons.dashboard),
        label: 'Dashboard',
        tooltip: 'Go to dashboard',
      ),
      NavigationDestination(
        icon: Icon(Icons.analytics),
        label: 'Analytics',
        tooltip: 'View analytics',
      ),
    ],
    selectedIndex: 1,
  );
  print('NavigationDestination(with tooltip) created');

  // Variation 3: NavigationDestination with enabled false
  final widget3 = NavigationBar(
    destinations: [
      NavigationDestination(
        icon: Icon(Icons.inbox),
        label: 'Inbox',
        enabled: true,
      ),
      NavigationDestination(
        icon: Icon(Icons.drafts),
        label: 'Drafts',
        enabled: false,
      ),
    ],
    selectedIndex: 0,
  );
  print('NavigationDestination(enabled: false) created');

  // ========== NAVIGATIONRAILDESTINATION ==========
  print('--- NavigationRailDestination Tests ---');

  // Variation 4: NavigationRail with NavigationRailDestination
  final widget4 = NavigationRail(
    destinations: [
      NavigationRailDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: Text('Home'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.bookmark_border),
        selectedIcon: Icon(Icons.bookmark),
        label: Text('Bookmarks'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.star_border),
        selectedIcon: Icon(Icons.star),
        label: Text('Favorites'),
      ),
    ],
    selectedIndex: 1,
    onDestinationSelected: (int index) {
      print('Rail destination selected: $index');
    },
  );
  print('NavigationRailDestination(3 destinations with selectedIcon) created');

  // Variation 5: NavigationRailDestination with padding
  final widget5 = NavigationRail(
    destinations: [
      NavigationRailDestination(
        icon: Icon(Icons.folder),
        label: Text('Files'),
        padding: EdgeInsets.symmetric(vertical: 8.0),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.cloud),
        label: Text('Cloud'),
        padding: EdgeInsets.symmetric(vertical: 8.0),
      ),
    ],
    selectedIndex: 0,
    labelType: NavigationRailLabelType.all,
    onDestinationSelected: (int index) {},
  );
  print('NavigationRailDestination(padding, labelType: all) created');

  // Variation 6: NavigationRailDestination with indicatorColor and indicatorShape
  final widget6 = NavigationRail(
    destinations: [
      NavigationRailDestination(
        icon: Icon(Icons.edit),
        selectedIcon: Icon(Icons.edit_note),
        label: Text('Edit'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.delete_outline),
        selectedIcon: Icon(Icons.delete),
        label: Text('Trash'),
      ),
    ],
    selectedIndex: 0,
    indicatorColor: Colors.blue.shade100,
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    onDestinationSelected: (int index) {},
  );
  print('NavigationRail(indicatorColor, indicatorShape) created');

  // ========== NAVIGATIONDRAWERDESTINATION ==========
  print('--- NavigationDrawerDestination Tests ---');

  // Variation 7: NavigationDrawer with NavigationDrawerDestination
  final widget7 = NavigationDrawer(
    selectedIndex: 0,
    onDestinationSelected: (int index) {
      print('Drawer destination selected: $index');
    },
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
        child: Text(
          'Mail',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.inbox_outlined),
        selectedIcon: Icon(Icons.inbox),
        label: Text('Inbox'),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.send_outlined),
        selectedIcon: Icon(Icons.send),
        label: Text('Sent'),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.drafts_outlined),
        selectedIcon: Icon(Icons.drafts),
        label: Text('Drafts'),
      ),
      Divider(),
      Padding(
        padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
        child: Text(
          'Labels',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.label_outline),
        label: Text('Important'),
      ),
    ],
  );
  print('NavigationDrawerDestination(with sections and divider) created');

  // Variation 8: NavigationDrawerDestination with enabled false
  final widget8 = NavigationDrawer(
    selectedIndex: 0,
    onDestinationSelected: (int index) {},
    children: [
      NavigationDrawerDestination(
        icon: Icon(Icons.home),
        label: Text('Active'),
        enabled: true,
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.lock),
        label: Text('Locked'),
        enabled: false,
      ),
    ],
  );
  print('NavigationDrawerDestination(enabled: false) created');

  // ========== DRAWERHEADER ==========
  print('--- DrawerHeader Tests ---');

  // Variation 9: Basic DrawerHeader
  final widget9 = DrawerHeader(
    child: Text(
      'App Name',
      style: TextStyle(fontSize: 24, color: Colors.white),
    ),
    decoration: BoxDecoration(color: Colors.blue),
  );
  print('DrawerHeader(decoration: blue) created');

  // Variation 10: DrawerHeader with gradient
  final widget10 = DrawerHeader(
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [Colors.purple, Colors.blue]),
    ),
    margin: EdgeInsets.zero,
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(radius: 28, child: Text('U')),
        SizedBox(height: 8),
        Text('User Name', style: TextStyle(color: Colors.white, fontSize: 18)),
      ],
    ),
  );
  print('DrawerHeader(gradient, margin, padding) created');

  // Variation 11: DrawerHeader with duration
  final widget11 = DrawerHeader(
    decoration: BoxDecoration(color: Colors.teal),
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    child: Text('Animated Header', style: TextStyle(color: Colors.white)),
  );
  print('DrawerHeader(duration, curve) created');

  // ========== USERACCOUNTSDRAWERHEADER ==========
  print('--- UserAccountsDrawerHeader Tests ---');

  // Variation 12: Basic UserAccountsDrawerHeader
  final widget12 = UserAccountsDrawerHeader(
    accountName: Text('John Doe'),
    accountEmail: Text('john@example.com'),
  );
  print('UserAccountsDrawerHeader(accountName, accountEmail) created');

  // Variation 13: UserAccountsDrawerHeader with pictures
  final widget13 = UserAccountsDrawerHeader(
    accountName: Text('Jane Smith'),
    accountEmail: Text('jane@example.com'),
    currentAccountPicture: CircleAvatar(
      backgroundColor: Colors.white,
      child: Text('JS', style: TextStyle(fontSize: 24)),
    ),
    otherAccountsPictures: [
      CircleAvatar(child: Text('A')),
      CircleAvatar(child: Text('B')),
    ],
  );
  print(
    'UserAccountsDrawerHeader(currentAccountPicture, otherAccountsPictures) created',
  );

  // Variation 14: UserAccountsDrawerHeader with decoration
  final widget14 = UserAccountsDrawerHeader(
    accountName: Text('Alice'),
    accountEmail: Text('alice@test.com'),
    currentAccountPicture: CircleAvatar(
      backgroundColor: Colors.indigo,
      child: Text('A', style: TextStyle(color: Colors.white)),
    ),
    decoration: BoxDecoration(color: Colors.indigo),
    onDetailsPressed: () {
      print('Details pressed');
    },
  );
  print('UserAccountsDrawerHeader(decoration, onDetailsPressed) created');

  // Variation 15: UserAccountsDrawerHeader with arrowColor and margin
  final widget15 = UserAccountsDrawerHeader(
    accountName: Text('Bob'),
    accountEmail: Text('bob@test.com'),
    arrowColor: Colors.yellow,
    margin: EdgeInsets.zero,
    onDetailsPressed: () {},
  );
  print('UserAccountsDrawerHeader(arrowColor, margin) created');

  // ========== ABOUTLISTTILE ==========
  print('--- AboutListTile Tests ---');

  // Variation 16: Basic AboutListTile
  final widget16 = AboutListTile(
    applicationName: 'D4rt App',
    applicationVersion: '1.0.0',
  );
  print('AboutListTile(applicationName, applicationVersion) created');

  // Variation 17: AboutListTile with icon
  final widget17 = AboutListTile(
    icon: Icon(Icons.info),
    applicationName: 'Test App',
    applicationVersion: '2.0.0',
    applicationIcon: FlutterLogo(size: 40),
  );
  print('AboutListTile(icon, applicationIcon) created');

  // Variation 18: AboutListTile with legalese
  final widget18 = AboutListTile(
    applicationName: 'Legal App',
    applicationVersion: '3.0.0',
    applicationLegalese: 'Copyright 2025 Test Corp',
    aboutBoxChildren: [
      SizedBox(height: 16),
      Text('Built with Flutter and D4rt'),
    ],
  );
  print('AboutListTile(applicationLegalese, aboutBoxChildren) created');

  // Variation 19: AboutListTile with child (custom label)
  final widget19 = AboutListTile(
    child: Text('About this app'),
    applicationName: 'Custom Label App',
    applicationVersion: '4.0.0',
    dense: true,
  );
  print('AboutListTile(child: custom label, dense) created');

  print('Navigation destinations test completed');
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget1,
        SizedBox(height: 8),
        widget2,
        SizedBox(height: 8),
        widget3,
        SizedBox(height: 16),
        SizedBox(height: 300, child: widget4),
        SizedBox(height: 8),
        SizedBox(height: 200, child: widget7),
        SizedBox(height: 16),
        widget9,
        widget10,
        widget12,
        widget13,
        SizedBox(height: 16),
        widget16,
        widget17,
        widget18,
        widget19,
      ],
    ),
  );
}
