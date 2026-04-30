// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests CupertinoContextMenu from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoContextMenu test executing');

  // ========== Static constants ==========
  print('--- Static constants ---');
  print('  kOpenBorderRadius: ${CupertinoContextMenu.kOpenBorderRadius}');
  print('  animationOpensAt: ${CupertinoContextMenu.animationOpensAt}');

  // ========== Basic CupertinoContextMenu ==========
  print('--- Basic CupertinoContextMenu ---');
  final contextMenu = CupertinoContextMenu(
    actions: [
      CupertinoContextMenuAction(
        child: Text('Copy'),
        onPressed: () { print('Copy pressed'); },
      ),
      CupertinoContextMenuAction(
        child: Text('Share'),
        onPressed: () { print('Share pressed'); },
      ),
      CupertinoContextMenuAction(
        isDestructiveAction: true,
        onPressed: () { print('Delete pressed'); },
        child: Text('Delete'),
      ),
    ],
    child: Container(
      width: 150.0,
      height: 150.0,
      color: CupertinoColors.systemBlue,
      child: Center(child: Text('Long Press Me', style: TextStyle(color: CupertinoColors.white))),
    ),
  );
  print('  created CupertinoContextMenu');
  print('  actions count: ${contextMenu.actions.length}');
  print('  has child: ${contextMenu.child != null}');
  print('  enableHapticFeedback: ${contextMenu.enableHapticFeedback}');

  // ========== CupertinoContextMenu with haptic feedback ==========
  print('--- With haptic feedback ---');
  final hapticMenu = CupertinoContextMenu(
    enableHapticFeedback: true,
    actions: [
      CupertinoContextMenuAction(child: Text('Action 1')),
    ],
    child: Container(width: 100.0, height: 100.0, color: CupertinoColors.activeGreen),
  );
  print('  enableHapticFeedback: ${hapticMenu.enableHapticFeedback}');

  // ========== CupertinoContextMenuAction properties ==========
  print('--- CupertinoContextMenuAction ---');
  final defaultAction = CupertinoContextMenuAction(
    isDefaultAction: true,
    child: Text('Default Action'),
    onPressed: () { print('default'); },
  );
  print('  isDefaultAction: ${defaultAction.isDefaultAction}');
  print('  isDestructiveAction: ${defaultAction.isDestructiveAction}');

  final destructiveAction = CupertinoContextMenuAction(
    isDestructiveAction: true,
    trailingIcon: CupertinoIcons.trash,
    child: Text('Destructive Action'),
  );
  print('  destructive.isDestructiveAction: ${destructiveAction.isDestructiveAction}');
  print('  destructive.trailingIcon: ${destructiveAction.trailingIcon}');

  // ========== Action with icon ==========
  print('--- Action with trailing icon ---');
  final iconAction = CupertinoContextMenuAction(
    trailingIcon: CupertinoIcons.share,
    onPressed: () { print('share'); },
    child: Text('Share'),
  );
  print('  trailingIcon: ${iconAction.trailingIcon}');

  print('CupertinoContextMenu test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('ContextMenu Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CupertinoContextMenu', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              contextMenu,
              SizedBox(height: 16.0),
              Text('Context Menu Actions', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              CupertinoContextMenuAction(isDefaultAction: true, child: Text('Default')),
              CupertinoContextMenuAction(isDestructiveAction: true, child: Text('Destructive')),
              CupertinoContextMenuAction(trailingIcon: CupertinoIcons.share, child: Text('With Icon')),
              SizedBox(height: 8.0),
              Text('kOpenBorderRadius: ${CupertinoContextMenu.kOpenBorderRadius}'),
              Text('animationOpensAt: ${CupertinoContextMenu.animationOpensAt}'),
            ],
          ),
        ),
      ),
    ),
  );
}
