// ignore_for_file: avoid_print
// D4rt test script: Tests NavigationBarTheme, NavigationBarThemeData, NavigationRailTheme, NavigationRailThemeData, DrawerTheme, DrawerThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Navigation themes test executing');

  // ========== NAVIGATION BAR THEME DATA ==========
  print('--- NavigationBarThemeData Tests ---');

  final navBarThemeData = NavigationBarThemeData(
    backgroundColor: Colors.blue.shade50,
    elevation: 3.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue.shade100,
    height: 80.0,
    indicatorColor: Colors.blue.shade200,
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 12.0, color: Colors.blue.shade800),
    ),
    iconTheme: WidgetStateProperty.all(
      IconThemeData(size: 24.0, color: Colors.blue.shade700),
    ),
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
  );
  print('NavigationBarThemeData created');
  print('  backgroundColor: ${navBarThemeData.backgroundColor}');
  print('  elevation: ${navBarThemeData.elevation}');
  print('  height: ${navBarThemeData.height}');
  print('  indicatorColor: ${navBarThemeData.indicatorColor}');
  print('  labelBehavior: ${navBarThemeData.labelBehavior}');

  // Test copyWith
  final copiedNavBarTheme = navBarThemeData.copyWith(
    backgroundColor: Colors.green.shade50,
    elevation: 6.0,
  );
  print('NavigationBarThemeData.copyWith created');
  print('  new backgroundColor: ${copiedNavBarTheme.backgroundColor}');
  print('  new elevation: ${copiedNavBarTheme.elevation}');
  print('  height preserved: ${copiedNavBarTheme.height}');

  // ========== NAVIGATION RAIL THEME DATA ==========
  print('--- NavigationRailThemeData Tests ---');

  final navRailThemeData = NavigationRailThemeData(
    backgroundColor: Colors.grey.shade100,
    elevation: 2.0,
    indicatorColor: Colors.purple.shade200,
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    unselectedLabelTextStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
    selectedLabelTextStyle: TextStyle(
      fontSize: 12.0,
      color: Colors.purple,
      fontWeight: FontWeight.bold,
    ),
    unselectedIconTheme: IconThemeData(size: 22.0, color: Colors.grey),
    selectedIconTheme: IconThemeData(size: 24.0, color: Colors.purple),
    groupAlignment: -1.0,
    labelType: NavigationRailLabelType.all,
    useIndicator: true,
    minWidth: 72.0,
    minExtendedWidth: 256.0,
  );
  print('NavigationRailThemeData created');
  print('  backgroundColor: ${navRailThemeData.backgroundColor}');
  print('  elevation: ${navRailThemeData.elevation}');
  print('  indicatorColor: ${navRailThemeData.indicatorColor}');
  print('  labelType: ${navRailThemeData.labelType}');
  print('  useIndicator: ${navRailThemeData.useIndicator}');
  print('  minWidth: ${navRailThemeData.minWidth}');
  print('  minExtendedWidth: ${navRailThemeData.minExtendedWidth}');
  print('  groupAlignment: ${navRailThemeData.groupAlignment}');

  // Test copyWith
  final copiedNavRailTheme = navRailThemeData.copyWith(
    backgroundColor: Colors.white,
    labelType: NavigationRailLabelType.selected,
  );
  print('NavigationRailThemeData.copyWith created');
  print('  new backgroundColor: ${copiedNavRailTheme.backgroundColor}');
  print('  new labelType: ${copiedNavRailTheme.labelType}');

  // ========== DRAWER THEME DATA ==========
  print('--- DrawerThemeData Tests ---');

  final drawerThemeData = DrawerThemeData(
    backgroundColor: Colors.white,
    elevation: 16.0,
    shadowColor: Colors.black38,
    surfaceTintColor: Colors.grey.shade50,
    width: 304.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(16.0)),
    ),
  );
  print('DrawerThemeData created');
  print('  backgroundColor: ${drawerThemeData.backgroundColor}');
  print('  elevation: ${drawerThemeData.elevation}');
  print('  shadowColor: ${drawerThemeData.shadowColor}');
  print('  width: ${drawerThemeData.width}');
  print('  shape: ${drawerThemeData.shape}');

  // Test copyWith
  final copiedDrawerTheme = drawerThemeData.copyWith(
    backgroundColor: Colors.grey.shade50,
    width: 320.0,
  );
  print('DrawerThemeData.copyWith created');
  print('  new backgroundColor: ${copiedDrawerTheme.backgroundColor}');
  print('  new width: ${copiedDrawerTheme.width}');
  print('  elevation preserved: ${copiedDrawerTheme.elevation}');

  // ========== WRAP IN THEME WIDGET ==========
  print('--- Theme Integration ---');

  final themeData = ThemeData(
    navigationBarTheme: navBarThemeData,
    navigationRailTheme: navRailThemeData,
    drawerTheme: drawerThemeData,
  );
  print('ThemeData with navigation themes created');

  return Theme(
    data: themeData,
    child: Builder(
      builder: (ctx) {
        final resolvedTheme = Theme.of(ctx);
        print('Theme.of resolved');
        print(
          '  navigationBarTheme.height: ${resolvedTheme.navigationBarTheme.height}',
        );
        print(
          '  navigationRailTheme.labelType: ${resolvedTheme.navigationRailTheme.labelType}',
        );
        print('  drawerTheme.width: ${resolvedTheme.drawerTheme.width}');

        return NavigationBarTheme(
          data: navBarThemeData,
          child: NavigationRailTheme(
            data: navRailThemeData,
            child: DrawerTheme(
              data: drawerThemeData,
              child: Card(child: Text('Navigation themes test passed')),
            ),
          ),
        );
      },
    ),
  );
}
