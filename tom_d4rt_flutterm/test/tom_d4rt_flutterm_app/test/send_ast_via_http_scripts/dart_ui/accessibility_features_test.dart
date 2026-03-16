// D4rt test script: Tests AccessibilityFeatures from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AccessibilityFeatures test executing');

  // Access via PlatformDispatcher
  final dispatcher = ui.PlatformDispatcher.instance;
  final features = dispatcher.accessibilityFeatures;
  print('AccessibilityFeatures type: ${features.runtimeType}');

  // Test all boolean getters
  print('accessibleNavigation: ${features.accessibleNavigation}');
  print('invertColors: ${features.invertColors}');
  print('disableAnimations: ${features.disableAnimations}');
  print('boldText: ${features.boldText}');
  print('reduceMotion: ${features.reduceMotion}');
  print('highContrast: ${features.highContrast}');
  print('onOffSwitchLabels: ${features.onOffSwitchLabels}');

  // Equality and hashCode
  final features2 = dispatcher.accessibilityFeatures;
  print('same instance equality: ${features == features2}');
  print('hashCode: ${features.hashCode}');
  print('toString: ${features.toString()}');

  // Access via MediaQuery in widget context
  final mq = MediaQuery.of(context);
  print('MediaQuery accessibleNavigation: ${mq.accessibleNavigation}');
  print('MediaQuery boldText: ${mq.boldText}');
  print('MediaQuery disableAnimations: ${mq.disableAnimations}');
  print('MediaQuery invertColors: ${mq.invertColors}');
  print('MediaQuery highContrast: ${mq.highContrast}');

  print('AccessibilityFeatures test completed');
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('AccessibilityFeatures Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 16.0),
            Text('accessibleNavigation: ${features.accessibleNavigation}'),
            Text('invertColors: ${features.invertColors}'),
            Text('disableAnimations: ${features.disableAnimations}'),
            Text('boldText: ${features.boldText}'),
            Text('reduceMotion: ${features.reduceMotion}'),
            Text('highContrast: ${features.highContrast}'),
            Text('onOffSwitchLabels: ${features.onOffSwitchLabels}'),
          ],
        ),
      ),
    ),
  );
}
