// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests CheckedPopupMenuItem, PopupMenuPosition,
// PopupMenuEntry concepts, PopupMenuThemeData
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Popup advanced test executing');

  // ========== CheckedPopupMenuItem ==========
  print('--- CheckedPopupMenuItem Tests ---');
  final checkedItem = CheckedPopupMenuItem<String>(
    value: 'checked_1',
    checked: true,
    child: Text('Checked Item'),
  );
  print('CheckedPopupMenuItem created: checked=true: $checkedItem');

  final uncheckedItem = CheckedPopupMenuItem<String>(
    value: 'unchecked_1',
    checked: false,
    child: Text('Unchecked Item'),
  );
  print('CheckedPopupMenuItem created: checked=false: $uncheckedItem');

  // ========== PopupMenuDivider ==========
  print('--- PopupMenuDivider Tests ---');
  final divider = PopupMenuDivider(height: 16.0);
  print('PopupMenuDivider height: 16.0: $divider');

  final defaultDivider = PopupMenuDivider();
  print('Default PopupMenuDivider: $defaultDivider');

  // ========== PopupMenuThemeData ==========
  print('--- PopupMenuThemeData Tests ---');
  final popupTheme = PopupMenuThemeData(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    elevation: 8.0,
    textStyle: TextStyle(color: Colors.black87, fontSize: 14.0),
    enableFeedback: true,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.black26,
  );
  print('PopupMenuThemeData created');
  print('  elevation: ${popupTheme.elevation}');
  print('  enableFeedback: ${popupTheme.enableFeedback}');

  // ========== PopupMenuButton advanced ==========
  print('--- PopupMenuButton advanced Tests ---');
  final menuButton = PopupMenuButton<String>(
    onSelected: (value) => print('Selected: $value'),
    offset: Offset(0, 40),
    elevation: 8.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    color: Colors.white,
    enableFeedback: true,
    constraints: BoxConstraints(minWidth: 200),
    position: PopupMenuPosition.under,
    clipBehavior: Clip.antiAlias,
    itemBuilder: (context) => [
      PopupMenuItem<String>(value: 'a', child: Text('Option A')),
      PopupMenuDivider(),
      CheckedPopupMenuItem<String>(
        value: 'b',
        checked: true,
        child: Text('Option B'),
      ),
    ],
  );
  print('Advanced PopupMenuButton created');
  print('  position: under');
  print('  clipBehavior: antiAlias');

  // ========== PopupMenuPosition ==========
  print('--- PopupMenuPosition Tests ---');
  for (final pos in PopupMenuPosition.values) {
    print('PopupMenuPosition: ${pos.name}');
  }

  print('All popup advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Popup Advanced Test'), actions: [menuButton]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Popup Advanced Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('CheckedPopupMenuItem variants'),
            Text('PopupMenuDivider heights'),
            Text('PopupMenuThemeData configured'),
            Text(
              'PopupMenuPosition: ${PopupMenuPosition.values.length} values',
            ),
          ],
        ),
      ),
    ),
  );
}
