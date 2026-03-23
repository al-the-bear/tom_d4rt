// ignore_for_file: avoid_print
// D4rt test script: Tests DoNothingAction, ActivateIntent, DismissIntent
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Shortcuts and actions test executing');

  // ========== Intents ==========
  print('--- Intent Tests ---');

  final activateIntent = ActivateIntent();
  print('ActivateIntent: $activateIntent');

  final dismissIntent = DismissIntent();
  print('DismissIntent: $dismissIntent');

  // ========== Actions ==========
  print('--- Action Tests ---');

  final doNothing = DoNothingAction();
  // consumesKey is a method (takes Intent), not a getter
  print('DoNothingAction: consumesKey=${doNothing.consumesKey(ActivateIntent())}');

  final doNothingNoConsume = DoNothingAction(consumesKey: false);
  print(
    'DoNothingAction(consumesKey: false): consumesKey=${doNothingNoConsume.consumesKey(ActivateIntent())}',
  );

  print('All shortcuts and actions tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Text('Shortcuts & Actions Tests OK'),
      ),
    ),
  );
}
