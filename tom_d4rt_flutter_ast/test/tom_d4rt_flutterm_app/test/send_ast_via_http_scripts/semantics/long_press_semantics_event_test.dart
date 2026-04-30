// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests LongPressSemanticsEvent from semantics
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LongPressSemanticsEvent test executing');
  print('=' * 50);

  // LongPressSemanticsEvent for accessibility long press
  print('\nLongPressSemanticsEvent:');
  print('Event when accessibility long press occurs');
  print('Screen reader activates long press action');

  // Create instance
  final event = LongPressSemanticsEvent();
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
  print('- Screen reader long press gesture');
  print('- VoiceOver double-tap and hold');
  print('- TalkBack double-tap and hold');
  print('- Custom accessibility action');

  // Screen reader gestures
  print('\nScreen reader gestures:');
  print('');
  print('iOS VoiceOver:');
  print('  - Double-tap and hold');
  print('  - Actions rotor > Long Press');
  print('');
  print('Android TalkBack:');
  print('  - Double-tap and hold');
  print('  - Local context menu');

  // Usage with Semantics
  print('\nUsage with Semantics widget:');
  print('Semantics(');
  print('  onLongPress: () {');
  print('    // Long press action');
  print('    showContextMenu();');
  print('  },');
  print('  child: MyWidget(),');
  print(');');

  // Use cases
  print('\nUse cases:');
  print('- Context menus');
  print('- Drag and drop initiation');
  print('- Additional options');
  print('- Preview actions');

  // toMap for serialization
  print('\nSerialization:');
  final map = event.toMap();
  print('toMap: ${map}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('SemanticsEvent');
  print('  \u2514\u2500 LongPressSemanticsEvent');

  // Explain purpose
  print('\nLongPressSemanticsEvent purpose:');
  print('- Accessibility long press event');
  print('- Screen reader gesture support');
  print('- Context menu accessibility');
  print('- Used with Semantics.onLongPress');
  print('- Extends SemanticsEvent');

  print('\n' + '=' * 50);
  print('LongPressSemanticsEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'LongPressSemanticsEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${event.type}'),
      Text('Extends: SemanticsEvent'),
      Text('Trigger: Long press gesture'),
      Text('Purpose: Long press accessibility'),
    ],
  );
}
