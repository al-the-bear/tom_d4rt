// D4rt test script: Tests TooltipSemanticsEvent from semantics
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TooltipSemanticsEvent test executing');
  print('=' * 50);

  // TooltipSemanticsEvent for tooltip announcements
  print('\nTooltipSemanticsEvent:');
  print('Event when tooltip is shown');
  print('Announces tooltip content to screen readers');

  // Create instance
  final event = TooltipSemanticsEvent('Help information');
  print('\nInstance created:');
  print('runtimeType: ${event.runtimeType}');

  // Constructor
  print('\nConstructor:');
  print('TooltipSemanticsEvent(message)');
  print('message: "Help information"');

  // Properties
  print('\nProperties:');
  print('type: ${event.type}');
  print('message: ${event.message}');

  // Extends SemanticsEvent
  print('\nExtends SemanticsEvent:');
  print('is SemanticsEvent: ${event is SemanticsEvent}');

  // When triggered
  print('\nWhen triggered:');
  print('- Tooltip.showTooltip()');
  print('- Long press on tooltip widget');
  print('- Mouse hover on desktop');
  print('- Keyboard focus with delay');

  // Screen reader behavior
  print('\nScreen reader behavior:');
  print('');
  print('iOS VoiceOver:');
  print('  - Tooltip announced automatically');
  print('  - "Help information"');
  print('');
  print('Android TalkBack:');
  print('  - Tooltip spoken as announcement');
  print('  - Uses announce event type');

  // Usage in Tooltip widget
  print('\nUsage in Tooltip widget:');
  print('Tooltip(');
  print('  message: "Help information",');
  print('  child: Icon(Icons.help),');
  print(');');
  print('');
  print('// Internally sends TooltipSemanticsEvent');

  // toMap for serialization
  print('\nSerialization:');
  final map = event.toMap();
  print('toMap: ${map}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('SemanticsEvent');
  print('  \u2514\u2500 TooltipSemanticsEvent');

  // Explain purpose
  print('\nTooltipSemanticsEvent purpose:');
  print('- Announce tooltip content');
  print('- Screen reader notification');
  print('- message property for text');
  print('- Used by Tooltip widget');
  print('- Extends SemanticsEvent');

  print('\n' + '=' * 50);
  print('TooltipSemanticsEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TooltipSemanticsEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${event.type}'),
      Text('Message: ${event.message}'),
      Text('Extends: SemanticsEvent'),
      Text('Purpose: Tooltip announcements'),
    ],
  );
}
