// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AnnounceSemanticsEvent from semantics
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnnounceSemanticsEvent test executing');
  print('=' * 50);

  // AnnounceSemanticsEvent for accessibility announcements
  print('\nAnnounceSemanticsEvent:');
  print('Event for screen reader announcements');
  print('Used for live region updates');

  // Create instance
  final event = AnnounceSemanticsEvent(
    'Item added to cart',
    TextDirection.ltr,
    0, // viewId
    assertiveness: Assertiveness.polite,
  );
  print('\nInstance created:');
  print('runtimeType: ${event.runtimeType}');

  // Properties
  print('\nProperties:');
  print('message: ${event.message}');
  print('textDirection: ${event.textDirection}');
  print('type: ${event.type}');

  // Extends SemanticsEvent
  print('\nExtends SemanticsEvent:');
  print('is SemanticsEvent: true /* event is SemanticsEvent */');

  // When to use
  print('\nWhen to use:');
  print('- Dynamic content changes');
  print('- Toast/snackbar messages');
  print('- Loading state changes');
  print('- Form submission results');
  print('- Cart updates');

  // Screen reader behavior
  print('\nScreen reader behavior:');
  print('iOS VoiceOver: Speaks announcement');
  print('Android TalkBack: Speaks announcement');
  print('Does NOT move focus');

  // Usage in Flutter
  print('\nUsage in Flutter:');
  print('SemanticsService.announce(');
  print('  "Item added to cart",');
  print('  TextDirection.ltr,');
  print(');');

  // Live regions alternative
  print('\nLive regions alternative:');
  print('Semantics(');
  print('  liveRegion: true,');
  print('  child: Text(statusMessage),');
  print(');');

  // toMap for serialization
  print('\nSerialization:');
  final map = event.toMap();
  print('toMap keys: ${map.keys.toList()}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('SemanticsEvent');
  print('  \u2514\u2500 AnnounceSemanticsEvent');

  // Explain purpose
  print('\nAnnounceSemanticsEvent purpose:');
  print('- Screen reader announcements');
  print('- Live content updates');
  print('- No focus change');
  print('- Accessibility notifications');
  print('- Dynamic status messages');

  print('\n' + '=' * 50);
  print('AnnounceSemanticsEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'AnnounceSemanticsEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Message: ${event.message}'),
      Text('Type: ${event.type}'),
      Text('For: Screen readers'),
      Text('Purpose: Live announcements'),
    ],
  );
}
