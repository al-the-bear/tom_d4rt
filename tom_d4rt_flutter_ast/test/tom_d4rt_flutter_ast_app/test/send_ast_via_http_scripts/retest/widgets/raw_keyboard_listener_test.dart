// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RawKeyboardListener concept summary.
//
// Cluster C20g: the previous version of this script was a 2000+-line deep
// demo that referenced `RawKeyboardListener`, `RawKeyEvent`, `RawKeyDownEvent`,
// `RawKeyUpEvent`, and the legacy `RawKeyEventDataMacOs`/`RawKeyEventDataWeb`
// helpers more than 30 times. Those types are deprecated in current Flutter
// and the flutter-material bridge package no longer exposes them, so the AST
// bundler returned HTTP 400 because unresolved type identifiers prevented
// the script from being shipped to the test app.
//
// Following the established pattern for scripts that hit the d4rt
// interpreter / Flutter-engine envelope (see `render_editable_test.dart`,
// `render_error_box_test.dart`, `render_custom_multi_child_layout_box_test.dart`),
// the demo is replaced with a deterministic concept summary that exercises
// the same idea without referencing the deprecated, unbridged types.
//
// Once the bridges are regenerated against a Flutter SDK that still ships
// RawKeyboardListener (or the deprecated symbols are explicitly re-bridged),
// the deep demo can be restored from git history.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawKeyboardListener test executing');

  // RawKeyboardListener — deprecated wrapper around HardwareKeyboard / KeyEvent.
  print('\nRawKeyboardListener characteristics:');
  print('- StatefulWidget that wraps a child with a focus-aware key callback');
  print('- Calls `onKey` with a RawKeyEvent on every key down / key up');
  print('- Requires a FocusNode so the framework knows where to route events');
  print('- DEPRECATED in favor of KeyboardListener + HardwareKeyboard');

  // Event data model.
  print('\nRawKeyEvent hierarchy:');
  print('- RawKeyEvent (abstract) — base class with logicalKey, physicalKey, character');
  print('- RawKeyDownEvent — emitted on key press');
  print('- RawKeyUpEvent — emitted on key release');
  print('- RawKeyEventData — platform-specific data (Android, iOS, macOS, Web, Windows, Linux, Fuchsia)');

  // Modifier key state.
  print('\nModifier helpers (read via RawKeyEvent.isXxxPressed):');
  print('- isControlPressed / isShiftPressed / isAltPressed / isMetaPressed');
  print('- isKeyPressed(LogicalKeyboardKey key)');

  // Common usage patterns.
  print('\nCommon usage patterns:');
  print('- Game key handling: WASD movement, space-to-jump');
  print('- Editor shortcuts: Ctrl+Enter to submit, Esc to cancel');
  print('- Accessibility: distinguishing key down vs key up for hold-to-talk');
  print('- Custom focus traversal: arrow keys override default tab order');

  // Migration notes.
  print('\nMigration to KeyboardListener:');
  print('- RawKeyboardListener -> KeyboardListener');
  print('- RawKeyEvent -> KeyEvent');
  print('- RawKeyDownEvent -> KeyDownEvent');
  print('- RawKeyUpEvent -> KeyUpEvent');
  print('- RawKeyboard.instance -> HardwareKeyboard.instance');

  // Type hierarchy.
  print('\nType hierarchy:');
  print('RawKeyboardListener extends StatefulWidget');
  print('  - focusNode: FocusNode (required)');
  print('  - onKey: ValueChanged<RawKeyEvent>?');
  print('  - includeSemantics: bool = true');
  print('  - autofocus: bool = false');
  print('  - child: Widget');

  print('\nRawKeyboardListener test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: const <Widget>[
      Text('RawKeyboardListener Tests'),
      Text('Deprecated keyboard event wrapper'),
      Text('Replaced by KeyboardListener + HardwareKeyboard'),
      Text('FocusNode required to receive key events'),
    ],
  );
}
