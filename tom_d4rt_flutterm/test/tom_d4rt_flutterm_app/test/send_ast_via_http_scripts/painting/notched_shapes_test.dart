// ignore_for_file: avoid_print
// D4rt test script: Tests CircularNotchedRectangle from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CircularNotchedRectangle test executing');

  // ========== CIRCULARNOTCHEDRECTANGLE ==========
  print('--- CircularNotchedRectangle Tests ---');

  // CircularNotchedRectangle creates a rectangle with a circular notch
  // Used for BottomAppBar with FAB
  final notchedShape = CircularNotchedRectangle();
  print('CircularNotchedRectangle created');
  print('Type: ${notchedShape.runtimeType}');

  // Test getOuterPath with a host rect and a guest (FAB) rect
  final hostRect = Rect.fromLTWH(0.0, 0.0, 400.0, 56.0);
  final guestRect = Rect.fromCircle(center: Offset(200.0, 0.0), radius: 28.0);

  final path = notchedShape.getOuterPath(hostRect, guestRect);
  print('getOuterPath created path type: ${path.runtimeType}');

  // Test getOuterPath without guest (no notch)
  final pathNoGuest = notchedShape.getOuterPath(hostRect, null);
  print('getOuterPath without guest type: ${pathNoGuest.runtimeType}');

  // Test with different FAB positions
  final guestLeft = Rect.fromCircle(center: Offset(50.0, 0.0), radius: 28.0);
  final pathLeft = notchedShape.getOuterPath(hostRect, guestLeft);
  print('getOuterPath with left guest created [${pathLeft.hashCode }]');

  final guestRight = Rect.fromCircle(center: Offset(350.0, 0.0), radius: 28.0);
  final pathRight = notchedShape.getOuterPath(hostRect, guestRight);
  print('getOuterPath with right guest created [${pathRight.hashCode }]');

  // Test with different notch sizes
  final smallGuest = Rect.fromCircle(center: Offset(200.0, 0.0), radius: 14.0);
  final pathSmall = notchedShape.getOuterPath(hostRect, smallGuest);
  print('getOuterPath with small notch created [${pathSmall.hashCode }]');

  final largeGuest = Rect.fromCircle(center: Offset(200.0, 0.0), radius: 40.0);
  final pathLarge = notchedShape.getOuterPath(hostRect, largeGuest);
  print('getOuterPath with large notch created [${pathLarge.hashCode }]');

  print('All CircularNotchedRectangle tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CircularNotchedRectangle Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            // Demonstrate with actual BottomAppBar
            SizedBox(
              height: 80.0,
              child: Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {},
                  mini: true,
                  child: Icon(Icons.add),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: BottomAppBar(
                  shape: CircularNotchedRectangle(),
                  notchMargin: 4.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.home, size: 20.0),
                      SizedBox(width: 48.0),
                      Icon(Icons.settings, size: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
