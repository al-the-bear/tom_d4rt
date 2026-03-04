// D4rt test script: Tests CupertinoSliverRefreshControl, CupertinoMagnifier,
// CupertinoPageTransition, CupertinoFullscreenDialogTransition,
// CupertinoTabView, CupertinoTabScaffold, CupertinoTabController
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

dynamic build(BuildContext context) {
  print('Cupertino refresh/magnifier test executing');

  // ========== CupertinoSliverRefreshControl ==========
  print('--- CupertinoSliverRefreshControl Tests ---');
  final refreshControl = CupertinoSliverRefreshControl(
    refreshTriggerPullDistance: 100.0,
    refreshIndicatorExtent: 60.0,
    onRefresh: () async {
      print('  Refreshing...');
      await Future.delayed(Duration(seconds: 1));
    },
  );
  print('CupertinoSliverRefreshControl created');
  print('  refreshTriggerPullDistance: 100.0');
  print('  refreshIndicatorExtent: 60.0');

  // ========== CupertinoMagnifier ==========
  print('--- CupertinoMagnifier Tests ---');
  final magnifier = CupertinoMagnifier(
    size: Size(80, 48),
    borderRadius: BorderRadius.circular(40),
    // inOutAnimation requires Animation<double>, skip for this test
    additionalFocalPointOffset: Offset(0, -8),
  );
  print('CupertinoMagnifier created');

  // ========== CupertinoPageTransition ==========
  print('--- CupertinoPageTransition Tests ---');
  final animationController = AnimationController(
    vsync: TestVSync(),
    duration: Duration(milliseconds: 300),
  );

  final pageTransition = CupertinoPageTransition(
    primaryRouteAnimation: animationController,
    secondaryRouteAnimation: animationController,
    linearTransition: false,
    child: Container(
      color: Colors.blue,
      child: Center(child: Text('Page Content')),
    ),
  );
  print('CupertinoPageTransition created');

  // ========== CupertinoFullscreenDialogTransition ==========
  print('--- CupertinoFullscreenDialogTransition Tests ---');
  final dialogTransition = CupertinoFullscreenDialogTransition(
    primaryRouteAnimation: animationController,
    secondaryRouteAnimation: animationController,
    linearTransition: false,
    child: Container(
      color: Colors.white,
      child: Center(child: Text('Dialog Content')),
    ),
  );
  print('CupertinoFullscreenDialogTransition created');

  // ========== CupertinoTabController ==========
  print('--- CupertinoTabController Tests ---');
  final tabController = CupertinoTabController(initialIndex: 0);
  print('CupertinoTabController created: index=${tabController.index}');
  tabController.index = 1;
  print('  Set index to 1: ${tabController.index}');
  tabController.index = 0;
  tabController.dispose();
  print('  Disposed');

  // ========== CupertinoTabScaffold ==========
  print('--- CupertinoTabScaffold Tests ---');
  final tabScaffold = CupertinoTabScaffold(
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
      activeColor: CupertinoColors.activeBlue,
      inactiveColor: CupertinoColors.inactiveGray,
      backgroundColor: CupertinoColors.systemBackground,
      iconSize: 30.0,
      height: 50.0,
    ),
    tabBuilder: (context, index) {
      return CupertinoTabView(
        builder: (context) {
          return Center(child: Text('Tab $index'));
        },
      );
    },
    backgroundColor: CupertinoColors.systemBackground,
    resizeToAvoidBottomInset: true,
  );
  print('CupertinoTabScaffold created');

  // ========== CupertinoTabView ==========
  print('--- CupertinoTabView Tests ---');
  final tabView = CupertinoTabView(
    builder: (context) => Center(child: Text('Tab View')),
    routes: {
      '/detail': (context) => Center(child: Text('Detail')),
    },
    defaultTitle: 'Tab',
  );
  print('CupertinoTabView created');

  print('All cupertino refresh/magnifier tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                refreshControl,
                SliverList(
                  delegate: SliverChildListDelegate([
                    magnifier,
                    pageTransition,
                    dialogTransition,
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class TestVSync implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
