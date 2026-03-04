// D4rt test script: Tests ButtonStyle, ButtonBar, PopupMenuButton,
// PopupMenuItem, PopupMenuDivider
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Button style and popup menu test executing');

  // ========== ButtonStyle ==========
  print('--- ButtonStyle Tests ---');

  final style1 = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.blue),
    foregroundColor: WidgetStateProperty.all(Colors.white),
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0)),
    elevation: WidgetStateProperty.all(4.0),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
    minimumSize: WidgetStateProperty.all(Size(120.0, 48.0)),
    tapTargetSize: MaterialTapTargetSize.padded,
    visualDensity: VisualDensity.standard,
  );
  print('ButtonStyle created');

  // ButtonStyle.copyWith
  final style2 = style1.copyWith(
    backgroundColor: WidgetStateProperty.all(Colors.red),
  );
  print('ButtonStyle copyWith created');

  // ButtonStyle.merge
  final style3 = style1.merge(ButtonStyle(
    elevation: WidgetStateProperty.all(8.0),
  ));
  print('ButtonStyle merge created');

  // ========== WidgetStateProperty ==========
  print('--- WidgetStateProperty Tests ---');

  final bgProp = WidgetStateProperty.resolveWith<Color>((states) {
    if (states.contains(WidgetState.pressed)) return Colors.blue.shade700;
    if (states.contains(WidgetState.hovered)) return Colors.blue.shade300;
    if (states.contains(WidgetState.disabled)) return Colors.grey;
    return Colors.blue;
  });
  final resolvedNormal = bgProp.resolve({});
  print('WidgetStateProperty resolved normal: $resolvedNormal');

  final resolvedPressed = bgProp.resolve({WidgetState.pressed});
  print('WidgetStateProperty resolved pressed: $resolvedPressed');

  final resolvedDisabled = bgProp.resolve({WidgetState.disabled});
  print('WidgetStateProperty resolved disabled: $resolvedDisabled');

  // ========== WidgetState ==========
  print('--- WidgetState Tests ---');

  print('WidgetState.hovered: ${WidgetState.hovered}');
  print('WidgetState.focused: ${WidgetState.focused}');
  print('WidgetState.pressed: ${WidgetState.pressed}');
  print('WidgetState.dragged: ${WidgetState.dragged}');
  print('WidgetState.selected: ${WidgetState.selected}');
  print('WidgetState.scrolledUnder: ${WidgetState.scrolledUnder}');
  print('WidgetState.disabled: ${WidgetState.disabled}');
  print('WidgetState.error: ${WidgetState.error}');
  print('WidgetState.values: ${WidgetState.values}');

  print('All button style and popup menu tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Button Style Test')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Button Style & Popup Menu Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: style1,
              onPressed: () => print('Pressed 1'),
              child: Text('Style 1'),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              style: style2,
              onPressed: () => print('Pressed 2'),
              child: Text('Style 2 (red)'),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              style: style3,
              onPressed: () => print('Pressed 3'),
              child: Text('Style 3 (merged)'),
            ),
            SizedBox(height: 16.0),
            PopupMenuButton<String>(
              onSelected: (String value) {
                print('Selected: $value');
              },
              itemBuilder: (BuildContext ctx) => [
                PopupMenuItem<String>(value: 'edit', child: Text('Edit')),
                PopupMenuItem<String>(value: 'delete', child: Text('Delete')),
                PopupMenuDivider(),
                PopupMenuItem<String>(
                  value: 'share',
                  child: ListTile(
                    leading: Icon(Icons.share),
                    title: Text('Share'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
              child: Text('Show Menu'),
            ),
          ],
        ),
      ),
    ),
  );
}
