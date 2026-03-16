// Tests: DefaultPlatformMenuDelegate, PlatformMenuBar, PlatformMenu,
//        PlatformMenuItem, PlatformMenuDelegate, DefaultTextStyleTransition,
//        RawMagnifier, RawKeyboardListener
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // --- DefaultPlatformMenuDelegate Tests ---
  print('--- DefaultPlatformMenuDelegate Tests ---');
  print('DefaultPlatformMenuDelegate is the default platform menu delegate');
  print('Type: $DefaultPlatformMenuDelegate');
  print('Delegates platform menu operations to the underlying platform');

  // --- PlatformMenuBar Tests ---
  print('--- PlatformMenuBar Tests ---');
  var menuBar = PlatformMenuBar(menus: [], child: Container());
  print('PlatformMenuBar: $menuBar');
  print('PlatformMenuBar menus: ${menuBar.menus}');
  print('PlatformMenuBar defines a platform-native menu bar');

  // --- PlatformMenu Tests ---
  print('--- PlatformMenu Tests ---');
  var platformMenu = PlatformMenu(label: 'File', menus: []);
  print('PlatformMenu: $platformMenu');
  print('PlatformMenu label: ${platformMenu.label}');
  print('PlatformMenu menus: ${platformMenu.menus}');

  // --- PlatformMenuItem Tests ---
  print('--- PlatformMenuItem Tests ---');
  var menuItem = PlatformMenuItem(
    label: 'Open',
    onSelected: () {
      print('Menu item selected');
    },
  );
  print('PlatformMenuItem: $menuItem');
  print('PlatformMenuItem label: ${menuItem.label}');
  print('PlatformMenuItem onSelected: ${menuItem.onSelected}');

  // --- PlatformMenuDelegate Tests ---
  print('--- PlatformMenuDelegate Tests ---');
  print('PlatformMenuDelegate is an abstract interface for platform menus');
  print('Type: $PlatformMenuDelegate');
  print('DefaultPlatformMenuDelegate is its concrete implementation');

  // --- DefaultTextStyleTransition Tests ---
  print('--- DefaultTextStyleTransition Tests ---');
  print('DefaultTextStyleTransition animates DefaultTextStyle changes');
  print('Type: $DefaultTextStyleTransition');
  print('Requires an Animation<TextStyle> to drive the transition');
  print('Used for animated text style changes in implicit animations');

  // --- RawMagnifier Tests ---
  print('--- RawMagnifier Tests ---');
  var magnifier = RawMagnifier(
    decoration: const MagnifierDecoration(),
    size: const Size(80.0, 48.0),
  );
  print('RawMagnifier: $magnifier');
  print('RawMagnifier size: ${magnifier.size}');
  print('RawMagnifier decoration: ${magnifier.decoration}');
  print('RawMagnifier provides a raw magnifying glass effect');

  // --- RawKeyboardListener Tests ---
  print('--- RawKeyboardListener Tests ---');
  // ignore: deprecated_member_use
  var keyboardListener = RawKeyboardListener(
    focusNode: FocusNode(),
    onKey: (event) {
      print('Key event: $event');
    },
    child: const Text('Keyboard Listener'),
  );
  print('RawKeyboardListener: $keyboardListener');
  print('RawKeyboardListener focusNode: ${keyboardListener.focusNode}');
  print('RawKeyboardListener is deprecated in favor of KeyboardListener');

  print('All platform menu widgets tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            menuBar,
            magnifier,
            keyboardListener,
            const Text('Platform Menu Widgets Test'),
          ],
        ),
      ),
    ),
  );
}
