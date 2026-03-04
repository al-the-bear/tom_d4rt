// D4rt test script: Tests material Badge, SegmentedButton advanced,
// NavigationDrawer, NavigationRailDestination, NavigationRailLabelType
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Material nav/badge advanced test executing');

  // ========== Badge advanced ==========
  print('--- Badge advanced Tests ---');
  final badge = Badge(
    label: Text('3'),
    backgroundColor: Colors.red,
    textColor: Colors.white,
    textStyle: TextStyle(fontSize: 10.0),
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    alignment: AlignmentDirectional.topEnd,
    offset: Offset(2, -2),
    isLabelVisible: true,
    child: Icon(Icons.mail, size: 30.0),
  );
  print('Badge created: label=3, backgroundColor=red');

  final emptyBadge = Badge(
    smallSize: 8.0,
    child: Icon(Icons.notifications, size: 30.0),
  );
  print('Badge (empty/dot): smallSize=8');

  // ========== BadgeThemeData ==========
  print('--- BadgeThemeData Tests ---');
  final badgeTheme = BadgeThemeData(
    backgroundColor: Colors.orange,
    textColor: Colors.white,
    smallSize: 6.0,
    largeSize: 16.0,
    textStyle: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    alignment: AlignmentDirectional.topEnd,
    offset: Offset(0, 0),
  );
  print('BadgeThemeData created');
  print('  backgroundColor: ${badgeTheme.backgroundColor}');
  print('  smallSize: ${badgeTheme.smallSize}');
  print('  largeSize: ${badgeTheme.largeSize}');

  // ========== NavigationDrawer ==========
  print('--- NavigationDrawer Tests ---');
  final navDrawer = NavigationDrawer(
    selectedIndex: 1,
    onDestinationSelected: (int index) => print('Drawer selected: $index'),
    backgroundColor: Colors.white,
    elevation: 1.0,
    indicatorColor: Colors.blue.shade100,
    indicatorShape: StadiumBorder(),
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue.shade50,
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
        child: Text(
          'Mail',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
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
      Divider(indent: 28, endIndent: 28),
      NavigationDrawerDestination(
        icon: Icon(Icons.delete_outline),
        selectedIcon: Icon(Icons.delete),
        label: Text('Trash'),
      ),
    ],
  );
  print('NavigationDrawer: 3 destinations');

  // ========== NavigationDrawerDestination ==========
  print('--- NavigationDrawerDestination Tests ---');
  final dest = NavigationDrawerDestination(
    icon: Icon(Icons.star_border),
    selectedIcon: Icon(Icons.star),
    label: Text('Starred'),
    enabled: true,
  );
  print('NavigationDrawerDestination created');

  // ========== NavigationDrawerThemeData ==========
  print('--- NavigationDrawerThemeData Tests ---');
  final drawerTheme = NavigationDrawerThemeData(
    backgroundColor: Colors.grey.shade50,
    elevation: 2.0,
    indicatorColor: Colors.blue.shade100,
    indicatorShape: StadiumBorder(),
    tileHeight: 56.0,
    labelTextStyle: WidgetStateProperty.all(TextStyle(fontSize: 14.0)),
    iconTheme: WidgetStateProperty.all(IconThemeData(size: 24.0)),
  );
  print('NavigationDrawerThemeData created');

  // ========== NavigationRailLabelType ==========
  print('--- NavigationRailLabelType Tests ---');
  for (final type in NavigationRailLabelType.values) {
    print('NavigationRailLabelType: ${type.name}');
  }

  // ========== NavigationRailThemeData ==========
  print('--- NavigationRailThemeData Tests ---');
  final railTheme = NavigationRailThemeData(
    backgroundColor: Colors.grey.shade100,
    elevation: 0.0,
    indicatorColor: Colors.blue.shade100,
    indicatorShape: StadiumBorder(),
    labelType: NavigationRailLabelType.all,
    groupAlignment: -1.0,
    minWidth: 72.0,
    minExtendedWidth: 256.0,
    useIndicator: true,
  );
  print('NavigationRailThemeData created');

  print('All material nav/badge advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: 0,
            labelType: NavigationRailLabelType.all,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bookmark_border),
                selectedIcon: Icon(Icons.bookmark),
                label: Text('Saved'),
              ),
            ],
            onDestinationSelected: (int index) {},
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nav/Badge Advanced Test',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [badge, SizedBox(width: 16), emptyBadge],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
