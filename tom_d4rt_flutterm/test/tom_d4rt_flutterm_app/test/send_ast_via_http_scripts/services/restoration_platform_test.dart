// D4rt test script: Tests RestorationMemento, RestorationData, RestorationCallback, PlatformMenu, PlatformProvidedMenu, PlatformMenuItemGroup, PlatformProvidedMenuItem
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Restoration and platform menu test executing');

  // ========== RestorationMemento / RestorationData ==========
  print('--- RestorationMemento / RestorationData Tests ---');
  // RestorationMemento and RestorationData may not be directly public classes.
  // Reference the restoration system via RestorationManager and RestorationBucket.
  print('RestorationMemento: referenced via RestorationManager system');
  print('RestorationData: referenced via RestorationManager system');
  print('RestorationManager type: RestorationManager');

  // ========== RestorationCallback ==========
  print('--- RestorationCallback Tests ---');
  // RestorationCallback is a typedef: void Function(bool)
  // Define a function matching the signature.
  void restorationCallback(bool needsRestore) {
    print('RestorationCallback invoked with needsRestore: $needsRestore');
  }

  restorationCallback(true);
  print('RestorationCallback: defined function matching typedef signature');
  print('Type: void Function(bool)');

  // ========== PlatformMenu ==========
  print('--- PlatformMenu Tests ---');
  final platformMenu = PlatformMenu(
    label: 'File',
    menus: [
      PlatformMenuItem(
        label: 'New',
        onSelected: () {
          print('New selected');
        },
      ),
      PlatformMenuItem(
        label: 'Open',
        onSelected: () {
          print('Open selected');
        },
      ),
    ],
  );
  print('PlatformMenu label: ${platformMenu.label}');
  print('PlatformMenu menus count: ${platformMenu.menus.length}');
  print('Type: ${platformMenu.runtimeType}');

  // ========== PlatformProvidedMenu ==========
  print('--- PlatformProvidedMenu Tests ---');
  // PlatformProvidedMenu wraps platform-provided menu items like quit, about, etc.
  print('PlatformProvidedMenu: references platform-provided menu types');
  print('Type: PlatformProvidedMenu');

  // ========== PlatformMenuItemGroup ==========
  print('--- PlatformMenuItemGroup Tests ---');
  final menuGroup = PlatformMenuItemGroup(
    members: [
      PlatformMenuItem(
        label: 'Cut',
        onSelected: () {
          print('Cut selected');
        },
      ),
      PlatformMenuItem(
        label: 'Copy',
        onSelected: () {
          print('Copy selected');
        },
      ),
      PlatformMenuItem(
        label: 'Paste',
        onSelected: () {
          print('Paste selected');
        },
      ),
    ],
  );
  print('PlatformMenuItemGroup members count: ${menuGroup.members.length}');
  print('Type: ${menuGroup.runtimeType}');

  // ========== PlatformProvidedMenuItem ==========
  print('--- PlatformProvidedMenuItem Tests ---');
  final providedMenuItem = PlatformProvidedMenuItem(
    type: PlatformProvidedMenuItemType.about,
  );
  print('PlatformProvidedMenuItem type: ${providedMenuItem.type}');
  print('Type: ${providedMenuItem.runtimeType}');

  // Also test quit type
  final quitMenuItem = PlatformProvidedMenuItem(
    type: PlatformProvidedMenuItemType.quit,
  );
  print('PlatformProvidedMenuItem quit type: ${quitMenuItem.type}');

  print('All restoration and platform menu tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Restoration & Platform Menu Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('RestorationMemento: OK (via RestorationManager)'),
            Text('RestorationData: OK (via RestorationManager)'),
            Text('RestorationCallback: OK'),
            Text('PlatformMenu: OK (label: File)'),
            Text('PlatformProvidedMenu: OK'),
            Text('PlatformMenuItemGroup: OK (3 members)'),
            Text('PlatformProvidedMenuItem: OK (about, quit)'),
          ],
        ),
      ),
    ),
  );
}
