// D4rt test script: Tests BottomAppBar, BottomAppBarTheme, NavigationBar,
// NavigationDestination, NavigationBarThemeData, BadgeThemeData,
// Badge, NavigationDrawer, NavigationDrawerDestination
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Bottom app bar and navigation test executing');

  // ========== BottomAppBar ==========
  print('--- BottomAppBar Tests ---');
  final bottomAppBar = BottomAppBar(
    color: Colors.blue,
    elevation: 8.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue[50],
    shape: CircularNotchedRectangle(),
    clipBehavior: Clip.antiAlias,
    notchMargin: 8.0,
    padding: EdgeInsets.symmetric(horizontal: 16),
    height: 64.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.search, color: Colors.white),
          onPressed: () {},
        ),
        SizedBox(width: 48), // Space for FAB
        IconButton(
          icon: Icon(Icons.favorite, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.person, color: Colors.white),
          onPressed: () {},
        ),
      ],
    ),
  );
  print('BottomAppBar created');

  // ========== CircularNotchedRectangle ==========
  print('--- CircularNotchedRectangle Tests ---');
  final notchedShape = CircularNotchedRectangle();
  print('CircularNotchedRectangle created');
  final path = notchedShape.getOuterPath(
    Rect.fromLTWH(0, 0, 400, 64),
    Rect.fromCircle(center: Offset(200, 0), radius: 28),
  );
  print('  getOuterPath computed');

  // ========== BottomAppBarTheme ==========
  print('--- BottomAppBarTheme Tests ---');
  final bottomAppBarTheme = BottomAppBarTheme(
    color: Colors.white,
    elevation: 4.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue[50],
    shape: CircularNotchedRectangle(),
    height: 64.0,
    padding: EdgeInsets.symmetric(horizontal: 12),
  );
  print('BottomAppBarTheme created');
  print('  elevation: ${bottomAppBarTheme.elevation}');
  print('  height: ${bottomAppBarTheme.height}');

  // ========== NavigationBar ==========
  print('--- NavigationBar Tests ---');
  final navigationBar = NavigationBar(
    selectedIndex: 0,
    onDestinationSelected: (index) => print('  Nav selected: $index'),
    destinations: [
      NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: 'Home',
        tooltip: 'Go to home',
        enabled: true,
      ),
      NavigationDestination(
        icon: Badge(
          label: Text('3'),
          child: Icon(Icons.notifications_outlined),
        ),
        selectedIcon: Badge(label: Text('3'), child: Icon(Icons.notifications)),
        label: 'Notifications',
      ),
      NavigationDestination(
        icon: Icon(Icons.settings_outlined),
        selectedIcon: Icon(Icons.settings),
        label: 'Settings',
      ),
    ],
    elevation: 3.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue[50],
    backgroundColor: Colors.white,
    indicatorColor: Colors.blue[100],
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    height: 80.0,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    animationDuration: Duration(milliseconds: 500),
    overlayColor: WidgetStateProperty.all(Colors.blue[50]),
  );
  print('NavigationBar created');

  // ========== NavigationDestinationLabelBehavior ==========
  print('--- NavigationDestinationLabelBehavior Tests ---');
  for (final b in NavigationDestinationLabelBehavior.values) {
    print('  NavigationDestinationLabelBehavior.$b');
  }

  // ========== NavigationBarThemeData ==========
  print('--- NavigationBarThemeData Tests ---');
  final navBarTheme = NavigationBarThemeData(
    height: 80.0,
    backgroundColor: Colors.white,
    elevation: 3.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue[50],
    indicatorColor: Colors.blue[100],
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    overlayColor: WidgetStateProperty.all(Colors.blue[50]),
    labelTextStyle: WidgetStateProperty.all(TextStyle(fontSize: 12)),
    iconTheme: WidgetStateProperty.all(IconThemeData(size: 24)),
  );
  print('NavigationBarThemeData created');

  // ========== Badge ==========
  print('--- Badge Tests ---');
  final badge1 = Badge(
    label: Text('99+'),
    backgroundColor: Colors.red,
    textColor: Colors.white,
    textStyle: TextStyle(fontSize: 10),
    padding: EdgeInsets.symmetric(horizontal: 6),
    alignment: AlignmentDirectional.topEnd,
    offset: Offset(4, -4),
    largeSize: 16.0,
    smallSize: 6.0,
    isLabelVisible: true,
    child: Icon(Icons.mail),
  );
  print('Badge with label created');

  final badge2 = Badge(child: Icon(Icons.notifications));
  print('Badge dot created');

  // ========== BadgeThemeData ==========
  print('--- BadgeThemeData Tests ---');
  final badgeTheme = BadgeThemeData(
    backgroundColor: Colors.red,
    textColor: Colors.white,
    textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
    padding: EdgeInsets.symmetric(horizontal: 6),
    alignment: AlignmentDirectional.topEnd,
    offset: Offset(4, -4),
    largeSize: 16.0,
    smallSize: 6.0,
  );
  print('BadgeThemeData created');

  // ========== NavigationDrawer ==========
  print('--- NavigationDrawer Tests ---');
  final navDrawer = NavigationDrawer(
    selectedIndex: 0,
    onDestinationSelected: (index) => print('  Drawer selected: $index'),
    elevation: 1.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue[50],
    backgroundColor: Colors.white,
    indicatorColor: Colors.blue[100],
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(28),
    ),
    tilePadding: EdgeInsets.symmetric(horizontal: 12),
    children: [
      Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Navigation',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: Text('Home'),
        enabled: true,
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.settings_outlined),
        selectedIcon: Icon(Icons.settings),
        label: Text('Settings'),
      ),
      Divider(),
      NavigationDrawerDestination(
        icon: Icon(Icons.info_outline),
        selectedIcon: Icon(Icons.info),
        label: Text('About'),
      ),
    ],
  );
  print('NavigationDrawer created');

  print('All bottom app bar / navigation tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      bottomNavigationBar: navigationBar,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Center(child: Text('Content')),
      drawer: navDrawer,
    ),
  );
}
