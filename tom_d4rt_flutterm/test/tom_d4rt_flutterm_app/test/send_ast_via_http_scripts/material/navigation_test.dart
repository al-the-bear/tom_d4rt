// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Drawer, NavigationBar, NavigationRail, NavigationDrawer from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Navigation widgets test executing');

  // ========== DRAWER ==========
  print('--- Drawer Tests ---');

  // Test basic Drawer
  final basicDrawer = Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          child: Text(
            'Drawer Header',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            print('Home tapped');
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () {},
        ),
      ],
    ),
  );
  print('Basic Drawer created');

  // Test Drawer with backgroundColor
  final coloredDrawer = Drawer(
    backgroundColor: Colors.grey.shade100,
    child: Center(child: Text('Colored Drawer')),
  );
  print('Drawer with backgroundColor created: $coloredDrawer');

  // Test Drawer with elevation
  final elevatedDrawer = Drawer(
    elevation: 24.0,
    child: Center(child: Text('Elevated Drawer')),
  );
  print('Drawer with elevation created: $elevatedDrawer');

  // Test Drawer with shape
  final shapedDrawer = Drawer(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(24.0)),
    ),
    child: Center(child: Text('Shaped Drawer')),
  );
  print('Drawer with shape created: $shapedDrawer');

  // Test Drawer with width
  final wideDrawer = Drawer(
    width: 300.0,
    child: Center(child: Text('Wide Drawer')),
  );
  print('Drawer with width created: $wideDrawer');

  // Test Drawer with shadowColor
  final shadowDrawer = Drawer(
    shadowColor: Colors.red,
    elevation: 16.0,
    child: Center(child: Text('Shadow Drawer')),
  );
  print('Drawer with shadowColor created: $shadowDrawer');

  // Test Drawer with surfaceTintColor
  final tintDrawer = Drawer(
    surfaceTintColor: Colors.purple,
    child: Center(child: Text('Tinted Drawer')),
  );
  print('Drawer with surfaceTintColor created: $tintDrawer');

  // Test DrawerHeader
  final drawerHeader = DrawerHeader(
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
    ),
    margin: EdgeInsets.zero,
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 30, child: Text('U')),
        SizedBox(height: 8),
        Text('User Name', style: TextStyle(color: Colors.white)),
        Text('user@email.com', style: TextStyle(color: Colors.white70)),
      ],
    ),
  );
  print('DrawerHeader created: $drawerHeader');

  // Test UserAccountsDrawerHeader
  final userAccountsHeader = UserAccountsDrawerHeader(
    accountName: Text('John Doe'),
    accountEmail: Text('john.doe@example.com'),
    currentAccountPicture: CircleAvatar(
      backgroundColor: Colors.orange,
      child: Text('JD'),
    ),
    otherAccountsPictures: [
      CircleAvatar(child: Text('A')),
      CircleAvatar(child: Text('B')),
    ],
    decoration: BoxDecoration(color: Colors.blue),
    onDetailsPressed: () {
      print('Details pressed');
    },
  );
  print('UserAccountsDrawerHeader created');

  // ========== NAVIGATIONBAR ==========
  print('--- NavigationBar Tests ---');

  // Test basic NavigationBar
  final basicNavBar = NavigationBar(
    selectedIndex: 0,
    destinations: [
      NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.business), label: 'Business'),
      NavigationDestination(icon: Icon(Icons.school), label: 'School'),
    ],
    onDestinationSelected: (int index) {
      print('Destination selected: $index');
    },
  );
  print('Basic NavigationBar created');

  // Test NavigationBar with selectedIndex
  final selectedNavBar = NavigationBar(
    selectedIndex: 1,
    destinations: [
      NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.explore), label: 'Explore'),
      NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
    ],
    onDestinationSelected: (index) {},
  );
  print('NavigationBar with selectedIndex created: $selectedNavBar');

  // Test NavigationBar with backgroundColor
  final coloredNavBar = NavigationBar(
    backgroundColor: Colors.purple.shade100,
    selectedIndex: 0,
    destinations: [
      NavigationDestination(icon: Icon(Icons.star), label: 'Starred'),
      NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorites'),
    ],
    onDestinationSelected: (index) {},
  );
  print('NavigationBar with backgroundColor created: $coloredNavBar');

  // Test NavigationBar with elevation
  final elevatedNavBar = NavigationBar(
    elevation: 8.0,
    selectedIndex: 0,
    destinations: [
      NavigationDestination(icon: Icon(Icons.inbox), label: 'Inbox'),
      NavigationDestination(icon: Icon(Icons.send), label: 'Sent'),
    ],
    onDestinationSelected: (index) {},
  );
  print('NavigationBar with elevation created: $elevatedNavBar');

  // Test NavigationBar with indicatorColor
  final indicatorNavBar = NavigationBar(
    indicatorColor: Colors.orange.shade200,
    selectedIndex: 0,
    destinations: [
      NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
      NavigationDestination(icon: Icon(Icons.analytics), label: 'Analytics'),
    ],
    onDestinationSelected: (index) {},
  );
  print('NavigationBar with indicatorColor created: $indicatorNavBar');

  // Test NavigationBar with height
  final tallNavBar = NavigationBar(
    height: 100.0,
    selectedIndex: 0,
    destinations: [
      NavigationDestination(icon: Icon(Icons.movie), label: 'Movies'),
      NavigationDestination(icon: Icon(Icons.music_note), label: 'Music'),
    ],
    onDestinationSelected: (index) {},
  );
  print('NavigationBar with height created: $tallNavBar');

  // Test NavigationBar with labelBehavior
  final labelBehaviorNavBar = NavigationBar(
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    selectedIndex: 0,
    destinations: [
      NavigationDestination(icon: Icon(Icons.cloud), label: 'Cloud'),
      NavigationDestination(icon: Icon(Icons.download), label: 'Downloads'),
    ],
    onDestinationSelected: (index) {},
  );
  print('NavigationBar with labelBehavior created: $labelBehaviorNavBar');

  // Test NavigationDestination with selectedIcon
  final selectedIconNavBar = NavigationBar(
    selectedIndex: 0,
    destinations: [
      NavigationDestination(
        icon: Icon(Icons.bookmark_outline),
        selectedIcon: Icon(Icons.bookmark),
        label: 'Bookmarks',
      ),
      NavigationDestination(
        icon: Icon(Icons.notifications_outlined),
        selectedIcon: Icon(Icons.notifications),
        label: 'Notifications',
      ),
    ],
    onDestinationSelected: (index) {},
  );
  print(
    'NavigationBar with selectedIcon destinations created: $selectedIconNavBar',
  );

  // ========== NAVIGATIONRAIL ==========
  print('--- NavigationRail Tests ---');

  // Test basic NavigationRail
  final basicRail = NavigationRail(
    selectedIndex: 0,
    destinations: [
      NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
      NavigationRailDestination(
        icon: Icon(Icons.search),
        label: Text('Search'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.person),
        label: Text('Profile'),
      ),
    ],
    onDestinationSelected: (int index) {
      print('Rail destination: $index');
    },
  );
  print('Basic NavigationRail created');

  // Test NavigationRail with labelType
  final labelTypeRail = NavigationRail(
    labelType: NavigationRailLabelType.all,
    selectedIndex: 0,
    destinations: [
      NavigationRailDestination(icon: Icon(Icons.folder), label: Text('Files')),
      NavigationRailDestination(icon: Icon(Icons.image), label: Text('Images')),
    ],
    onDestinationSelected: (index) {},
  );
  print('NavigationRail with labelType created: $labelTypeRail');

  // Test NavigationRail with leading
  final leadingRail = NavigationRail(
    leading: FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
    selectedIndex: 0,
    destinations: [
      NavigationRailDestination(icon: Icon(Icons.mail), label: Text('Mail')),
      NavigationRailDestination(
        icon: Icon(Icons.drafts),
        label: Text('Drafts'),
      ),
    ],
    onDestinationSelected: (index) {},
  );
  print('NavigationRail with leading created: $leadingRail');

  // Test NavigationRail with trailing
  final trailingRail = NavigationRail(
    trailing: IconButton(icon: Icon(Icons.settings), onPressed: () {}),
    selectedIndex: 0,
    destinations: [
      NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
      NavigationRailDestination(icon: Icon(Icons.info), label: Text('About')),
    ],
    onDestinationSelected: (index) {},
  );
  print('NavigationRail with trailing created: $trailingRail');

  // Test NavigationRail extended
  final extendedRail = NavigationRail(
    extended: true,
    selectedIndex: 0,
    destinations: [
      NavigationRailDestination(
        icon: Icon(Icons.dashboard),
        label: Text('Dashboard'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.report),
        label: Text('Reports'),
      ),
    ],
    onDestinationSelected: (index) {},
  );
  print('NavigationRail extended created: $extendedRail');

  // Test NavigationRail with backgroundColor
  final coloredRail = NavigationRail(
    backgroundColor: Colors.blue.shade50,
    selectedIndex: 0,
    destinations: [
      NavigationRailDestination(icon: Icon(Icons.chat), label: Text('Chat')),
      NavigationRailDestination(icon: Icon(Icons.group), label: Text('Groups')),
    ],
    onDestinationSelected: (index) {},
  );
  print('NavigationRail with backgroundColor created: $coloredRail');

  // Test NavigationRail with useIndicator
  final indicatorRail = NavigationRail(
    useIndicator: true,
    indicatorColor: Colors.orange.shade200,
    selectedIndex: 0,
    destinations: [
      NavigationRailDestination(
        icon: Icon(Icons.calendar_today),
        label: Text('Calendar'),
      ),
      NavigationRailDestination(icon: Icon(Icons.event), label: Text('Events')),
    ],
    onDestinationSelected: (index) {},
  );
  print('NavigationRail with indicator created: $indicatorRail');

  // Test NavigationRail with minWidth
  final wideRail = NavigationRail(
    minWidth: 80.0,
    selectedIndex: 0,
    destinations: [
      NavigationRailDestination(icon: Icon(Icons.book), label: Text('Library')),
      NavigationRailDestination(
        icon: Icon(Icons.history),
        label: Text('History'),
      ),
    ],
    onDestinationSelected: (index) {},
  );
  print('NavigationRail with minWidth created: $wideRail');

  // Test NavigationRail with groupAlignment
  final alignedRail = NavigationRail(
    groupAlignment: 0.0, // Center
    selectedIndex: 0,
    destinations: [
      NavigationRailDestination(icon: Icon(Icons.map), label: Text('Map')),
      NavigationRailDestination(icon: Icon(Icons.place), label: Text('Places')),
    ],
    onDestinationSelected: (index) {},
  );
  print('NavigationRail with groupAlignment created: $alignedRail');

  // ========== NAVIGATIONDRAWER ==========
  print('--- NavigationDrawer Tests ---');

  // Test basic NavigationDrawer
  final basicNavDrawer = NavigationDrawer(
    selectedIndex: 0,
    onDestinationSelected: (int index) {
      print('Nav drawer destination: $index');
    },
    children: [
      NavigationDrawerDestination(
        icon: Icon(Icons.inbox),
        label: Text('Inbox'),
      ),
      NavigationDrawerDestination(icon: Icon(Icons.send), label: Text('Sent')),
      NavigationDrawerDestination(
        icon: Icon(Icons.delete),
        label: Text('Trash'),
      ),
    ],
  );
  print('Basic NavigationDrawer created');

  // Test NavigationDrawer with header
  final headerNavDrawer = NavigationDrawer(
    selectedIndex: 0,
    onDestinationSelected: (index) {},
    children: [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Mail',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      Divider(),
      NavigationDrawerDestination(
        icon: Icon(Icons.inbox),
        label: Text('Inbox'),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.drafts),
        label: Text('Drafts'),
      ),
    ],
  );
  print('NavigationDrawer with header created: $headerNavDrawer');

  // Test NavigationDrawer with backgroundColor
  final coloredNavDrawer = NavigationDrawer(
    backgroundColor: Colors.green.shade50,
    selectedIndex: 0,
    onDestinationSelected: (index) {},
    children: [
      NavigationDrawerDestination(
        icon: Icon(Icons.folder),
        label: Text('Folder 1'),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.folder),
        label: Text('Folder 2'),
      ),
    ],
  );
  print('NavigationDrawer with backgroundColor created: $coloredNavDrawer');

  // Test NavigationDrawer with elevation
  final elevatedNavDrawer = NavigationDrawer(
    elevation: 16.0,
    selectedIndex: 0,
    onDestinationSelected: (index) {},
    children: [
      NavigationDrawerDestination(icon: Icon(Icons.note), label: Text('Notes')),
    ],
  );
  print('NavigationDrawer with elevation created: $elevatedNavDrawer');

  // Test NavigationDrawer with indicatorColor
  final indicatorNavDrawer = NavigationDrawer(
    indicatorColor: Colors.purple.shade100,
    selectedIndex: 0,
    onDestinationSelected: (index) {},
    children: [
      NavigationDrawerDestination(
        icon: Icon(Icons.star),
        label: Text('Starred'),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.archive),
        label: Text('Archive'),
      ),
    ],
  );
  print('NavigationDrawer with indicatorColor created: $indicatorNavDrawer');

  print('Navigation widgets test completed');

  return Row(
    children: [
      // NavigationRail on left
      basicRail,
      VerticalDivider(width: 1),
      // Main content
      Expanded(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Navigation Widgets Test',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),

                    Text(
                      'Drawer:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 300, width: 250, child: basicDrawer),
                    SizedBox(height: 16.0),

                    Text(
                      'UserAccountsDrawerHeader:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 280, child: userAccountsHeader),
                    SizedBox(height: 16.0),

                    Text(
                      'NavigationDrawer:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 200, width: 280, child: basicNavDrawer),
                  ],
                ),
              ),
            ),
            // NavigationBar at bottom
            basicNavBar,
          ],
        ),
      ),
    ],
  );
}
