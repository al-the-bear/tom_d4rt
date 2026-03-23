// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SimpleDialog, SimpleDialogOption, DialogTheme,
// AlertDialog advanced properties
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Dialog advanced test executing');

  // ========== SimpleDialogOption ==========
  print('--- SimpleDialogOption Tests ---');
  final option1 = SimpleDialogOption(
    onPressed: () => print('Option 1 selected'),
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
    child: Text('Account 1'),
  );
  print('SimpleDialogOption created');

  // ========== SimpleDialog ==========
  print('--- SimpleDialog Tests ---');
  final simpleDialog = SimpleDialog(
    title: Text('Select Account'),
    titlePadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
    contentPadding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),
    elevation: 24.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    backgroundColor: Colors.white,
    children: [
      option1,
      SimpleDialogOption(onPressed: () {}, child: Text('Account 2')),
      SimpleDialogOption(onPressed: () {}, child: Text('Add Account')),
    ],
  );
  print('SimpleDialog created with 3 options');

  // ========== DialogTheme ==========
  print('--- DialogTheme Tests ---');
  final dialogTheme = DialogThemeData(
    backgroundColor: Colors.white,
    elevation: 24.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    contentTextStyle: TextStyle(fontSize: 16.0, color: Colors.black87),
    alignment: Alignment.center,
    actionsPadding: EdgeInsets.all(8.0),
  );
  print('DialogThemeData created');
  print('  elevation: ${dialogTheme.elevation}');

  // ========== AlertDialog advanced ==========
  print('--- AlertDialog advanced Tests ---');
  final alertDialog = AlertDialog(
    title: Text('Alert'),
    content: Text('This is an advanced alert dialog'),
    titlePadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
    contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
    actionsPadding: EdgeInsets.all(8.0),
    actionsAlignment: MainAxisAlignment.spaceBetween,
    actionsOverflowDirection: VerticalDirection.down,
    actionsOverflowButtonSpacing: 8.0,
    clipBehavior: Clip.antiAlias,
    scrollable: false,
    elevation: 24.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    icon: Icon(Icons.warning, color: Colors.orange),
    iconPadding: EdgeInsets.only(top: 16.0),
    iconColor: Colors.orange,
    actions: [
      TextButton(onPressed: () {}, child: Text('Cancel')),
      ElevatedButton(onPressed: () {}, child: Text('OK')),
    ],
  );
  print('Advanced AlertDialog created: $alertDialog');
  print('  scrollable: false');
  print('  with icon');

  print('All dialog advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    theme: ThemeData(dialogTheme: dialogTheme),
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dialog Advanced Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            simpleDialog,
          ],
        ),
      ),
    ),
  );
}
