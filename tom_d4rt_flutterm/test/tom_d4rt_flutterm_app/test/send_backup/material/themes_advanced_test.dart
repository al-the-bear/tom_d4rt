import 'package:flutter/material.dart';

/// Deep visual demo for ThemesAdvanced
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Advanced Themes Demo')), body: SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children: [Card(child: ListTile(leading: Icon(Icons.color_lens), title: Text('ColorScheme'), subtitle: Text('Primary, secondary, surface colors'))), Card(child: ListTile(leading: Icon(Icons.text_fields), title: Text('TextTheme'), subtitle: Text('Typography styles'))), Card(child: ListTile(leading: Icon(Icons.widgets), title: Text('Component Themes'), subtitle: Text('AppBar, Card, Button themes'))), Card(child: ListTile(leading: Icon(Icons.extension), title: Text('ThemeExtension'), subtitle: Text('Custom theme properties'))), Card(child: ListTile(leading: Icon(Icons.brightness_6), title: Text('Dark/Light Mode'), subtitle: Text('ThemeMode switching')))])));
}
