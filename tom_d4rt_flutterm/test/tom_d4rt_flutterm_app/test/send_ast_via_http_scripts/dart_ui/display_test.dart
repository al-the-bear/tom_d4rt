// D4rt test script: Tests Display from dart:ui via PlatformDispatcher
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Display test executing');

  // Access displays via PlatformDispatcher
  final dispatcher = ui.PlatformDispatcher.instance;
  final displays = dispatcher.displays;
  print('Number of displays: ${displays.length}');

  final displayTexts = <String>[];

  for (final display in displays) {
    print('Display id: ${display.id}');
    print('  devicePixelRatio: ${display.devicePixelRatio}');
    print('  size: ${display.size}');
    print('  refreshRate: ${display.refreshRate}');
    print('  toString: ${display.toString()}');
    displayTexts.add('Display ${display.id}: ${display.size.width.toInt()}x${display.size.height.toInt()} @${display.devicePixelRatio}x');
  }

  // Access primary display through implicitView
  final view = dispatcher.implicitView;
  if (view != null) {
    final primaryDisplay = view.display;
    print('Primary display id: ${primaryDisplay.id}');
    print('Primary DPR: ${primaryDisplay.devicePixelRatio}');
    print('Primary size: ${primaryDisplay.size}');
    print('Primary refresh: ${primaryDisplay.refreshRate}');
  }

  print('Display test completed');
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Display Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 16.0),
            Text('Displays found: ${displays.length}'),
            for (final dt in displayTexts) Text(dt),
          ],
        ),
      ),
    ),
  );
}
