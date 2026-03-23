// ignore_for_file: avoid_print
// D4rt test script: Tests material FAB location, ScaffoldMessenger,
// SnackBarBehavior, FloatingActionButtonLocation
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FAB location and scaffold messenger test executing');

  // ========== FloatingActionButtonLocation ==========
  print('--- FloatingActionButtonLocation Tests ---');

  print('FABLocation.endFloat: ${FloatingActionButtonLocation.endFloat}');
  print('FABLocation.centerFloat: ${FloatingActionButtonLocation.centerFloat}');
  print('FABLocation.endDocked: ${FloatingActionButtonLocation.endDocked}');
  print(
    'FABLocation.centerDocked: ${FloatingActionButtonLocation.centerDocked}',
  );
  print('FABLocation.endTop: ${FloatingActionButtonLocation.endTop}');
  print('FABLocation.startTop: ${FloatingActionButtonLocation.startTop}');
  print(
    'FABLocation.endContained: ${FloatingActionButtonLocation.endContained}',
  );
  print(
    'FABLocation.miniStartTop: ${FloatingActionButtonLocation.miniStartTop}',
  );
  print('FABLocation.miniEndTop: ${FloatingActionButtonLocation.miniEndTop}');
  print(
    'FABLocation.miniCenterTop: ${FloatingActionButtonLocation.miniCenterTop}',
  );
  print(
    'FABLocation.miniStartFloat: ${FloatingActionButtonLocation.miniStartFloat}',
  );
  print(
    'FABLocation.miniEndFloat: ${FloatingActionButtonLocation.miniEndFloat}',
  );
  print(
    'FABLocation.miniCenterFloat: ${FloatingActionButtonLocation.miniCenterFloat}',
  );
  print(
    'FABLocation.miniStartDocked: ${FloatingActionButtonLocation.miniStartDocked}',
  );
  print(
    'FABLocation.miniEndDocked: ${FloatingActionButtonLocation.miniEndDocked}',
  );
  print(
    'FABLocation.miniCenterDocked: ${FloatingActionButtonLocation.miniCenterDocked}',
  );

  // ========== SnackBarBehavior ==========
  print('--- SnackBarBehavior Tests ---');

  print('SnackBarBehavior.fixed: ${SnackBarBehavior.fixed}');
  print('SnackBarBehavior.floating: ${SnackBarBehavior.floating}');

  // ========== SnackBarClosedReason ==========
  print('--- SnackBarClosedReason Tests ---');

  print('SnackBarClosedReason.action: ${SnackBarClosedReason.action}');
  print('SnackBarClosedReason.dismiss: ${SnackBarClosedReason.dismiss}');
  print('SnackBarClosedReason.swipe: ${SnackBarClosedReason.swipe}');
  print('SnackBarClosedReason.hide: ${SnackBarClosedReason.hide}');
  print('SnackBarClosedReason.remove: ${SnackBarClosedReason.remove}');
  print('SnackBarClosedReason.timeout: ${SnackBarClosedReason.timeout}');
  print('SnackBarClosedReason.values: ${SnackBarClosedReason.values}');

  // ========== MaterialBanner/SnackBar actions ==========
  print('--- SnackBarAction Tests ---');

  final snackAction = SnackBarAction(
    label: 'UNDO',
    onPressed: () => print('Undo pressed'),
    textColor: Colors.yellow,
  );
  print('SnackBarAction label: ${snackAction.label}');

  // ========== MaterialBannerClosedReason ==========
  print('--- MaterialBannerClosedReason Tests ---');

  print(
    'MaterialBannerClosedReason.dismiss: ${MaterialBannerClosedReason.dismiss}',
  );
  print(
    'MaterialBannerClosedReason.swipe: ${MaterialBannerClosedReason.swipe}',
  );
  print('MaterialBannerClosedReason.hide: ${MaterialBannerClosedReason.hide}');
  print(
    'MaterialBannerClosedReason.remove: ${MaterialBannerClosedReason.remove}',
  );

  // ========== TabBarIndicatorSize ==========
  print('--- TabBarIndicatorSize Tests ---');

  print('TabBarIndicatorSize.tab: ${TabBarIndicatorSize.tab}');
  print('TabBarIndicatorSize.label: ${TabBarIndicatorSize.label}');

  print('All FAB location and scaffold messenger tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('FAB Location Test')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'FAB Location Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Text('SnackBarBehavior: floating'),
            Text('FAB location: endFloat'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('FAB pressed'),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () {}),
            IconButton(icon: Icon(Icons.settings), onPressed: () {}),
          ],
        ),
      ),
    ),
  );
}
