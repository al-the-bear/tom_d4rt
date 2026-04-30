// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AppBarTheme, BottomAppBarTheme from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AppBar themes test executing');

  // ========== APPBAR THEME ==========
  print('--- AppBarTheme Tests ---');

  final appBarTheme = AppBarTheme(
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.white,
    elevation: 4.0,
    scrolledUnderElevation: 3.0,
    shadowColor: Colors.black54,
    surfaceTintColor: Colors.indigo.shade100,
    centerTitle: true,
    titleSpacing: 16.0,
    toolbarHeight: 56.0,
    toolbarTextStyle: TextStyle(fontSize: 16.0, color: Colors.white),
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.white, size: 24.0),
    actionsIconTheme: IconThemeData(color: Colors.white70, size: 22.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.0)),
    ),
  );
  print('AppBarTheme created');
  print('  backgroundColor: ${appBarTheme.backgroundColor}');
  print('  foregroundColor: ${appBarTheme.foregroundColor}');
  print('  elevation: ${appBarTheme.elevation}');
  print('  scrolledUnderElevation: ${appBarTheme.scrolledUnderElevation}');
  print('  centerTitle: ${appBarTheme.centerTitle}');
  print('  toolbarHeight: ${appBarTheme.toolbarHeight}');
  print('  titleSpacing: ${appBarTheme.titleSpacing}');
  print('  shadowColor: ${appBarTheme.shadowColor}');
  print('  surfaceTintColor: ${appBarTheme.surfaceTintColor}');
  print('  shape: ${appBarTheme.shape}');

  // Test AppBarTheme copyWith
  final copiedAppBarTheme = appBarTheme.copyWith(
    backgroundColor: Colors.deepPurple,
    elevation: 8.0,
    centerTitle: false,
  );
  print('AppBarTheme.copyWith created');
  print('  new backgroundColor: ${copiedAppBarTheme.backgroundColor}');
  print('  new elevation: ${copiedAppBarTheme.elevation}');
  print('  new centerTitle: ${copiedAppBarTheme.centerTitle}');
  print('  foregroundColor preserved: ${copiedAppBarTheme.foregroundColor}');

  // ========== BOTTOM APP BAR THEME DATA ==========
  print('--- BottomAppBarThemeData Tests ---');

  final bottomAppBarTheme = BottomAppBarThemeData(
    color: Colors.blue.shade50,
    elevation: 8.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue.shade100,
    height: 80.0,
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    shape: CircularNotchedRectangle(),
  );
  print('BottomAppBarThemeData created');
  print('  color: ${bottomAppBarTheme.color}');
  print('  elevation: ${bottomAppBarTheme.elevation}');
  print('  shadowColor: ${bottomAppBarTheme.shadowColor}');
  print('  surfaceTintColor: ${bottomAppBarTheme.surfaceTintColor}');
  print('  height: ${bottomAppBarTheme.height}');
  print('  shape: ${bottomAppBarTheme.shape}');

  // Test BottomAppBarThemeData copyWith
  final copiedBottomAppBarTheme = bottomAppBarTheme.copyWith(
    color: Colors.grey.shade100,
    elevation: 4.0,
  );
  print('BottomAppBarThemeData.copyWith created');
  print('  new color: ${copiedBottomAppBarTheme.color}');
  print('  new elevation: ${copiedBottomAppBarTheme.elevation}');
  print('  height preserved: ${copiedBottomAppBarTheme.height}');

  // ========== WRAP IN THEME WIDGET ==========
  print('--- Theme Integration ---');

  final themeData = ThemeData(
    appBarTheme: appBarTheme,
    bottomAppBarTheme: bottomAppBarTheme,
  );
  print('ThemeData with AppBar themes created');

  return Theme(
    data: themeData,
    child: Builder(
      builder: (ctx) {
        final resolvedTheme = Theme.of(ctx);
        print('Theme.of resolved');
        print(
          '  appBarTheme.backgroundColor: ${resolvedTheme.appBarTheme.backgroundColor}',
        );
        print(
          '  appBarTheme.elevation: ${resolvedTheme.appBarTheme.elevation}',
        );
        print(
          '  bottomAppBarTheme.color: ${resolvedTheme.bottomAppBarTheme.color}',
        );
        print(
          '  bottomAppBarTheme.elevation: ${resolvedTheme.bottomAppBarTheme.elevation}',
        );

        return Scaffold(
          appBar: AppBar(title: Text('AppBar Theme Test')),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(icon: Icon(Icons.home), onPressed: () {}),
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
              ],
            ),
          ),
          body: Center(child: Text('AppBar themes test passed')),
        );
      },
    ),
  );
}
