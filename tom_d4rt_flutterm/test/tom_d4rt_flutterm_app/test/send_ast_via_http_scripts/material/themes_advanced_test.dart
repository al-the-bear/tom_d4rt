// D4rt test script: Tests material BottomNavigationBarType,
// BottomNavigationBarThemeData, AppBarTheme advanced,
// DrawerThemeData, IconButtonThemeData, FloatingActionButtonThemeData
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('Material themes advanced test executing');

  // ========== BottomNavigationBarType ==========
  print('--- BottomNavigationBarType Tests ---');
  for (final type in BottomNavigationBarType.values) {
    print('BottomNavigationBarType: ${type.name}');
  }

  // ========== BottomNavigationBarThemeData ==========
  print('--- BottomNavigationBarThemeData Tests ---');
  final botNavTheme = BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 8.0,
    selectedIconTheme: IconThemeData(color: Colors.blue, size: 24.0),
    unselectedIconTheme: IconThemeData(color: Colors.grey, size: 24.0),
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
    unselectedLabelStyle: TextStyle(fontSize: 12.0),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    enableFeedback: true,
    landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
  );
  print('BottomNavigationBarThemeData created');
  print('  type: ${botNavTheme.type}');

  // ========== BottomNavigationBarLandscapeLayout ==========
  print('--- BottomNavigationBarLandscapeLayout Tests ---');
  for (final layout in BottomNavigationBarLandscapeLayout.values) {
    print('BottomNavigationBarLandscapeLayout: ${layout.name}');
  }

  // ========== AppBarTheme advanced ==========
  print('--- AppBarTheme advanced Tests ---');
  final appBarTheme = AppBarTheme(
    color: Colors.indigo,
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.white,
    elevation: 4.0,
    scrolledUnderElevation: 8.0,
    shadowColor: Colors.black38,
    surfaceTintColor: Colors.indigo.shade100,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
    ),
    iconTheme: IconThemeData(color: Colors.white, size: 24.0),
    actionsIconTheme: IconThemeData(color: Colors.white, size: 24.0),
    titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white),
    toolbarTextStyle: TextStyle(fontSize: 14.0, color: Colors.white70),
    centerTitle: true,
    toolbarHeight: 56.0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  );
  print('AppBarTheme advanced created');
  print('  elevation: ${appBarTheme.elevation}');

  // ========== DrawerThemeData ==========
  print('--- DrawerThemeData Tests ---');
  final drawerTheme = DrawerThemeData(
    backgroundColor: Colors.white,
    elevation: 16.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.grey.shade50,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
    ),
    width: 304.0,
    scrimColor: Colors.black54,
    endShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
    ),
    clipBehavior: Clip.antiAlias,
  );
  print('DrawerThemeData created: width=${drawerTheme.width}');

  // ========== IconButtonThemeData ==========
  print('--- IconButtonThemeData Tests ---');
  final iconBtnTheme = IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: Colors.blue,
      backgroundColor: Colors.blue.shade50,
      disabledForegroundColor: Colors.grey,
      hoverColor: Colors.blue.shade100,
      focusColor: Colors.blue.shade200,
      highlightColor: Colors.blue.shade300,
      iconSize: 24.0,
      minimumSize: Size(40.0, 40.0),
      shape: CircleBorder(),
    ),
  );
  print('IconButtonThemeData created');

  // ========== FloatingActionButtonThemeData ==========
  print('--- FloatingActionButtonThemeData Tests ---');
  final fabTheme = FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    focusColor: Colors.blue.shade300,
    hoverColor: Colors.blue.shade200,
    splashColor: Colors.blue.shade400,
    elevation: 6.0,
    focusElevation: 8.0,
    hoverElevation: 10.0,
    disabledElevation: 2.0,
    highlightElevation: 12.0,
    shape: CircleBorder(),
    enableFeedback: true,
    iconSize: 24.0,
    sizeConstraints: BoxConstraints.tightFor(width: 56.0, height: 56.0),
    smallSizeConstraints: BoxConstraints.tightFor(width: 40.0, height: 40.0),
    largeSizeConstraints: BoxConstraints.tightFor(width: 96.0, height: 96.0),
    extendedSizeConstraints: BoxConstraints(minWidth: 80.0, minHeight: 48.0),
    extendedIconLabelSpacing: 8.0,
    extendedPadding: EdgeInsets.symmetric(horizontal: 16.0),
    extendedTextStyle: TextStyle(fontSize: 14.0),
    mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
  );
  print('FloatingActionButtonThemeData created');
  print('  elevation: ${fabTheme.elevation}');

  print('All material themes advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    theme: ThemeData(
      appBarTheme: appBarTheme,
      bottomNavigationBarTheme: botNavTheme,
      drawerTheme: drawerTheme,
      iconButtonTheme: iconBtnTheme,
      floatingActionButtonTheme: fabTheme,
    ),
    home: Scaffold(
      appBar: AppBar(title: Text('Themes Advanced')),
      drawer: Drawer(child: ListView(children: [DrawerHeader(child: Text('Menu'))])),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Material Themes Advanced Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 16.0),
            Text('AppBarTheme, DrawerTheme'),
            Text('IconButtonTheme, FABTheme'),
            Text('BottomNavBarTheme'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    ),
  );
}
