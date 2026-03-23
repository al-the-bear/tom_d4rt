// ignore_for_file: avoid_print
// D4rt test script: Tests CupertinoPageScaffold, CupertinoTabScaffold from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino scaffold test executing');

  // ========== CUPERTINOPAGESCAFFOLD ==========
  print('--- CupertinoPageScaffold Tests ---');

  // Test basic CupertinoPageScaffold
  final basicScaffold = CupertinoPageScaffold(
    child: Center(child: Text('Basic scaffold')),
  );
  print('Basic CupertinoPageScaffold created [${basicScaffold.hashCode }]');

  // Test CupertinoPageScaffold with navigationBar
  final navBarScaffold = CupertinoPageScaffold(
    navigationBar: CupertinoNavigationBar(middle: Text('Page Title')),
    child: Center(child: Text('Content')),
  );
  print('CupertinoPageScaffold with navigationBar created [${navBarScaffold.hashCode }]');

  // Test CupertinoPageScaffold with backgroundColor
  final bgColorScaffold = CupertinoPageScaffold(
    backgroundColor: CupertinoColors.systemGroupedBackground,
    child: Center(child: Text('Custom background')),
  );
  print('CupertinoPageScaffold with backgroundColor created [${bgColorScaffold.hashCode }]');

  // Test CupertinoPageScaffold with resizeToAvoidBottomInset
  final resizeScaffold = CupertinoPageScaffold(
    resizeToAvoidBottomInset: true,
    child: Center(child: Text('Resizes for keyboard')),
  );
  print('CupertinoPageScaffold with resizeToAvoidBottomInset created [${resizeScaffold.hashCode }]');

  // Test CupertinoPageScaffold with full navigation bar
  final fullNavScaffold = CupertinoPageScaffold(
    navigationBar: CupertinoNavigationBar(
      leading: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Icon(CupertinoIcons.back),
        onPressed: () {},
      ),
      middle: Text('Full Nav'),
      trailing: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Icon(CupertinoIcons.add),
        onPressed: () {},
      ),
    ),
    child: Center(child: Text('Full navigation bar')),
  );
  print('CupertinoPageScaffold with full navigationBar created [${fullNavScaffold.hashCode }]');

  // ========== CUPERTINONAVIGATIONBAR ==========
  print('--- CupertinoNavigationBar Tests ---');

  // Test basic CupertinoNavigationBar
  final basicNavBar = CupertinoNavigationBar(middle: Text('Title'));
  print('Basic CupertinoNavigationBar created [${basicNavBar.hashCode }]');

  // Test CupertinoNavigationBar with leading
  final leadingNavBar = CupertinoNavigationBar(
    leading: CupertinoButton(
      padding: EdgeInsets.zero,
      child: Text('Back'),
      onPressed: () {},
    ),
    middle: Text('With Leading'),
  );
  print('CupertinoNavigationBar with leading created [${leadingNavBar.hashCode }]');

  // Test CupertinoNavigationBar with trailing
  final trailingNavBar = CupertinoNavigationBar(
    middle: Text('With Trailing'),
    trailing: CupertinoButton(
      padding: EdgeInsets.zero,
      child: Text('Edit'),
      onPressed: () {},
    ),
  );
  print('CupertinoNavigationBar with trailing created [${trailingNavBar.hashCode }]');

  // Test CupertinoNavigationBar with automaticallyImplyLeading
  final noImplyNavBar = CupertinoNavigationBar(
    automaticallyImplyLeading: false,
    middle: Text('No Auto Leading'),
  );
  print('CupertinoNavigationBar with automaticallyImplyLeading=false created [${noImplyNavBar.hashCode }]');

  // Test CupertinoNavigationBar with automaticallyImplyMiddle
  final noImplyMiddleNavBar = CupertinoNavigationBar(
    automaticallyImplyMiddle: false,
    leading: Text('Custom'),
  );
  print('CupertinoNavigationBar with automaticallyImplyMiddle=false created [${noImplyMiddleNavBar.hashCode }]');

  // Test CupertinoNavigationBar with previousPageTitle
  final prevPageNavBar = CupertinoNavigationBar(
    previousPageTitle: 'Settings',
    middle: Text('Details'),
  );
  print('CupertinoNavigationBar with previousPageTitle created [${prevPageNavBar.hashCode }]');

  // Test CupertinoNavigationBar with backgroundColor
  final bgNavBar = CupertinoNavigationBar(
    backgroundColor: CupertinoColors.systemBlue.withValues(alpha: 0.8),
    middle: Text('Colored Nav', style: TextStyle(color: CupertinoColors.white)),
  );
  print('CupertinoNavigationBar with backgroundColor created [${bgNavBar.hashCode }]');

  // Test CupertinoNavigationBar with brightness
  final brightnessNavBar = CupertinoNavigationBar(
    brightness: Brightness.dark,
    backgroundColor: CupertinoColors.black,
    middle: Text('Dark Nav', style: TextStyle(color: CupertinoColors.white)),
  );
  print('CupertinoNavigationBar with brightness created [${brightnessNavBar.hashCode }]');

  // Test CupertinoNavigationBar with border
  final borderNavBar = CupertinoNavigationBar(
    border: Border(
      bottom: BorderSide(color: CupertinoColors.systemGrey, width: 2.0),
    ),
    middle: Text('Custom Border'),
  );
  print('CupertinoNavigationBar with border created [${borderNavBar.hashCode }]');

  // Test CupertinoNavigationBar with padding
  final paddedNavBar = CupertinoNavigationBar(
    padding: EdgeInsetsDirectional.only(start: 16.0, end: 16.0),
    middle: Text('Padded'),
  );
  print('CupertinoNavigationBar with padding created [${paddedNavBar.hashCode }]');

  // Test CupertinoNavigationBar with transitionBetweenRoutes
  final noTransitionNavBar = CupertinoNavigationBar(
    transitionBetweenRoutes: false,
    middle: Text('No Transition'),
  );
  print('CupertinoNavigationBar with transitionBetweenRoutes=false created [${noTransitionNavBar.hashCode }]');

  // ========== CUPERTINOSLIVERSNAVIGATIONBAR ==========
  print('--- CupertinoSliverNavigationBar Tests ---');

  // Test basic CupertinoSliverNavigationBar
  final basicSliverNav = CupertinoSliverNavigationBar(
    largeTitle: Text('Large Title'),
  );
  print('Basic CupertinoSliverNavigationBar created [${basicSliverNav.hashCode }]');

  // Test CupertinoSliverNavigationBar with leading
  final leadingSliverNav = CupertinoSliverNavigationBar(
    leading: CupertinoButton(
      padding: EdgeInsets.zero,
      child: Icon(CupertinoIcons.back),
      onPressed: () {},
    ),
    largeTitle: Text('With Leading'),
  );
  print('CupertinoSliverNavigationBar with leading created [${leadingSliverNav.hashCode }]');

  // Test CupertinoSliverNavigationBar with trailing
  final trailingSliverNav = CupertinoSliverNavigationBar(
    largeTitle: Text('With Trailing'),
    trailing: CupertinoButton(
      padding: EdgeInsets.zero,
      child: Icon(CupertinoIcons.add),
      onPressed: () {},
    ),
  );
  print('CupertinoSliverNavigationBar with trailing created [${trailingSliverNav.hashCode }]');

  // Test CupertinoSliverNavigationBar with middle
  final middleSliverNav = CupertinoSliverNavigationBar(
    middle: Text('Small Title'),
    largeTitle: Text('Large Title'),
  );
  print('CupertinoSliverNavigationBar with middle created [${middleSliverNav.hashCode }]');

  // Test CupertinoSliverNavigationBar with alwaysShowMiddle
  final alwaysMiddleSliverNav = CupertinoSliverNavigationBar(
    alwaysShowMiddle: true,
    middle: Text('Always Shown'),
    largeTitle: Text('Large'),
  );
  print('CupertinoSliverNavigationBar with alwaysShowMiddle created [${alwaysMiddleSliverNav.hashCode }]');

  // Test CupertinoSliverNavigationBar with stretch
  final stretchSliverNav = CupertinoSliverNavigationBar(
    stretch: true,
    largeTitle: Text('Stretchy'),
  );
  print('CupertinoSliverNavigationBar with stretch created [${stretchSliverNav.hashCode }]');

  // Test CupertinoSliverNavigationBar with backgroundColor
  final bgSliverNav = CupertinoSliverNavigationBar(
    backgroundColor: CupertinoColors.systemIndigo,
    largeTitle: Text('Colored', style: TextStyle(color: CupertinoColors.white)),
  );
  print('CupertinoSliverNavigationBar with backgroundColor created [${bgSliverNav.hashCode }]');

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
      ],
    ),
    tabBuilder: (context, index) {
      return CupertinoPageScaffold(child: Center(child: Text('Tab $index')));
    },
  );
  print('Basic CupertinoTabScaffold created [${basicTabScaffold.hashCode }]');

  // Test CupertinoTabScaffold with controller
  final controlledTabScaffold = CupertinoTabScaffold(
    controller: CupertinoTabController(initialIndex: 1),
    tabBar: CupertinoTabBar(
      items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.settings),
          label: 'Settings',
        ),
      ],
    ),
    tabBuilder: (context, index) {
      return Center(child: Text('Tab $index'));
    },
  );
  print('CupertinoTabScaffold with controller created [${controlledTabScaffold.hashCode }]');

  // Test CupertinoTabScaffold with backgroundColor
  final bgTabScaffold = CupertinoTabScaffold(
    backgroundColor: CupertinoColors.systemGroupedBackground,
    tabBar: CupertinoTabBar(
      items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person),
          label: 'Profile',
        ),
      ],
    ),
    tabBuilder: (context, index) {
      return Center(child: Text('Tab $index'));
    },
  );
  print('CupertinoTabScaffold with backgroundColor created [${bgTabScaffold.hashCode }]');

  // Test CupertinoTabScaffold with resizeToAvoidBottomInset
  final resizeTabScaffold = CupertinoTabScaffold(
    resizeToAvoidBottomInset: false,
    tabBar: CupertinoTabBar(
      items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: 'Settings'),
      ],
    ),
    tabBuilder: (context, index) {
      return Center(child: Text('No resize'));
    },
  );
  print('CupertinoTabScaffold with resizeToAvoidBottomInset=false created [${resizeTabScaffold.hashCode }]');

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
        icon: Icon(CupertinoIcons.person),
        label: 'Profile',
      ),
    ],
  );
  print('Basic CupertinoTabBar created [${basicTabBar.hashCode }]');

  // Test CupertinoTabBar with currentIndex
  final indexedTabBar = CupertinoTabBar(
    currentIndex: 1,
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        label: 'Search',
      ),
    ],
  );
  print('CupertinoTabBar with currentIndex created [${indexedTabBar.hashCode }]');

  // Test CupertinoTabBar with onTap
  final tappableTabBar = CupertinoTabBar(
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.settings),
        label: 'Settings',
      ),
    ],
    onTap: (index) {
      print('Tab $index tapped');
    },
  );
  print('CupertinoTabBar with onTap created [${tappableTabBar.hashCode}]');

  // Test CupertinoTabBar with backgroundColor
  final bgTabBar = CupertinoTabBar(
    backgroundColor: CupertinoColors.black.withValues(alpha: 0.9),
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.heart),
        label: 'Favorites',
      ),
    ],
  );
  print('CupertinoTabBar with backgroundColor created [${bgTabBar.hashCode }]');

  // Test CupertinoTabBar with activeColor
  final activeColorTabBar = CupertinoTabBar(
    activeColor: CupertinoColors.systemOrange,
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        label: 'Search',
      ),
    ],
  );
  print('CupertinoTabBar with activeColor created [${activeColorTabBar.hashCode }]');

  // Test CupertinoTabBar with inactiveColor
  final inactiveColorTabBar = CupertinoTabBar(
    inactiveColor: CupertinoColors.systemGrey2,
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        label: 'Search',
      ),
    ],
  );
  print('CupertinoTabBar with inactiveColor created [${inactiveColorTabBar.hashCode }]');

  // Test CupertinoTabBar with iconSize
  final sizedIconTabBar = CupertinoTabBar(
    iconSize: 32.0,
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        label: 'Search',
      ),
    ],
  );
  print('CupertinoTabBar with iconSize created [${sizedIconTabBar.hashCode }]');

  // Test CupertinoTabBar with height
  final heightTabBar = CupertinoTabBar(
    height: 60.0,
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        label: 'Search',
      ),
    ],
  );
  print('CupertinoTabBar with height created [${heightTabBar.hashCode }]');

  // Test CupertinoTabBar with border
  final borderTabBar = CupertinoTabBar(
    border: Border(
      top: BorderSide(color: CupertinoColors.systemRed, width: 2.0),
    ),
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        label: 'Search',
      ),
    ],
  );
  print('CupertinoTabBar with border created [${borderTabBar.hashCode }]');

  // ========== CUPERTINOTABVIEW ==========
  print('--- CupertinoTabView Tests ---');

  // Test basic CupertinoTabView
  final basicTabView = CupertinoTabView(
    builder: (context) =>
        CupertinoPageScaffold(child: Center(child: Text('Tab View Content'))),
  );
  print('Basic CupertinoTabView created [${basicTabView.hashCode }]');

  // Test CupertinoTabView with routes
  final routedTabView = CupertinoTabView(
    routes: {
      '/': (context) => Center(child: Text('Home')),
      '/details': (context) => Center(child: Text('Details')),
    },
  );
  print('CupertinoTabView with routes created [${routedTabView.hashCode }]');

  // Test CupertinoTabView with onGenerateRoute
  final generatedTabView = CupertinoTabView(
    onGenerateRoute: (settings) {
      return CupertinoPageRoute(
        builder: (context) =>
            Center(child: Text('Generated: ${settings.name}')),
      );
    },
    builder: (context) => Center(child: Text('Default')),
  );
  print('CupertinoTabView with onGenerateRoute created [${generatedTabView.hashCode }]');

  // Test CupertinoTabView with navigatorKey
  final keyedTabView = CupertinoTabView(
    navigatorKey: GlobalKey<NavigatorState>(),
    builder: (context) => Center(child: Text('Keyed Tab View')),
  );
  print('CupertinoTabView with navigatorKey created [${keyedTabView.hashCode }]');

  print('Cupertino scaffold test completed');

  // Return a visual representation
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
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
      tabBuilder: (context, index) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(['Home', 'Search', 'Settings'][index]),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Tab ${index + 1}', style: TextStyle(fontSize: 24.0)),
                  SizedBox(height: 16.0),
                  Text(
                    'Scaffold & Navigation Tests',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
