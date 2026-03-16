// D4rt test script: Tests MenuTheme, MenuThemeData, MenuBarTheme, MenuBarThemeData, DropdownMenuTheme, DropdownMenuThemeData, SearchBarTheme, SearchBarThemeData, SearchViewTheme, SearchViewThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Menu themes test executing');

  // ========== MENU THEME DATA ==========
  print('--- MenuThemeData Tests ---');

  final menuStyle = MenuStyle(
    backgroundColor: WidgetStateProperty.all(Colors.white),
    elevation: WidgetStateProperty.all(8.0),
    shadowColor: WidgetStateProperty.all(Colors.black26),
    surfaceTintColor: WidgetStateProperty.all(Colors.grey.shade50),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 8.0)),
    alignment: Alignment.topLeft,
    side: WidgetStateProperty.all(BorderSide.none),
    minimumSize: WidgetStateProperty.all(Size(112.0, 48.0)),
    maximumSize: WidgetStateProperty.all(Size(280.0, 600.0)),
  );
  final menuThemeData = MenuThemeData(style: menuStyle);
  print('MenuThemeData created');
  print('  style: ${menuThemeData.style}');

  // ========== MENU BAR THEME DATA ==========
  print('--- MenuBarThemeData Tests ---');

  final menuBarStyle = MenuStyle(
    backgroundColor: WidgetStateProperty.all(Colors.white),
    elevation: WidgetStateProperty.all(3.0),
    shadowColor: WidgetStateProperty.all(Colors.black12),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
    ),
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 4.0)),
  );
  final menuBarThemeData = MenuBarThemeData(style: menuBarStyle);
  print('MenuBarThemeData created');
  print('  style: ${menuBarThemeData.style}');

  // ========== DROPDOWN MENU THEME DATA ==========
  print('--- DropdownMenuThemeData Tests ---');

  final dropdownMenuThemeData = DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    ),
    textStyle: TextStyle(fontSize: 14.0, color: Colors.black87),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(Colors.white),
      elevation: WidgetStateProperty.all(4.0),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    ),
  );
  print('DropdownMenuThemeData created');
  print(
    '  inputDecorationTheme: ${dropdownMenuThemeData.inputDecorationTheme}',
  );
  print('  textStyle: ${dropdownMenuThemeData.textStyle}');
  print('  menuStyle: ${dropdownMenuThemeData.menuStyle}');

  // Test copyWith
  final copiedDropdownMenuTheme = dropdownMenuThemeData.copyWith(
    textStyle: TextStyle(fontSize: 16.0, color: Colors.black),
  );
  print('DropdownMenuThemeData.copyWith created');
  print('  new textStyle: ${copiedDropdownMenuTheme.textStyle}');

  // ========== SEARCH BAR THEME DATA ==========
  print('--- SearchBarThemeData Tests ---');

  final searchBarThemeData = SearchBarThemeData(
    backgroundColor: WidgetStateProperty.all(Colors.grey.shade100),
    elevation: WidgetStateProperty.all(2.0),
    shadowColor: WidgetStateProperty.all(Colors.black12),
    surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
    overlayColor: WidgetStateProperty.all(Colors.grey.withValues(alpha: 0.1)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
    ),
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16.0)),
    textStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 16.0, color: Colors.black87),
    ),
    hintStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 16.0, color: Colors.grey),
    ),
    constraints: BoxConstraints(minHeight: 56.0, maxWidth: 720.0),
    side: WidgetStateProperty.all(BorderSide.none),
    textCapitalization: TextCapitalization.none,
  );
  print('SearchBarThemeData created');
  print('  constraints: ${searchBarThemeData.constraints}');
  print('  textCapitalization: ${searchBarThemeData.textCapitalization}');

  // Test copyWith
  final copiedSearchBarTheme = searchBarThemeData.copyWith(
    constraints: BoxConstraints(minHeight: 48.0, maxWidth: 600.0),
  );
  print('SearchBarThemeData.copyWith created');
  print('  new constraints: ${copiedSearchBarTheme.constraints}');

  // ========== SEARCH VIEW THEME DATA ==========
  print('--- SearchViewThemeData Tests ---');

  final searchViewThemeData = SearchViewThemeData(
    backgroundColor: Colors.white,
    elevation: 6.0,
    surfaceTintColor: Colors.grey.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
    headerTextStyle: TextStyle(fontSize: 16.0, color: Colors.black87),
    headerHintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
    dividerColor: Colors.grey.shade300,
    constraints: BoxConstraints(minHeight: 240.0, maxWidth: 720.0),
    side: BorderSide.none,
  );
  print('SearchViewThemeData created');
  print('  backgroundColor: ${searchViewThemeData.backgroundColor}');
  print('  elevation: ${searchViewThemeData.elevation}');
  print('  dividerColor: ${searchViewThemeData.dividerColor}');
  print('  constraints: ${searchViewThemeData.constraints}');
  print('  shape: ${searchViewThemeData.shape}');

  // Test copyWith
  final copiedSearchViewTheme = searchViewThemeData.copyWith(
    backgroundColor: Colors.grey.shade50,
    elevation: 8.0,
  );
  print('SearchViewThemeData.copyWith created');
  print('  new backgroundColor: ${copiedSearchViewTheme.backgroundColor}');
  print('  new elevation: ${copiedSearchViewTheme.elevation}');

  // ========== WRAP IN THEME WIDGET ==========
  print('--- Theme Integration ---');

  final themeData = ThemeData(
    menuTheme: menuThemeData,
    menuBarTheme: menuBarThemeData,
    dropdownMenuTheme: dropdownMenuThemeData,
    searchBarTheme: searchBarThemeData,
    searchViewTheme: searchViewThemeData,
  );
  print('ThemeData with menu themes created');

  return Theme(
    data: themeData,
    child: Builder(
      builder: (ctx) {
        final resolvedTheme = Theme.of(ctx);
        print('Theme.of resolved');
        print('  menuTheme.style: ${resolvedTheme.menuTheme.style}');
        print('  menuBarTheme.style: ${resolvedTheme.menuBarTheme.style}');
        print(
          '  dropdownMenuTheme.textStyle: ${resolvedTheme.dropdownMenuTheme.textStyle}',
        );
        print(
          '  searchBarTheme.constraints: ${resolvedTheme.searchBarTheme.constraints}',
        );
        print(
          '  searchViewTheme.elevation: ${resolvedTheme.searchViewTheme.elevation}',
        );

        return MenuTheme(
          data: menuThemeData,
          child: MenuBarTheme(
            data: menuBarThemeData,
            child: DropdownMenuTheme(
              data: dropdownMenuThemeData,
              child: SearchBarTheme(
                data: searchBarThemeData,
                child: SearchViewTheme(
                  data: searchViewThemeData,
                  child: Card(child: Text('Menu themes test passed')),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
