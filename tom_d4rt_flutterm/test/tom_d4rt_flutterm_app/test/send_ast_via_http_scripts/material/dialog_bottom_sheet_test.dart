// D4rt test script: Tests Dialog advanced, AlertDialog advanced,
// SimpleDialog, SimpleDialogOption, DialogThemeData, showDialog,
// showGeneralDialog, showAboutDialog, AboutDialog, LicensePage
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Dialog and bottom sheet test executing');

  // ========== AlertDialog advanced ==========
  print('--- AlertDialog Advanced Tests ---');
  final alertDialog = AlertDialog(
    title: Text('Alert Title'),
    titlePadding: EdgeInsets.fromLTRB(24, 24, 24, 0),
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Alert dialog content goes here.'),
        SizedBox(height: 16),
        TextField(decoration: InputDecoration(labelText: 'Input')),
      ],
    ),
    contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
    contentTextStyle: TextStyle(fontSize: 16, color: Colors.black87),
    actions: [
      TextButton(onPressed: () {}, child: Text('Cancel')),
      ElevatedButton(onPressed: () {}, child: Text('OK')),
    ],
    actionsPadding: EdgeInsets.fromLTRB(24, 0, 24, 24),
    actionsAlignment: MainAxisAlignment.end,
    actionsOverflowAlignment: OverflowBarAlignment.end,
    actionsOverflowDirection: VerticalDirection.down,
    actionsOverflowButtonSpacing: 8.0,
    backgroundColor: Colors.white,
    elevation: 24.0,
    shadowColor: Colors.black54,
    surfaceTintColor: Colors.blue[50],
    insetPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 24),
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    alignment: Alignment.center,
    scrollable: false,
    icon: Icon(Icons.warning, color: Colors.orange, size: 48),
    iconPadding: EdgeInsets.only(top: 24),
    iconColor: Colors.orange,
  );
  print('AlertDialog advanced created');

  // ========== SimpleDialog ==========
  print('--- SimpleDialog Tests ---');
  final simpleDialog = SimpleDialog(
    title: Text('Select an option'),
    titlePadding: EdgeInsets.fromLTRB(24, 24, 24, 0),
    titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
    children: [
      SimpleDialogOption(
        onPressed: () => print('  Option 1 selected'),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.access_time, color: Colors.blue),
            SizedBox(width: 16),
            Text('Option 1'),
          ],
        ),
      ),
      SimpleDialogOption(
        onPressed: () => print('  Option 2 selected'),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.audiotrack, color: Colors.green),
            SizedBox(width: 16),
            Text('Option 2'),
          ],
        ),
      ),
      SimpleDialogOption(
        onPressed: () => print('  Option 3 selected'),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.map, color: Colors.red),
            SizedBox(width: 16),
            Text('Option 3'),
          ],
        ),
      ),
    ],
    contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 16),
    backgroundColor: Colors.white,
    elevation: 24.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    alignment: Alignment.center,
    insetPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 24),
  );
  print('SimpleDialog created');

  // ========== DialogThemeData ==========
  print('--- DialogThemeData Tests ---');
  final dialogTheme = DialogThemeData(
    backgroundColor: Colors.white,
    elevation: 24.0,
    shadowColor: Colors.black54,
    surfaceTintColor: Colors.blue[50],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    alignment: Alignment.center,
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    contentTextStyle: TextStyle(fontSize: 16),
    actionsPadding: EdgeInsets.fromLTRB(24, 0, 24, 24),
    iconColor: Colors.blue,
    insetPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 24),
    clipBehavior: Clip.antiAlias,
  );
  print('DialogThemeData created');
  print('  elevation: ${dialogTheme.elevation}');

  // ========== AboutDialog ==========
  print('--- AboutDialog Tests ---');
  final aboutDialog = AboutDialog(
    applicationName: 'Test App',
    applicationVersion: '1.0.0',
    applicationIcon: Icon(Icons.apps, size: 48),
    applicationLegalese: '© 2024 Test Company',
    children: [
      SizedBox(height: 16),
      Text('Additional information about the app.'),
    ],
  );
  print('AboutDialog created');

  // ========== LicensePage ==========
  print('--- LicensePage Tests ---');
  final licensePage = LicensePage(
    applicationName: 'Test App',
    applicationVersion: '1.0.0',
    applicationIcon: Icon(Icons.apps, size: 48),
    applicationLegalese: '© 2024 Test Company',
  );
  print('LicensePage created');

  // ========== OverflowBarAlignment ==========
  print('--- OverflowBarAlignment Tests ---');
  for (final a in OverflowBarAlignment.values) {
    print('  OverflowBarAlignment.$a');
  }

  // ========== showModalBottomSheet concepts ==========
  print('--- ModalBottomSheet Concepts ---');
  final modalContent = Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40, height: 4,
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        ListTile(
          leading: Icon(Icons.share), title: Text('Share'),
          onTap: () => print('  Share tapped'),
        ),
        ListTile(
          leading: Icon(Icons.link), title: Text('Get Link'),
          onTap: () => print('  Get link tapped'),
        ),
        ListTile(
          leading: Icon(Icons.edit), title: Text('Edit'),
          onTap: () => print('  Edit tapped'),
        ),
        ListTile(
          leading: Icon(Icons.delete, color: Colors.red),
          title: Text('Delete', style: TextStyle(color: Colors.red)),
          onTap: () => print('  Delete tapped'),
        ),
      ],
    ),
  );
  print('Modal bottom sheet content created');

  // ========== showTimePicker / showDatePicker concepts ==========
  print('--- Picker Dialog Concepts ---');
  final datePicker = DatePickerDialog(
    initialDate: DateTime(2024, 1, 15),
    firstDate: DateTime(2020, 1, 1),
    lastDate: DateTime(2030, 12, 31),
    initialCalendarMode: DatePickerMode.day,
    initialEntryMode: DatePickerEntryMode.calendar,
  );
  print('DatePickerDialog created');

  print('All dialog / bottom sheet tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    theme: ThemeData(dialogTheme: dialogTheme),
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            alertDialog,
            SizedBox(height: 16),
            simpleDialog,
            SizedBox(height: 16),
            modalContent,
          ],
        ),
      ),
    ),
  );
}
