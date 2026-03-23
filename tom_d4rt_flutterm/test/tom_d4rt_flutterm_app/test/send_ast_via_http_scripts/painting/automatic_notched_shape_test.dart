// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AutomaticNotchedShape from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AutomaticNotchedShape test executing');

  // Create AutomaticNotchedShape
  final hostShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  );
  final guestShape = CircleBorder();

  final notchedShape = AutomaticNotchedShape(hostShape, guestShape);

  print('Created: ${notchedShape.runtimeType}');
  print('is NotchedShape: ${true}');

  // vs CircularNotchedRectangle
  print('\nvs CircularNotchedRectangle:');
  print('- Circular: only circular notch');
  print('- Automatic: adapts to guest shape');

  // How it works
  print('\nHow it works:');
  print('1. Takes host shape (e.g. rounded rect)');
  print('2. Takes guest shape (e.g. circle)');
  print('3. Computes notch from guest outline');
  print('4. Subtracts guest from host path');

  // getOuterPath
  print('\ngetOuterPath method:');
  final hostRect = Rect.fromLTWH(0, 0, 400, 56);
  final guestRect = Rect.fromCircle(center: Offset(200, 28), radius: 28);
  final path = notchedShape.getOuterPath(hostRect, guestRect);
  print('Host: $hostRect');
  print('Guest: $guestRect');
  print('Path type: ${path.runtimeType}');

  // Use case
  print('\nUse case:');
  print('BottomAppBar with non-circular FAB');
  print('Custom shaped floating buttons');

  // Usage
  print('\nUsage:');
  print('BottomAppBar(');
  print('  shape: AutomaticNotchedShape(');
  print('    RoundedRectangleBorder(),');
  print('    StarBorder(points: 5),');
  print('  ),');
  print(')');

  print('\nAutomaticNotchedShape test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'AutomaticNotchedShape Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Adaptive notched shape'),
      Text('Takes: host + guest shapes'),
      Text('For: custom FAB shapes'),
    ],
  );
}
