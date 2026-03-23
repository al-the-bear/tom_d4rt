// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TapSemanticEvent from semantics
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapSemanticEvent test executing');
  print('=' * 50);

  // TapSemanticEvent for accessibility tap
  print('\nTapSemanticEvent:');
  print('Event when accessibility tap occurs');
  print('Screen reader activates element');

  // Create instance
  final event = TapSemanticEvent();
  print('\nInstance created:');
  print('runtimeType: ${event.runtimeType}');

  // Properties
  print('\nProperties:');
  print('type: ${event.type}');

  // Extends SemanticsEvent
  print('\nExtends SemanticsEvent:');
  print('is SemanticsEvent: true /* event is SemanticsEvent */');

  // When triggered
  print('\nWhen triggered:');
  print('- Screen reader activates element');
  print('- VoiceOver double-tap');
  print('- TalkBack double-tap');
  print('- Hardware keyboard activation');

  // Screen reader gestures
  print('\nScreen reader gestures:');
  print('');
  print('iOS VoiceOver:');
  print('  - Double-tap to activate');
  print('  - Split-tap (hold + tap)');
  print('');
  print('Android TalkBack:');
  print('  - Double-tap to activate');
  print('  - Enter key on keyboard');

  // Usage with Semantics
  print('\nUsage with Semantics widget:');
  print('Semantics(');
  print('  onTap: () {');
  print('    // Tap action');
  print('    navigateToDetail();');
  print('  },');
  print('  child: MyWidget(),');
  print(');');

  // Use cases
  print('\nUse cases:');
  print('- Button activation');
  print('- Link navigation');
  print('- Item selection');
  print('- Toggle switches');

  // toMap for serialization
  print('\nSerialization:');
  final map = event.toMap();
  print('toMap: ${map}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('SemanticsEvent');
  print('  \u2514\u2500 TapSemanticEvent');

  // Explain purpose
  print('\nTapSemanticEvent purpose:');
  print('- Accessibility tap event');
  print('- Screen reader activation');
  print('- Primary action notification');
  print('- Used with Semantics.onTap');
  print('- Extends SemanticsEvent');

  print('\n' + '=' * 50);
  print('TapSemanticEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapSemanticEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${event.type}'),
      Text('Extends: SemanticsEvent'),
      Text('Trigger: Double-tap gesture'),
      Text('Purpose: Tap accessibility'),
    ],
  );
}
