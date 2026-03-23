// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MagnifierDecoration, MagnifierController,
// TextMagnifierConfiguration
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextMagnifier test executing');

  // ========== MagnifierDecoration ==========
  print('--- MagnifierDecoration Tests ---');
  final decoration = MagnifierDecoration(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
    shadows: [
      BoxShadow(color: Colors.black26, blurRadius: 4.0, offset: Offset(0, 2)),
    ],
  );
  print('MagnifierDecoration created');
  print('  shape: ${decoration.shape}');
  print('  shadows: ${decoration.shadows?.length} shadow(s)');

  // Empty decoration
  final emptyDeco = MagnifierDecoration();
  print('Empty MagnifierDecoration: shape=${emptyDeco.shape}');

  // ========== MagnifierController ==========
  print('--- MagnifierController Tests ---');
  final controller = MagnifierController();
  print('MagnifierController created');
  print('  shown: ${controller.shown}');

  // OverlayEntry for magnifier
  controller.hide();
  print('MagnifierController hidden');

  // ========== TextMagnifierConfiguration ==========
  print('--- TextMagnifierConfiguration Tests ---');
  // Disabled configuration
  final disabled = TextMagnifierConfiguration.disabled;
  print('Disabled magnifier config: $disabled');

  print('All text magnifier tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TextMagnifier Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('MagnifierDecoration with rounded shape'),
            Text('MagnifierController created'),
            Text('TextMagnifierConfiguration.disabled'),
          ],
        ),
      ),
    ),
  );
}
