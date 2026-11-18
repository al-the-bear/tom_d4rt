// ignore_for_file: avoid_print
// D4rt test script: MenuTheme, MenuBarTheme, PopupMenuTheme,
// DropdownMenuTheme, SearchBarTheme, SearchViewTheme, RadioMenuButton
// (material, addtests2).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== menu themes ===');
  final menu = MenuTheme(
    data: const MenuThemeData(
      style: MenuStyle(alignment: Alignment.bottomLeft),
    ),
    child: const SizedBox(),
  );
  print('menu alignment: ${menu.data.style?.alignment}');

  final menuBar = MenuBarTheme(
    data: const MenuBarThemeData(
      style: MenuStyle(alignment: Alignment.topRight),
    ),
    child: const SizedBox(),
  );
  print('menu bar alignment: ${menuBar.data.style?.alignment}');

  final popup = PopupMenuTheme(
    data: const PopupMenuThemeData(elevation: 6),
    child: const SizedBox(),
  );
  print('popup elevation: ${popup.data.elevation}');

  final dropdown = DropdownMenuTheme(
    data: const DropdownMenuThemeData(textStyle: TextStyle(fontSize: 13)),
    child: const SizedBox(),
  );
  print('dropdown font size: ${dropdown.data.textStyle?.fontSize}');

  final searchBar = SearchBarTheme(
    data: const SearchBarThemeData(constraints: BoxConstraints(minHeight: 48)),
    child: const SizedBox(),
  );
  print('search bar minHeight: ${searchBar.data.constraints?.minHeight}');

  final searchView = SearchViewTheme(
    data: const SearchViewThemeData(elevation: 4),
    child: const SizedBox(),
  );
  print('search view elevation: ${searchView.data.elevation}');

  var selected = 2;
  final radio = RadioMenuButton<int>(
    value: 2,
    groupValue: selected,
    onChanged: (v) => selected = v ?? selected,
    child: const Text('two'),
  );
  print('radio menu value: ${radio.value} group: ${radio.groupValue}');
  // Reading `radio.onChanged` back is GEN-134 (radio_menu_button_on_changed_test).

  return MenuTheme(
    data: menu.data,
    child: Center(child: radio),
  );
}
