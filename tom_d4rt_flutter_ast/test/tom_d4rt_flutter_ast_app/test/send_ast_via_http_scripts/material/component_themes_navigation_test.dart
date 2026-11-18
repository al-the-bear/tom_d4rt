// ignore_for_file: avoid_print
// D4rt test script: NavigationBarTheme, NavigationRailTheme, TabBarTheme,
// DrawerTheme, BottomAppBarTheme, BadgeTheme, SnackBarTheme,
// MaterialBannerTheme (material, addtests2).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== navigation themes ===');
  final navBar = NavigationBarTheme(
    data: const NavigationBarThemeData(height: 70),
    child: const SizedBox(),
  );
  print('navigation bar height: ${navBar.data.height}');
  print('navigation bar of: ${NavigationBarTheme.of(context).runtimeType}');

  final rail = NavigationRailTheme(
    data: const NavigationRailThemeData(minWidth: 64),
    child: const SizedBox(),
  );
  print('rail minWidth: ${rail.data.minWidth}');

  final tabs = TabBarTheme(
    data: const TabBarThemeData(dividerHeight: 2),
    child: const SizedBox(),
  );
  print('tab bar dividerHeight: ${tabs.data.dividerHeight}');
  print('tab bar of: ${TabBarTheme.of(context).runtimeType}');

  final drawer = DrawerTheme(
    data: const DrawerThemeData(width: 280),
    child: const SizedBox(),
  );
  print('drawer width: ${drawer.data.width}');

  final bottomBar = BottomAppBarTheme(
    data: const BottomAppBarThemeData(height: 60),
    child: const SizedBox(),
  );
  print('bottom app bar height: ${bottomBar.data.height}');

  final badge = BadgeTheme(
    data: const BadgeThemeData(smallSize: 8),
    child: const SizedBox(),
  );
  print('badge smallSize: ${badge.data.smallSize}');

  final snack = SnackBarTheme(
    data: const SnackBarThemeData(elevation: 3),
    child: const SizedBox(),
  );
  print('snack bar elevation: ${snack.data.elevation}');

  final banner = MaterialBannerTheme(
    data: const MaterialBannerThemeData(elevation: 2),
    child: const SizedBox(),
  );
  print('banner elevation: ${banner.data?.elevation}');

  return NavigationBarTheme(
    data: navBar.data,
    child: NavigationBar(
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.search), label: 'Find'),
      ],
    ),
  );
}
