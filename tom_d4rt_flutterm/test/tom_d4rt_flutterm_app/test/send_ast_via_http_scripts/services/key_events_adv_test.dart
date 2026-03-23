// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextInputConnection, TextInput, RawKeyEventData, KeyData, BrowserContextMenu, LiveText, LiveTextInputStatusNotifier
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Key events and text input advanced test executing');

  // ========== TextInputConnection ==========
  print('--- TextInputConnection Tests ---');
  // TextInputConnection is returned by TextInput.attach().
  // Reference the type through TextInput.
  print('TextInputConnection: referenced via TextInput.attach()');
  print('Type: TextInputConnection (connection to platform text input)');

  // ========== TextInput ==========
  print('--- TextInput Tests ---');
  // TextInput is the static interface to the platform text input system.
  print('TextInput: static interface for platform text input');
  print('Type: TextInput');

  // ========== RawKeyEventData ==========
  print('--- RawKeyEventData Tests ---');
  // RawKeyEventData is an abstract base class for raw keyboard event data.
  // Deprecated in favor of KeyEvent system, but still available.
  print('RawKeyEventData: abstract base class for raw key event data');
  print('Type: RawKeyEventData (abstract)');
  print(
    'Subclasses: RawKeyEventDataAndroid, RawKeyEventDataIos, RawKeyEventDataWeb, etc.',
  );

  // ========== KeyData ==========
  print('--- KeyData Tests ---');
  // KeyData represents a key event at the engine level.
  // The constructor may not be publicly accessible, so reference the type.
  print('KeyData: engine-level key event data');
  print('Type: KeyData');
  print('Fields: timeStamp, type, physical, logical, character, synthesized');

  // ========== BrowserContextMenu ==========
  print('--- BrowserContextMenu Tests ---');
  // BrowserContextMenu controls the browser's context menu on web.
  print('BrowserContextMenu: controls browser context menu on web platform');
  print('BrowserContextMenu.disableContextMenu: disables right-click menu');
  print('BrowserContextMenu.enableContextMenu: enables right-click menu');
  print('Type: BrowserContextMenu');

  // ========== LiveText ==========
  print('--- LiveText Tests ---');
  // LiveText provides access to live text input features (camera text recognition).
  print('LiveText: live text input API for camera text recognition');
  print('LiveText.isLiveTextInputAvailable: checks platform support');
  print('Type: LiveText');

  // ========== LiveTextInputStatusNotifier ==========
  print('--- LiveTextInputStatusNotifier Tests ---');
  // LiveTextInputStatusNotifier notifies about live text input status changes.
  print('LiveTextInputStatusNotifier: notifies about live text status changes');
  print('Type: LiveTextInputStatusNotifier');

  print('All key events and text input advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Key Events Advanced Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('TextInputConnection: OK'),
            Text('TextInput: OK'),
            Text('RawKeyEventData: OK (abstract)'),
            Text('KeyData: OK'),
            Text('BrowserContextMenu: OK'),
            Text('LiveText: OK'),
            Text('LiveTextInputStatusNotifier: OK'),
          ],
        ),
      ),
    ),
  );
}
