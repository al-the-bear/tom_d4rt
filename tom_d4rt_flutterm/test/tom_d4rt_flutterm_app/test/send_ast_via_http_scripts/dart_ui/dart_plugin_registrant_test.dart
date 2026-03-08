// D4rt test script: Tests DartPluginRegistrant from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DartPluginRegistrant test executing');

  // DartPluginRegistrant has one static method
  print('DartPluginRegistrant type: ${DartPluginRegistrant}');

  // ensureInitialized — safe to call multiple times
  DartPluginRegistrant.ensureInitialized();
  print('DartPluginRegistrant.ensureInitialized() called');

  DartPluginRegistrant.ensureInitialized();
  print('DartPluginRegistrant.ensureInitialized() called again (idempotent)');

  DartPluginRegistrant.ensureInitialized();
  print('Third call also succeeds');

  print('DartPluginRegistrant test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DartPluginRegistrant Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('ensureInitialized: called 3 times (idempotent)'),
      Text('Type: ${DartPluginRegistrant}'),
    ],
  );
}
