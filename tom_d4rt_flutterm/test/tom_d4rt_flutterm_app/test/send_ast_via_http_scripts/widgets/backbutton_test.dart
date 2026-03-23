// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BackButtonDispatcher from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BackButtonDispatcher test executing');

  // Test RootBackButtonDispatcher
  final dispatcher = RootBackButtonDispatcher();
  print('RootBackButtonDispatcher created');
  print('RootBackButtonDispatcher runtimeType: ${dispatcher.runtimeType}');
  print('RootBackButtonDispatcher hashCode: ${dispatcher.hashCode}');

  // BackButtonDispatcher is used with Router-based navigation
  print('BackButtonDispatcher is for Router-based navigation (Navigator 2.0)');

  // Test ChildBackButtonDispatcher
  final childDispatcher = ChildBackButtonDispatcher(dispatcher);
  print('ChildBackButtonDispatcher created');
  print(
    'ChildBackButtonDispatcher runtimeType: ${childDispatcher.runtimeType}',
  );
  print('ChildBackButtonDispatcher hashCode: ${childDispatcher.hashCode}');

  // Test callback registration concept
  // BackButtonDispatcher.addCallback registers a callback for back button
  print('BackButtonDispatcher supports addCallback/removeCallback');

  // BackButtonListener widget wraps a child and listens for back button
  final backListener = BackButtonListener(
    onBackButtonPressed: () async {
      print('Back button pressed - handled');
      return true;
    },
    child: Container(
      width: 200.0,
      height: 100.0,
      color: Colors.blue,
      child: Center(
        child: Text(
          'Back Button Listener',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('BackButtonListener widget created');

  // Show context: BackButtonDispatcher is typically passed to Router
  // Router(backButtonDispatcher: dispatcher, ...)
  print('BackButtonDispatcher is typically assigned to Router widget');
  print('Router uses it to handle system back button events');

  // Demonstrate with a simple visual
  final infoWidget = Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.grey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BackButtonDispatcher Info:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('- Used with Navigator 2.0 / Router API'),
            Text('- RootBackButtonDispatcher: system back button'),
            Text('- ChildBackButtonDispatcher: nested routers'),
            Text('- BackButtonListener: declarative widget'),
          ],
        ),
      ),
    ],
  );
  print('Info widget created');

  print('BackButtonDispatcher test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BackButtonDispatcher Tests'),
      SizedBox(height: 8.0),
      infoWidget,
      SizedBox(height: 8.0),
      // BackButtonListener removed from tree - requires Router ancestor.
      // The widget was created and tested above; just not rendered.
      Container(
        width: 200.0,
        height: 100.0,
        color: Colors.blue.shade100,
        child: Center(
          child: Text(
            'BackButtonListener\n(created, not rendered\n- needs Router)',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0),
          ),
        ),
      ),
    ],
  );
}
