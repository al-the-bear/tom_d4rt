// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ToggleablePainter from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ToggleablePainter test executing');
  print('=' * 50);

  // Overview
  print('ToggleablePainter overview:');
  print('  - Abstract class');
  print('  - Extends ChangeNotifier');
  print('  - Implements CustomPainter');
  print('  - Used for checkbox, radio, switch painting');

  // Class declaration
  print('\nClass declaration:');
  print('  abstract class ToggleablePainter');
  print('      extends ChangeNotifier');
  print('      implements CustomPainter');

  // Animation properties
  print('\nAnimation properties (setters notify):');
  print('  - position: Animation<double> (toggle state)');
  print('  - reaction: Animation<double> (tap animation)');
  print('  - reactionFocusFade: Animation<double>');
  print('  - reactionHoverFade: Animation<double>');

  // Color properties
  print('\nColor properties (setters notify):');
  print('  - activeColor: Color (checked state)');
  print('  - inactiveColor: Color (unchecked state)');
  print('  - reactionColor: Color (active reaction splash)');
  print('  - inactiveReactionColor: Color (inactive reaction splash)');
  print('  - hoverColor: Color');
  print('  - focusColor: Color');
  print('  - splashRadius: double');
  print('  - downPosition: Offset? (touch position)');
  print('  - isFocused: bool');
  print('  - isHovered: bool');

  // Auto-notification
  print('\nAuto-notification behavior:');
  print('  - Each setter removes old animation listener');
  print('  - Adds listener to new animation');
  print('  - Calls notifyListeners() on change');
  print('  - CustomPaint repaints on notification');

  // paintRadialReaction method
  print('\npaintRadialReaction method:');
  print('  void paintRadialReaction({');
  print('    required Canvas canvas,');
  print('    Offset offset = Offset.zero,');
  print('  })');
  print('  - Paints Material ink splash reaction');
  print('  - Uses reaction animation value');
  print('  - Uses splashRadius for size');

  // hitTest
  print('\nhitTest implementation:');
  print('  @override');
  print('  bool? hitTest(Offset position) => null;');
  print('  - Always returns null (no hit testing)');

  // CustomPainter methods
  print('\nCustomPainter methods:');
  print('  - paint: abstract (must implement)');
  print('  - shouldRepaint: uses ChangeNotifier');
  print('  - shouldRebuildSemantics: returns false');
  print('  - semanticsBuilder: returns null');

  // Usage pattern
  print('\nUsage pattern:');
  print('  - Subclass for specific toggle widget');
  print('  - Override paint() method');
  print('  - Use with ToggleableStateMixin');
  print('  - Pass to CustomPaint widget');

  print('\n' + '=' * 50);
  print('ToggleablePainter test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ToggleablePainter Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Abstract class'),
      Text('Extends: ChangeNotifier'),
      Text('Implements: CustomPainter'),
      Text('Purpose: Toggle widget painting'),
    ],
  );
}
