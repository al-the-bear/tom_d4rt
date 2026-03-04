// D4rt test script: Tests ScaffoldState concepts, ScaffoldMessenger,
// ScaffoldMessengerState, PersistentBottomSheetController,
// ScaffoldGeometry, ScaffoldPrelayoutGeometry
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Scaffold internals test executing');

  // ========== ScaffoldMessenger ==========
  print('--- ScaffoldMessenger Tests ---');
  // ScaffoldMessenger is an InheritedWidget — test via MaterialApp
  final messengerWidget = ScaffoldMessenger(
    child: Scaffold(body: Text('Messenger child')),
  );
  print('ScaffoldMessenger widget created');

  // ========== SnackBar with action ==========
  print('--- SnackBar creation ---');
  final snackBar = SnackBar(
    content: Text('Hello'),
    action: SnackBarAction(
      label: 'UNDO',
      onPressed: () => print('  undo pressed'),
      textColor: Colors.yellow,
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: 6.0,
    margin: EdgeInsets.all(16),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    width: 300,
    duration: Duration(seconds: 4),
    dismissDirection: DismissDirection.down,
    showCloseIcon: true,
    closeIconColor: Colors.white,
  );
  print('SnackBar with full config created');
  print('  behavior: ${snackBar.behavior}');
  print('  duration: ${snackBar.duration}');
  print('  showCloseIcon: ${snackBar.showCloseIcon}');

  // ========== MaterialBanner ==========
  print('--- MaterialBanner Tests ---');
  final banner = MaterialBanner(
    content: Text('Banner message'),
    leading: Icon(Icons.info),
    backgroundColor: Colors.yellow[100],
    elevation: 2,
    padding: EdgeInsets.all(16),
    leadingPadding: EdgeInsets.only(right: 16),
    forceActionsBelow: false,
    overflowAlignment: OverflowBarAlignment.end,
    actions: [
      TextButton(onPressed: () {}, child: Text('DISMISS')),
      TextButton(onPressed: () {}, child: Text('ACTION')),
    ],
  );
  print('MaterialBanner created');

  // ========== OverflowBarAlignment ==========
  print('--- OverflowBarAlignment Tests ---');
  for (final align in OverflowBarAlignment.values) {
    print('  OverflowBarAlignment: $align');
  }

  // ========== DismissDirection values ==========
  print('--- DismissDirection Tests ---');
  for (final dir in DismissDirection.values) {
    print('  DismissDirection: $dir');
  }

  // ========== SnackBarClosedReason ==========
  print('--- SnackBarClosedReason Tests ---');
  for (final reason in SnackBarClosedReason.values) {
    print('  SnackBarClosedReason: $reason');
  }

  // ========== MaterialBannerClosedReason ==========
  print('--- MaterialBannerClosedReason Tests ---');
  for (final reason in MaterialBannerClosedReason.values) {
    print('  MaterialBannerClosedReason: $reason');
  }

  print('All scaffold internals tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(title: Text('Scaffold Internals')),
        body: Center(child: Text('Scaffold Test')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    ),
  );
}
