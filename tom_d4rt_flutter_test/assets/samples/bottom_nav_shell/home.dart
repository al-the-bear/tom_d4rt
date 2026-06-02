// Bottom-nav shell.
//
// Three persistent tabs stacked via `IndexedStack` so each one keeps
// its `Element` (and therefore its state, scroll positions, and
// inner Navigator stack) when inactive. Each tab is wrapped in its
// own `TabNavigator`, so pushing a detail route only affects that
// tab.
//
// Back-button handling:
//   • The system back gesture is intercepted by `PopScope` at the
//     shell level. The handler pops the *active* tab's Navigator if
//     it has anything to pop; otherwise it lets the framework
//     handle the pop normally.
//   • Tapping the already-active bottom-nav destination pops that
//     tab's Navigator back to its root — a common UX shortcut.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'tab_home.dart';
import 'tab_navigator.dart';
import 'tab_profile.dart';
import 'tab_search.dart';

class BottomNavShellHome extends StatefulWidget {
  const BottomNavShellHome({super.key});

  @override
  State<BottomNavShellHome> createState() => _BottomNavShellHomeState();
}

class _BottomNavShellHomeState extends State<BottomNavShellHome> {
  int _index = 0;

  final List<GlobalKey<NavigatorState>> _navKeys =
      <GlobalKey<NavigatorState>>[
    GlobalKey<NavigatorState>(debugLabel: 'tab-home-nav'),
    GlobalKey<NavigatorState>(debugLabel: 'tab-search-nav'),
    GlobalKey<NavigatorState>(debugLabel: 'tab-profile-nav'),
  ];

  static const List<String> _tabIds = <String>['home', 'search', 'profile'];

  void _onTap(int i) {
    if (i == _index) {
      // Tap the active tab → pop that tab back to root.
      final NavigatorState? nav = _navKeys[i].currentState;
      if (nav != null && nav.canPop()) {
        nav.popUntil((Route<dynamic> r) => r.isFirst);
        print('nav.poproot tab=${_tabIds[i]}');
      }
      return;
    }
    setState(() {
      print('nav.switch from=${_tabIds[_index]} to=${_tabIds[i]}');
      _index = i;
    });
  }

  void _onPopInvoked(bool didPop) {
    if (didPop) return;
    final NavigatorState? nav = _navKeys[_index].currentState;
    if (nav != null && nav.canPop()) {
      nav.pop();
      print('nav.innerpop tab=${_tabIds[_index]}');
    } else {
      print('nav.rootpop tab=${_tabIds[_index]}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: _onPopInvoked,
      child: Scaffold(
        body: IndexedStack(
          key: const Key('bn-stack'),
          index: _index,
          children: <Widget>[
            TabNavigator(
              key: const Key('bn-nav-home'),
              navKey: _navKeys[0],
              tabId: 'home',
              root: const TabHome(),
            ),
            TabNavigator(
              key: const Key('bn-nav-search'),
              navKey: _navKeys[1],
              tabId: 'search',
              root: const TabSearch(),
            ),
            TabNavigator(
              key: const Key('bn-nav-profile'),
              navKey: _navKeys[2],
              tabId: 'profile',
              root: const TabProfile(),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          key: const Key('bn-bar'),
          currentIndex: _index,
          onTap: _onTap,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
