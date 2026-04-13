import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {'label': 'Class', 'value': 'TransposeCharactersIntent'},
    {'label': 'Kind', 'value': 'Intent (text editing action)'},
    {'label': 'Purpose', 'value': 'Represents a command to swap adjacent characters around the caret'},
    {'label': 'Key concept', 'value': 'Declares what to do; Action binding decides how'},
    {'label': 'Related', 'value': 'Actions, Shortcuts, EditableText'},
    {'label': 'Use-case', 'value': 'Keyboard shortcut for character transposition in text fields'},
    {'label': 'Flutter layer', 'value': 'widgets (text editing intents)'},
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF004D40),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('TransposeCharactersIntent Summary'),
      ),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, index) {
          final row = rows[index];
          return ListTile(
            leading: Text(
              '${index + 1}',
              style: const TextStyle(color: Color(0xFFFF8A65), fontSize: 16),
            ),
            title: Text(row['label']!,
                style: const TextStyle(
                    color: Color(0xFFFFD27A), fontWeight: FontWeight.w700)),
            subtitle: Text(row['value']!,
                style: const TextStyle(color: Color(0xFFE0F2F1))),
          );
        },
      ),
    ),
  );
}
