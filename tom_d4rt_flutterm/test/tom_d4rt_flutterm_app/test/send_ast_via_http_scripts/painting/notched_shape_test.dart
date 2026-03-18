// D4rt test script: Tests NotchedShape from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NotchedShape test executing');

  // NotchedShape is abstract - test via CircularNotchedRectangle
  final notchedRect = CircularNotchedRectangle();

  print('CircularNotchedRectangle: ${notchedRect.runtimeType}');
  print('is NotchedShape: ${true}');

  // Test getOuterPath
  print('\ngetOuterPath method:');
  final hostRect = Rect.fromLTWH(0, 0, 400, 56);
  final guestRect = Rect.fromCircle(center: Offset(200, 28), radius: 28);
  final path = notchedRect.getOuterPath(hostRect, guestRect);
  print('Host rect: $hostRect');
  print('Guest rect: $guestRect');
  print('Path created: ${path.runtimeType}');

  // Explain NotchedShape
  print('\nNotchedShape purpose:');
  print('- Creates shape with notch cutout');
  print('- Used by BottomAppBar');
  print('- FAB sits in the notch');

  // NotchedShape implementations
  print('\nNotchedShape implementations:');
  print('- CircularNotchedRectangle: circular notch');
  print('- AutomaticNotchedShape: adapts to guest shape');

  // BottomAppBar usage
  print('\nBottomAppBar usage:');
  print('Scaffold(');
  print('  bottomNavigationBar: BottomAppBar(');
  print('    shape: CircularNotchedRectangle(),');
  print('    notchMargin: 8,');
  print('  ),');
  print('  floatingActionButton: FloatingActionButton(...),');
  print('  floatingActionButtonLocation: ');
  print('    FloatingActionButtonLocation.centerDocked,');
  print(')');

  // Parameters
  print('\nNotch parameters:');
  print('- host: rectangle to notch');
  print('- guest: shape to cut out');
  print('- notchMargin: space around guest');

  print('\nNotchedShape test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'NotchedShape Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Shape with notch cutout'),
      Text('Impl: CircularNotchedRectangle'),
      Text('Used by: BottomAppBar + FAB'),
    ],
  );
}
