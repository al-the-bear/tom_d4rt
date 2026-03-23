// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DropdownMenu, DropdownMenuEntry, DropdownMenuThemeData,
// MenuAnchor, MenuBar, MenuItemButton, SubmenuButton, MenuStyle
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Dropdown menu test executing');

  // ========== DropdownMenu ==========
  print('--- DropdownMenu Tests ---');
  final dropdownMenu = DropdownMenu<String>(
    initialSelection: 'opt1',
    label: Text('Select option'),
    hintText: 'Choose...',
    helperText: 'Select an item',
    errorText: null,
    width: 300,
    menuHeight: 200,
    leadingIcon: Icon(Icons.list),
    trailingIcon: Icon(Icons.arrow_drop_down),
    selectedTrailingIcon: Icon(Icons.arrow_drop_up),
    enableFilter: true,
    enableSearch: true,
    requestFocusOnTap: true,
    enabled: true,
    expandedInsets: EdgeInsets.zero,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      filled: true,
      fillColor: Colors.grey[100],
    ),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(Colors.white),
      elevation: WidgetStateProperty.all(8.0),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textStyle: TextStyle(fontSize: 16),
    onSelected: (value) => print('  Selected: $value'),
    dropdownMenuEntries: [
      DropdownMenuEntry<String>(
        value: 'opt1',
        label: 'Option 1',
        leadingIcon: Icon(Icons.looks_one),
        trailingIcon: Icon(Icons.check),
        enabled: true,
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(Colors.black),
        ),
        labelWidget: Text(
          'Custom Option 1',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DropdownMenuEntry<String>(
        value: 'opt2',
        label: 'Option 2',
        leadingIcon: Icon(Icons.looks_two),
      ),
      DropdownMenuEntry<String>(
        value: 'opt3',
        label: 'Option 3 (disabled)',
        enabled: false,
      ),
    ],
  );
  print('DropdownMenu created');

  // ========== DropdownMenuEntry ==========
  print('--- DropdownMenuEntry Tests ---');
  final entry = DropdownMenuEntry<int>(
    value: 42,
    label: 'Answer',
    leadingIcon: Icon(Icons.star),
    enabled: true,
  );
  print(
    'DropdownMenuEntry created: value=${entry.value}, label=${entry.label}',
  );

  // ========== MenuAnchor ==========
  print('--- MenuAnchor Tests ---');
  final menuAnchor = MenuAnchor(
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
    menuChildren: [
      MenuItemButton(
        onPressed: () => print('  Cut'),
        leadingIcon: Icon(Icons.content_cut),
        trailingIcon: Text(
          'Ctrl+X',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        child: Text('Cut'),
      ),
      MenuItemButton(
        onPressed: () => print('  Copy'),
        leadingIcon: Icon(Icons.content_copy),
        child: Text('Copy'),
      ),
      MenuItemButton(
        onPressed: () => print('  Paste'),
        leadingIcon: Icon(Icons.content_paste),
        child: Text('Paste'),
        closeOnActivate: true,
      ),
      Divider(),
      MenuItemButton(
        onPressed: null,
        leadingIcon: Icon(Icons.delete, color: Colors.grey),
        child: Text('Delete', style: TextStyle(color: Colors.grey)),
      ),
    ],
    style: MenuStyle(
      backgroundColor: WidgetStateProperty.all(Colors.white),
      elevation: WidgetStateProperty.all(8.0),
      padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 4)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    alignmentOffset: Offset(0, 4),
  );
  print('MenuAnchor created');

  // ========== MenuItemButton ==========
  print('--- MenuItemButton Tests ---');
  final menuItem = MenuItemButton(
    onPressed: () => print('  Menu item pressed'),
    onHover: (hovering) => print('  Hovering: $hovering'),
    onFocusChange: (focused) => print('  Focused: $focused'),
    leadingIcon: Icon(Icons.edit),
    trailingIcon: Icon(Icons.arrow_right),
    requestFocusOnHover: true,
    closeOnActivate: true,
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.black87),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    ),
    child: Text('Edit'),
  );
  print('MenuItemButton created');

  // ========== SubmenuButton ==========
  print('--- SubmenuButton Tests ---');
  final submenu = SubmenuButton(
    menuChildren: [
      MenuItemButton(onPressed: () {}, child: Text('Sub Item 1')),
      MenuItemButton(onPressed: () {}, child: Text('Sub Item 2')),
      MenuItemButton(onPressed: () {}, child: Text('Sub Item 3')),
    ],
    leadingIcon: Icon(Icons.format_list_bulleted),
    trailingIcon: Icon(Icons.arrow_right),
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.black87),
    ),
    alignmentOffset: Offset(0, 4),
    menuStyle: MenuStyle(elevation: WidgetStateProperty.all(4.0)),
    child: Text('More Options'),
  );
  print('SubmenuButton created');

  // ========== MenuStyle ==========
  print('--- MenuStyle Tests ---');
  final menuStyle = MenuStyle(
    backgroundColor: WidgetStateProperty.all(Colors.white),
    shadowColor: WidgetStateProperty.all(Colors.black26),
    surfaceTintColor: WidgetStateProperty.all(Colors.blue[50]),
    elevation: WidgetStateProperty.all(8.0),
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 4)),
    minimumSize: WidgetStateProperty.all(Size(200, 0)),
    maximumSize: WidgetStateProperty.all(Size(400, 500)),
    side: WidgetStateProperty.all(BorderSide(color: Colors.grey[300]!)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    alignment: Alignment.bottomLeft,
    fixedSize: null,
  );
  print('MenuStyle created');

  // ========== DropdownMenuThemeData ==========
  print('--- DropdownMenuThemeData Tests ---');
  final dmTheme = DropdownMenuThemeData(
    textStyle: TextStyle(fontSize: 16),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    menuStyle: menuStyle,
  );
  print('DropdownMenuThemeData created');

  print('All dropdown menu tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Menus'), actions: [menuAnchor]),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            dropdownMenu,
            SizedBox(height: 16),
            Row(children: [menuItem, submenu]),
          ],
        ),
      ),
    ),
  );
}
