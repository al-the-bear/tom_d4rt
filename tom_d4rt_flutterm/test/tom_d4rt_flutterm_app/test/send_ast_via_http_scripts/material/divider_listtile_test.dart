// D4rt test script: Tests Divider, VerticalDivider, DividerThemeData,
// ListTileTheme, ListTileThemeData, ListTileStyle
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Divider/ListTile theme test executing');

  // ========== Divider ==========
  print('--- Divider Tests ---');
  final divider = Divider(
    height: 16.0,
    thickness: 2.0,
    indent: 16.0,
    endIndent: 16.0,
    color: Colors.grey,
  );
  print('Divider created: height=16, thickness=2');

  // ========== VerticalDivider ==========
  print('--- VerticalDivider Tests ---');
  final vDivider = VerticalDivider(
    width: 16.0,
    thickness: 2.0,
    indent: 8.0,
    endIndent: 8.0,
    color: Colors.grey,
  );
  print('VerticalDivider created: width=16');

  // ========== DividerThemeData ==========
  print('--- DividerThemeData Tests ---');
  final dividerTheme = DividerThemeData(
    color: Colors.grey.shade300,
    space: 16.0,
    thickness: 1.0,
    indent: 0.0,
    endIndent: 0.0,
  );
  print('DividerThemeData created');
  print('  space: ${dividerTheme.space}');

  // ========== ListTileStyle ==========
  print('--- ListTileStyle Tests ---');
  for (final style in ListTileStyle.values) {
    print('ListTileStyle: ${style.name}');
  }

  // ========== ListTileThemeData ==========
  print('--- ListTileThemeData Tests ---');
  final listTileTheme = ListTileThemeData(
    dense: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    style: ListTileStyle.list,
    selectedColor: Colors.blue,
    iconColor: Colors.grey,
    textColor: Colors.black87,
    titleTextStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
    subtitleTextStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
    leadingAndTrailingTextStyle: TextStyle(fontSize: 12.0),
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
    tileColor: Colors.white,
    selectedTileColor: Colors.blue.shade50,
    horizontalTitleGap: 16.0,
    minVerticalPadding: 4.0,
    minLeadingWidth: 40.0,
    enableFeedback: true,
    visualDensity: VisualDensity.compact,
  );
  print('ListTileThemeData created');
  print('  dense: ${listTileTheme.dense}');
  print('  style: ${listTileTheme.style}');

  // ========== ListTileTheme ==========
  print('--- ListTileTheme Tests ---');
  final theme = ListTileTheme(
    data: listTileTheme,
    child: ListView(
      shrinkWrap: true,
      children: [
        ListTile(title: Text('Themed Tile 1')),
        ListTile(title: Text('Themed Tile 2')),
      ],
    ),
  );
  print('ListTileTheme wrapping tiles');

  // ========== ListTileControlAffinity ==========
  print('--- ListTileControlAffinity Tests ---');
  for (final aff in ListTileControlAffinity.values) {
    print('ListTileControlAffinity: ${aff.name}');
  }

  print('All divider/listtile tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Divider/ListTile Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          ListTile(title: Text('Item 1'), subtitle: Text('Subtitle')),
          divider,
          ListTile(title: Text('Item 2'), trailing: Icon(Icons.arrow_forward)),
          divider,
          ListTile(title: Text('Item 3'), leading: Icon(Icons.star)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Left'), vDivider, Text('Right')],
          ),
        ],
      ),
    ),
  );
}
