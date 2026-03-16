// D4rt test script: Tests ScaffoldState, ScaffoldMessengerState from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScaffoldState test executing');

  // The test app wraps us inside MaterialApp -> Scaffold -> body
  // So ScaffoldMessenger.of(context) should work from the build context

  // Test ScaffoldMessenger.of(context) — this looks above our widget
  final messenger = ScaffoldMessenger.of(context);
  print('ScaffoldMessengerState: ${messenger.runtimeType}');
  print('ScaffoldMessenger mounted: ${messenger.mounted}');

  // ScaffoldMessenger.maybeOf
  final maybeMessenger = ScaffoldMessenger.maybeOf(context);
  print('ScaffoldMessenger.maybeOf: ${maybeMessenger?.runtimeType}');
  print(
    'ScaffoldMessenger same instance: ${identical(messenger, maybeMessenger)}',
  );

  // For Scaffold.of(context), we need a context that is a descendant
  // of the Scaffold. Since we are in the Scaffold body, our build context
  // should work. But to be safe, use Builder to get a fresh context.
  return Builder(
    builder: (innerCtx) {
      // Try Scaffold.of with the inner context
      try {
        final scaffoldState = Scaffold.of(innerCtx);
        print('ScaffoldState: ${scaffoldState.runtimeType}');
        print('Scaffold hasDrawer: ${scaffoldState.hasDrawer}');
        print('Scaffold hasEndDrawer: ${scaffoldState.hasEndDrawer}');
        print(
          'Scaffold hasFloatingActionButton: ${scaffoldState.hasFloatingActionButton}',
        );
        print('Scaffold isDrawerOpen: ${scaffoldState.isDrawerOpen}');
        print('Scaffold isEndDrawerOpen: ${scaffoldState.isEndDrawerOpen}');

        // Also test Scaffold.maybeOf
        final maybeScaffold = Scaffold.maybeOf(innerCtx);
        print('Scaffold.maybeOf: ${maybeScaffold?.runtimeType}');
      } catch (e) {
        print('Scaffold.of failed: $e');
      }

      // Schedule a SnackBar to test ScaffoldMessenger functionality
      Future.microtask(() {
        messenger.showSnackBar(
          SnackBar(
            content: Text('Test SnackBar from ScaffoldState test'),
            duration: Duration(seconds: 2),
          ),
        );
        print('showSnackBar called via ScaffoldMessenger');
      });

      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ScaffoldState test passed'),
            Text('ScaffoldMessenger: ${messenger.runtimeType}'),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                messenger.showSnackBar(
                  SnackBar(
                    content: Text('SnackBar from button press'),
                    duration: Duration(seconds: 1),
                  ),
                );
                print('Button SnackBar shown');
              },
              child: Text('Show SnackBar'),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                messenger.hideCurrentSnackBar();
                print('hideCurrentSnackBar called');
              },
              child: Text('Hide SnackBar'),
            ),
          ],
        ),
      );
    },
  );
}
