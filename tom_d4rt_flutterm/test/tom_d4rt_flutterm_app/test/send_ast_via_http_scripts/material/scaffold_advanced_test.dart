// D4rt test script: Tests ScaffoldGeometry, FloatingActionButtonAnimator,
// ScaffoldMessenger, ScaffoldPrelayoutGeometry concepts
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Scaffold advanced test executing');

  // ========== FloatingActionButtonAnimator ==========
  print('--- FloatingActionButtonAnimator Tests ---');
  final animator = FloatingActionButtonAnimator.scaling;
  print('FloatingActionButtonAnimator.scaling: $animator');

  // ========== ScaffoldMessenger concept ==========
  print('--- ScaffoldMessenger Tests ---');
  // ScaffoldMessenger is accessed from context
  print('ScaffoldMessenger accessible via ScaffoldMessenger.of(context)');

  // ========== MaterialBanner advanced ==========
  print('--- MaterialBanner Tests ---');
  final banner = MaterialBanner(
    content: Text('This is a banner'),
    leading: Icon(Icons.info),
    backgroundColor: Colors.yellow.shade100,
    padding: EdgeInsets.all(16.0),
    leadingPadding: EdgeInsets.only(right: 16.0),
    forceActionsBelow: false,
    overflowAlignment: OverflowBarAlignment.end,
    actions: [
      TextButton(onPressed: () {}, child: Text('Dismiss')),
      TextButton(onPressed: () {}, child: Text('Learn More')),
    ],
  );
  print('MaterialBanner created with 2 actions');

  // ========== SnackBar advanced ==========
  print('--- SnackBar advanced Tests ---');
  final snack = SnackBar(
    content: Text('Advanced SnackBar'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {},
      textColor: Colors.white,
    ),
    duration: Duration(seconds: 4),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    width: null,
    elevation: 6.0,
    backgroundColor: Colors.blue.shade800,
    clipBehavior: Clip.antiAlias,
    dismissDirection: DismissDirection.horizontal,
    showCloseIcon: true,
    closeIconColor: Colors.white,
  );
  print('Advanced SnackBar created');
  print('  behavior: ${snack.behavior}');
  print('  elevation: ${snack.elevation}');
  print('  showCloseIcon: ${snack.showCloseIcon}');

  // ========== DismissDirection ==========
  print('--- DismissDirection Tests ---');
  for (final dir in DismissDirection.values) {
    print('DismissDirection: ${dir.name}');
  }

  print('All scaffold advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Scaffold Advanced Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('FloatingActionButtonAnimator.scaling'),
            Text('MaterialBanner with actions'),
            Text('Advanced SnackBar properties'),
          ],
        ),
      ),
    ),
  );
}
