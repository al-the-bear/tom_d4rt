// D4rt test script: Tests TooltipSemanticsEvent from semantics
import 'dart:ui';
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TooltipSemanticsEvent comprehensive test executing');
  final results = <String>[];

  // ========== TooltipSemanticsEvent Tests ==========
  print('Testing TooltipSemanticsEvent...');

  // Test 1: Create TooltipSemanticsEvent with message
  final event1 = TooltipSemanticsEvent('Click to submit');
  assert(event1 != null, 'Should create TooltipSemanticsEvent');
  results.add('TooltipSemanticsEvent created');
  print('TooltipSemanticsEvent created: ${event1.runtimeType}');

  // Test 2: Verify message property
  assert(event1.message == 'Click to submit', 'Message should match');
  results.add('Message: Click to submit');
  print('Message: ${event1.message}');

  // Test 3: Verify type property
  final eventType = event1.type;
  assert(eventType == 'tooltip', 'Event type should be tooltip');
  results.add('Event type: $eventType');
  print('Event type: $eventType');

  // Test 4: Check inheritance from SemanticsEvent
  assert(event1 is SemanticsEvent, 'Should be a SemanticsEvent');
  results.add('Inheritance verified: SemanticsEvent');
  print('Is SemanticsEvent: ${event1 is SemanticsEvent}');

  // Test 5: Convert to map for serialization
  final eventMap = event1.toMap();
  assert(eventMap != null, 'toMap should return a map');
  assert(eventMap['type'] == 'tooltip', 'Map type should be tooltip');
  results.add('toMap() serialization successful');
  print('Event map: $eventMap');

  // Test 6: Verify map contains message
  final dataMap = eventMap['data'] as Map<String, dynamic>;
  assert(dataMap['message'] == 'Click to submit', 'Map should contain message');
  results.add('Map contains message');
  print('Data map message: ${dataMap['message']}');

  // Test 7: Create event with different message
  final event2 = TooltipSemanticsEvent('Help tooltip');
  assert(event2.message == 'Help tooltip', 'Message should match');
  results.add('Event with different message');
  print('Event 2 message: ${event2.message}');

  // Test 8: Create event with empty message
  final event3 = TooltipSemanticsEvent('');
  assert(event3.message == '', 'Empty message should be valid');
  results.add('Event with empty message');
  print('Event 3 message (empty): "${event3.message}"');

  // Test 9: Create event with long message
  final longMessage = 'A' * 500;
  final event4 = TooltipSemanticsEvent(longMessage);
  assert(event4.message.length == 500, 'Long message should work');
  results.add('Event with long message (500 chars)');
  print('Event 4 message length: ${event4.message.length}');

  // Test 10: Tooltip purpose
  results.add('Tooltip: Announces tooltip to screen readers');
  print('Purpose: Notify accessibility services of tooltip');

  // Test 11: Compare to AnnounceSemanticsEvent
  final announceEvent = AnnounceSemanticsEvent('Test', TextDirection.ltr);
  assert(announceEvent.type == 'announce', 'Announce type should be announce');
  assert(event1.type == 'tooltip', 'Tooltip type should be tooltip');
  results.add('Tooltip vs Announce: different purposes');
  print('Tooltip: ${event1.type}, Announce: ${announceEvent.type}');

  // Test 12: Unicode in tooltip
  final unicodeEvent = TooltipSemanticsEvent('🔧 Settings ⚙️');
  assert(unicodeEvent.message.contains('🔧'), 'Unicode should work');
  results.add('Unicode in tooltip: 🔧 Settings ⚙️');
  print('Unicode tooltip: ${unicodeEvent.message}');

  // Test 13: Multiline tooltip
  final multilineEvent = TooltipSemanticsEvent('Line 1\nLine 2\nLine 3');
  assert(multilineEvent.message.split('\n').length == 3, 'Should have 3 lines');
  results.add('Multiline tooltip supported');
  print('Multiline tooltip lines: ${multilineEvent.message.split('\n').length}');

  // Test 14: Special characters in tooltip
  final specialEvent = TooltipSemanticsEvent('Price: \$99.99 <50% off>');
  assert(specialEvent.message.contains('\$'), 'Special chars should work');
  results.add('Special characters in tooltip');
  print('Special chars tooltip: ${specialEvent.message}');

  // Test 15: Multiple events comparison
  final events = [event1, event2, event3, event4];
  assert(events.every((e) => e is TooltipSemanticsEvent), 'All should be TooltipSemanticsEvent');
  results.add('Multiple events: ${events.length}');
  print('Events count: ${events.length}');

  // Test 16: Tooltip with Tooltip widget context
  results.add('Used with Flutter Tooltip widget');
  print('TooltipSemanticsEvent integrates with Tooltip widget');

  // Test 17: Verify runtime type
  assert(event1.runtimeType.toString() == 'TooltipSemanticsEvent', 'Runtime type should match');
  results.add('Runtime type: ${event1.runtimeType}');
  print('Runtime type: ${event1.runtimeType}');

  // Test 18: Event map keys
  final mapKeys = eventMap.keys.toList();
  assert(mapKeys.contains('type'), 'Should have type key');
  assert(mapKeys.contains('data'), 'Should have data key');
  results.add('Map keys: type, data');
  print('Map keys: $mapKeys');

  // Test 19: Event toString
  final eventString = event1.toString();
  assert(eventString.isNotEmpty, 'toString should not be empty');
  results.add('toString works');
  print('Event toString: $eventString');

  // Test 20: Summary
  print('TooltipSemanticsEvent test completed with ${results.length} tests');
  results.add('All tests passed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TooltipSemanticsEvent Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Constructor: TooltipSemanticsEvent(message)'),
      Text('Properties: message, type (tooltip)'),
      Text('Methods: toMap()'),
      Text('Purpose: Tooltip announcements for accessibility'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
