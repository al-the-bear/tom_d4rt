// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MenuStyle, MenuThemeData, SubmenuButton,
// MenuItemButton, MenuAnchor advanced
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('Menu advanced test executing');

  // ========== MenuStyle ==========
  print('--- MenuStyle Tests ---');
  final menuStyle = MenuStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.white),
    elevation: WidgetStatePropertyAll(8.0),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
    padding: WidgetStatePropertyAll(EdgeInsets.zero),
    surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
    shadowColor: WidgetStatePropertyAll(Colors.black26),
    alignment: Alignment.bottomLeft,
  );
  print('MenuStyle created');

  // ========== MenuThemeData ==========
  print('--- MenuThemeData Tests ---');
  final menuTheme = MenuThemeData(style: menuStyle);
  print('MenuThemeData created');

  // ========== MenuItemButton ==========
  print('--- MenuItemButton Tests ---');
  final menuItem1 = MenuItemButton(
    onPressed: () => print('Menu item 1'),
    shortcut: SingleActivator(LogicalKeyboardKey.keyN, control: true),
    leadingIcon: Icon(Icons.add),
    trailingIcon: Text(
      'Ctrl+N',
      style: TextStyle(fontSize: 12.0, color: Colors.grey),
    ),
    child: Text('New File'),
  );
  print('MenuItemButton created: New File');

  final menuItem2 = MenuItemButton(
    onPressed: () => print('Menu item 2'),
    leadingIcon: Icon(Icons.save),
    child: Text('Save'),
  );
  print('MenuItemButton created: Save');

  final menuItem3 = MenuItemButton(
    onPressed: null,
    leadingIcon: Icon(Icons.undo),
    child: Text('Undo (disabled)'),
  );
  print('MenuItemButton disabled created');

  // ========== SubmenuButton ==========
  print('--- SubmenuButton Tests ---');
  final submenu = SubmenuButton(
    menuChildren: [menuItem1, menuItem2],
    leadingIcon: Icon(Icons.file_open),
    child: Text('File'),
  );
  print('SubmenuButton created with 2 items');

  // ========== MenuAnchor ==========
  print('--- MenuAnchor Tests ---');
  final anchor = MenuAnchor(
    menuChildren: [menuItem1, menuItem2, menuItem3],
    builder: (context, controller, child) {
      return IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
      );
    },
  );
  print('MenuAnchor created with 3 items');

  print('All menu advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Menu Advanced Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Menu Advanced Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            MenuBar(
              children: [
                submenu,
                SubmenuButton(
                  menuChildren: [menuItem2, menuItem3],
                  child: Text('Edit'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            anchor,
          ],
        ),
      ),
    ),
  );
}
