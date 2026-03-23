// ignore_for_file: avoid_print
// D4rt test script: Tests BottomNavigationBar widget from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BottomNavigationBar test executing');

  // Test basic BottomNavigationBar
  final basicNavBar = BottomNavigationBar(
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
    currentIndex: 0,
    onTap: (index) {
      print('Tab $index tapped');
    },
  );
  print('Basic BottomNavigationBar with 3 items created');

  // Test with currentIndex
  final selectedNavBar = BottomNavigationBar(
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
    ],
    currentIndex: 1,
    onTap: (i) {},
  );
  print('BottomNavigationBar with currentIndex=1 created');

  // Test type: fixed
  final fixedNavBar = BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Alerts'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with type=fixed created');

  // Test type: shifting
  final shiftingNavBar = BottomNavigationBar(
    type: BottomNavigationBarType.shifting,
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
        backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
        backgroundColor: Colors.green,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
        backgroundColor: Colors.purple,
      ),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with type=shifting created');

  // Test with custom colors
  final coloredNavBar = BottomNavigationBar(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with custom colors created');

  // Test with selectedIconTheme and unselectedIconTheme
  final themedNavBar = BottomNavigationBar(
    selectedIconTheme: IconThemeData(size: 30.0, color: Colors.blue),
    unselectedIconTheme: IconThemeData(size: 24.0, color: Colors.grey),
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Star'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with icon themes created');

  // Test with selectedLabelStyle and unselectedLabelStyle
  final styledNavBar = BottomNavigationBar(
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 12.0,
    ),
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Work'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with label styles created');

  // Test with showSelectedLabels and showUnselectedLabels
  final noLabelsNavBar = BottomNavigationBar(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with hidden labels created');

  // Test with iconSize
  final largeIconsNavBar = BottomNavigationBar(
    iconSize: 32.0,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with iconSize=32 created');

  // Test with elevation
  final elevatedNavBar = BottomNavigationBar(
    elevation: 16.0,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'Inbox'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with elevation=16 created');

  // Test with landscapeLayout
  final landscapeNavBar = BottomNavigationBar(
    landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
      BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with landscapeLayout=spread created');

  // Test with enableFeedback
  final feedbackNavBar = BottomNavigationBar(
    enableFeedback: true,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with enableFeedback=true created');

  // Test with activeIcon
  final activeIconNavBar = BottomNavigationBar(
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border),
        activeIcon: Icon(Icons.favorite),
        label: 'Favorites',
      ),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with activeIcon created');

  // Test useLegacyColorScheme
  final legacyColorNavBar = BottomNavigationBar(
    useLegacyColorScheme: false,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with useLegacyColorScheme=false created');

  print('BottomNavigationBar test completed');

  return Scaffold(
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BottomNavigationBar Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text('NavBar Types:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('• fixed - all labels visible'),
          Text('• shifting - selected label only'),
          SizedBox(height: 16.0),

          Text(
            'Key Properties:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('• items - list of BottomNavigationBarItem'),
          Text('• currentIndex - selected index'),
          Text('• onTap - tap callback'),
          Text('• type - fixed or shifting'),
          Text('• backgroundColor - background color'),
          Text('• selectedItemColor - selected item color'),
          Text('• unselectedItemColor - unselected color'),
          Text('• iconSize - icon size'),
          Text('• elevation - shadow elevation'),
          SizedBox(height: 16.0),

          Text(
            'BottomNavigationBarItem:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('• icon - inactive icon'),
          Text('• activeIcon - active icon'),
          Text('• label - text label'),
          Text('• backgroundColor - for shifting type'),
          Text('• tooltip - accessibility label'),
        ],
      ),
    ),
    bottomNavigationBar: basicNavBar,
  );
}
