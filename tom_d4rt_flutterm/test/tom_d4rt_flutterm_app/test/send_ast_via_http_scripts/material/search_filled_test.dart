// D4rt test script: Tests material SearchAnchor, SearchBar, SearchController,
// SearchBarThemeData, FilledButton advanced, FilledButton.tonal
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Material search/filled button test executing');

  // ========== SearchController ==========
  print('--- SearchController Tests ---');
  final searchCtrl = SearchController();
  print('SearchController created');
  print('  text: "${searchCtrl.text}"');
  print('  isOpen: ${searchCtrl.isOpen}');

  // ========== SearchBarThemeData ==========
  print('--- SearchBarThemeData Tests ---');
  final searchBarTheme = SearchBarThemeData(
    elevation: WidgetStateProperty.all(2.0),
    backgroundColor: WidgetStateProperty.all(Colors.white),
    padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(horizontal: 16.0)),
    textStyle: WidgetStateProperty.all(TextStyle(fontSize: 16.0)),
    hintStyle: WidgetStateProperty.all(TextStyle(color: Colors.grey)),
    shape: WidgetStateProperty.all(
        StadiumBorder()),
    constraints: BoxConstraints(minHeight: 56.0, maxWidth: 600.0),
  );
  print('SearchBarThemeData created');
  print('  constraints: ${searchBarTheme.constraints}');

  // ========== SearchViewThemeData ==========
  print('--- SearchViewThemeData Tests ---');
  final searchViewTheme = SearchViewThemeData(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    elevation: 4.0,
    dividerColor: Colors.grey.shade300,
    headerTextStyle: TextStyle(fontSize: 18.0),
    headerHintStyle: TextStyle(color: Colors.grey),
    constraints: BoxConstraints(minWidth: 360, maxWidth: 800, minHeight: 240),
  );
  print('SearchViewThemeData created');

  // ========== FilledButton advanced ==========
  print('--- FilledButton advanced Tests ---');
  final filled = FilledButton(
    onPressed: () => print('filled pressed'),
    style: FilledButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey.shade300,
      shadowColor: Colors.black26,
      surfaceTintColor: Colors.blue.shade100,
      elevation: 2.0,
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      minimumSize: Size(88.0, 36.0),
      maximumSize: Size(double.infinity, 56.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      side: BorderSide.none,
      textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
    ),
    child: Text('Filled'),
  );
  print('FilledButton with custom style created');

  // ========== FilledButton.tonal ==========
  print('--- FilledButton.tonal Tests ---');
  final tonal = FilledButton.tonal(
    onPressed: () => print('tonal pressed'),
    style: FilledButton.styleFrom(
      backgroundColor: Colors.blue.shade100,
      foregroundColor: Colors.blue.shade900,
    ),
    child: Text('Tonal'),
  );
  print('FilledButton.tonal created');

  // ========== FilledButton.tonalIcon ==========
  print('--- FilledButton.tonalIcon Tests ---');
  final tonalIcon = FilledButton.tonalIcon(
    onPressed: () {},
    icon: Icon(Icons.add),
    label: Text('Add Item'),
  );
  print('FilledButton.tonalIcon created');

  // ========== FilledButtonThemeData ==========
  print('--- FilledButtonThemeData Tests ---');
  final filledTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      shape: StadiumBorder(),
    ),
  );
  print('FilledButtonThemeData created');

  // ========== OutlinedButton.icon ==========
  print('--- OutlinedButton.icon Tests ---');
  final outlinedIcon = OutlinedButton.icon(
    onPressed: () {},
    icon: Icon(Icons.download),
    label: Text('Download'),
  );
  print('OutlinedButton.icon created');

  // ========== TextButton.icon ==========
  print('--- TextButton.icon Tests ---');
  final textIcon = TextButton.icon(
    onPressed: () {},
    icon: Icon(Icons.info),
    label: Text('Info'),
  );
  print('TextButton.icon created');

  print('All material search/filled button tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Search / Filled Button Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              SearchBar(
                controller: searchCtrl,
                hintText: 'Search...',
                leading: Icon(Icons.search),
                trailing: [Icon(Icons.mic)],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [filled, tonal, tonalIcon],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [outlinedIcon, textIcon],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
