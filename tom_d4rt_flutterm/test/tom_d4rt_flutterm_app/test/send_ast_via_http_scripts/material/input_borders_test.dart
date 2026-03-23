// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests InputDecorationTheme, OutlineInputBorder,
// UnderlineInputBorder, FloatingLabelBehavior, FloatingLabelAlignment
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Input borders test executing');

  // ========== FloatingLabelBehavior ==========
  print('--- FloatingLabelBehavior Tests ---');
  for (final b in FloatingLabelBehavior.values) {
    print('FloatingLabelBehavior: ${b.name}');
  }

  // ========== FloatingLabelAlignment ==========
  print('--- FloatingLabelAlignment Tests ---');
  print('start: ${FloatingLabelAlignment.start}');
  print('center: ${FloatingLabelAlignment.center}');

  // ========== OutlineInputBorder ==========
  print('--- OutlineInputBorder Tests ---');
  final outlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: BorderSide(color: Colors.blue, width: 2.0),
    gapPadding: 4.0,
  );
  print('OutlineInputBorder created');
  print('  borderRadius: ${outlineBorder.borderRadius}');
  print('  gapPadding: ${outlineBorder.gapPadding}');

  // ========== UnderlineInputBorder ==========
  print('--- UnderlineInputBorder Tests ---');
  final underlineBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(4.0),
      topRight: Radius.circular(4.0),
    ),
  );
  print('UnderlineInputBorder created: $underlineBorder');

  // ========== InputDecorationTheme ==========
  print('--- InputDecorationTheme Tests ---');
  final theme = InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.grey),
    hintStyle: TextStyle(color: Colors.grey.shade400),
    errorStyle: TextStyle(color: Colors.red),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    floatingLabelAlignment: FloatingLabelAlignment.start,
    isDense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    border: outlineBorder,
    enabledBorder: outlineBorder.copyWith(
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: outlineBorder,
    errorBorder: outlineBorder.copyWith(
      borderSide: BorderSide(color: Colors.red),
    ),
    filled: true,
    fillColor: Colors.grey.shade50,
    focusColor: Colors.blue.shade50,
    hoverColor: Colors.grey.shade100,
  );
  print('InputDecorationTheme created');
  print('  floatingLabelBehavior: ${theme.floatingLabelBehavior}');
  print('  isDense: ${theme.isDense}');
  print('  filled: ${theme.filled}');

  // ========== InputDecoration advanced ==========
  print('--- InputDecoration advanced Tests ---');
  final decoration = InputDecoration(
    icon: Icon(Icons.email),
    labelText: 'Email',
    hintText: 'Enter your email',
    helperText: 'We won\'t share your email',
    errorText: null,
    prefix: Text('@'),
    suffix: Icon(Icons.check, color: Colors.green),
    counter: Text('0/100'),
    filled: true,
    fillColor: Colors.grey.shade50,
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    floatingLabelAlignment: FloatingLabelAlignment.start,
    constraints: BoxConstraints(maxWidth: 400),
  );
  print('Advanced InputDecoration created: $decoration');

  print('All input borders tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Input Borders Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Outline',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Underline',
                border: UnderlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
