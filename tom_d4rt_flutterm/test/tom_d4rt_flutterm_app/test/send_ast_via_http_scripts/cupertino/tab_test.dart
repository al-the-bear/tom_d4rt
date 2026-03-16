// D4rt test script: Tests CupertinoTabController, CupertinoTabScaffold, CupertinoTabBar, CupertinoTabView from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino tab test executing');

  // ========== CUPERTINOTABCONTROLLER ==========
  print('--- CupertinoTabController Tests ---');

  // Test basic CupertinoTabController
  final tabController = CupertinoTabController();
  print('Basic CupertinoTabController created');
  print('  initial index: ${tabController.index}');

  // Test CupertinoTabController with initialIndex
  final indexedController = CupertinoTabController(initialIndex: 2);
  print('CupertinoTabController with initialIndex=2 created');
  print('  index: ${indexedController.index}');

  // Test setting index
  tabController.index = 1;
  print('tabController.index set to 1: ${tabController.index}');

  // Reset index
  tabController.index = 0;
  print('tabController.index reset to 0: ${tabController.index}');

  // ========== CUPERTINOTABBAR ==========
  print('--- CupertinoTabBar Tests ---');

  // Test basic CupertinoTabBar
  final basicTabBar = CupertinoTabBar(
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.settings),
        label: 'Settings',
      ),
    ],
  );
  print('Basic CupertinoTabBar created');

  // Test CupertinoTabBar with currentIndex
  final indexedTabBar = CupertinoTabBar(
    currentIndex: 1,
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.heart),
        label: 'Favorites',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person),
        label: 'Profile',
      ),
    ],
  );
  print('CupertinoTabBar with currentIndex=1 created');

  // Test CupertinoTabBar with backgroundColor
  final bgTabBar = CupertinoTabBar(
    backgroundColor: CupertinoColors.systemGroupedBackground,
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        label: 'Search',
      ),
    ],
  );
  print('CupertinoTabBar with backgroundColor created');

  // Test CupertinoTabBar with activeColor and inactiveColor
  final coloredTabBar = CupertinoTabBar(
    activeColor: CupertinoColors.systemRed,
    inactiveColor: CupertinoColors.systemGrey,
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.doc), label: 'Docs'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.folder),
        label: 'Files',
      ),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.cloud), label: 'Cloud'),
    ],
  );
  print('CupertinoTabBar with activeColor/inactiveColor created');

  // Test CupertinoTabBar with iconSize
  final iconSizeTabBar = CupertinoTabBar(
    iconSize: 32.0,
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.bell), label: 'Alerts'),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.mail), label: 'Mail'),
    ],
  );
  print('CupertinoTabBar with iconSize created');

  // Test CupertinoTabBar with onTap
  final tappableTabBar = CupertinoTabBar(
    onTap: (int index) {
      print('Tab tapped: $index');
    },
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.gear),
        label: 'Settings',
      ),
    ],
  );
  print('CupertinoTabBar with onTap created');

  // ========== CUPERTINOTABSCAFFOLD ==========
  print('--- CupertinoTabScaffold Tests ---');

  // Test basic CupertinoTabScaffold
  final basicTabScaffold = CupertinoTabScaffold(
    tabBar: CupertinoTabBar(
      items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.settings),
          label: 'Settings',
        ),
      ],
    ),
    tabBuilder: (BuildContext context, int index) {
      return CupertinoTabView(
        builder: (BuildContext context) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(middle: Text('Tab $index')),
            child: Center(child: Text('Content for tab $index')),
          );
        },
      );
    },
  );
  print('Basic CupertinoTabScaffold created');

  // Test CupertinoTabScaffold with controller
  final controllerTabScaffold = CupertinoTabScaffold(
    controller: tabController,
    tabBar: CupertinoTabBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.book),
          label: 'Library',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.music_note),
          label: 'Music',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.video_camera),
          label: 'Video',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.photo),
          label: 'Photos',
        ),
      ],
    ),
    tabBuilder: (BuildContext context, int index) {
      final titles = ['Library', 'Music', 'Video', 'Photos'];
      return CupertinoTabView(
        builder: (BuildContext context) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(middle: Text(titles[index])),
            child: Center(child: Text('Content: ${titles[index]}')),
          );
        },
      );
    },
  );
  print('CupertinoTabScaffold with controller created');

  // Test CupertinoTabScaffold with backgroundColor
  final bgTabScaffold = CupertinoTabScaffold(
    backgroundColor: CupertinoColors.systemBackground,
    tabBar: CupertinoTabBar(
      items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person),
          label: 'Profile',
        ),
      ],
    ),
    tabBuilder: (BuildContext context, int index) {
      return CupertinoTabView(
        builder: (BuildContext context) {
          return Center(child: Text('Tab $index'));
        },
      );
    },
  );
  print('CupertinoTabScaffold with backgroundColor created');

  // Test CupertinoTabScaffold with resizeToAvoidBottomInset
  final resizeTabScaffold = CupertinoTabScaffold(
    resizeToAvoidBottomInset: false,
    tabBar: CupertinoTabBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.chat_bubble),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person_2),
          label: 'Contacts',
        ),
      ],
    ),
    tabBuilder: (BuildContext context, int index) {
      return Center(child: Text('Tab $index'));
    },
  );
  print('CupertinoTabScaffold with resizeToAvoidBottomInset created');

  // ========== CUPERTINOTABVIEW ==========
  print('--- CupertinoTabView Tests ---');

  // Test basic CupertinoTabView
  final basicTabView = CupertinoTabView(
    builder: (BuildContext context) {
      return Center(child: Text('Tab View Content'));
    },
  );
  print('Basic CupertinoTabView created');

  // Test CupertinoTabView with defaultTitle
  final titledTabView = CupertinoTabView(
    defaultTitle: 'My Tab',
    builder: (BuildContext context) {
      return Center(child: Text('Titled Tab View'));
    },
  );
  print('CupertinoTabView with defaultTitle created');

  print('All Cupertino tab tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(home: basicTabScaffold);
}
