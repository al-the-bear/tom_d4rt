// D4rt test script: Tests MenuAnchor, MenuItemButton, SubmenuButton from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MenuAnchor/MenuItemButton/SubmenuButton test executing');

  // Variation 1: Basic MenuAnchor with MenuItemButtons
  final widget1 = MenuAnchor(
    menuChildren: [
      MenuItemButton(
        onPressed: () {
          print('item1');
        },
        child: Text('Item 1'),
      ),
      MenuItemButton(
        onPressed: () {
          print('item2');
        },
        child: Text('Item 2'),
      ),
    ],
    child: TextButton(onPressed: () {}, child: Text('Open Menu')),
  );
  print('MenuAnchor(basic with 2 MenuItemButtons) created');

  // Variation 2: MenuItemButton with leading icon
  final widget2 = MenuItemButton(
    onPressed: () {},
    leadingIcon: Icon(Icons.edit),
    child: Text('Edit'),
  );
  print('MenuItemButton(leadingIcon: edit) created');

  // Variation 3: MenuItemButton disabled
  final widget3 = MenuItemButton(onPressed: null, child: Text('Disabled'));
  print('MenuItemButton(onPressed: null, disabled) created');

  // Variation 4: SubmenuButton with children
  final widget4 = SubmenuButton(
    menuChildren: [
      MenuItemButton(onPressed: () {}, child: Text('Sub1')),
      MenuItemButton(onPressed: () {}, child: Text('Sub2')),
    ],
    child: Text('Submenu'),
  );
  print('SubmenuButton(2 children) created');

  // Variation 5: MenuAnchor with SubmenuButton and MenuItemButtons
  final widget5 = MenuAnchor(
    menuChildren: [
      MenuItemButton(
        onPressed: () {
          print('new');
        },
        leadingIcon: Icon(Icons.add),
        child: Text('New'),
      ),
      SubmenuButton(
        menuChildren: [
          MenuItemButton(onPressed: () {}, child: Text('Copy')),
          MenuItemButton(onPressed: () {}, child: Text('Paste')),
        ],
        child: Text('Edit'),
      ),
      MenuItemButton(
        onPressed: () {
          print('delete');
        },
        leadingIcon: Icon(Icons.delete),
        child: Text('Delete'),
      ),
    ],
    child: TextButton(onPressed: () {}, child: Text('Actions')),
  );
  print('MenuAnchor(with SubmenuButton nested) created');

  // Variation 6: MenuItemButton with trailing icon
  final widget6 = MenuItemButton(
    onPressed: () {
      print('settings');
    },
    leadingIcon: Icon(Icons.settings),
    trailingIcon: Icon(Icons.arrow_forward),
    child: Text('Settings'),
  );
  print('MenuItemButton(leadingIcon + trailingIcon) created');

  print('MenuAnchor/MenuItemButton/SubmenuButton test completed');
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [widget1, widget2, widget3, widget4, widget5, widget6],
  );
}
