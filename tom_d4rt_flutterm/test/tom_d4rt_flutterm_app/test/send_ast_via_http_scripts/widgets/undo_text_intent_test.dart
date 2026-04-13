import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {'label': 'Class', 'value': 'UndoTextIntent'},
    {'label': 'Kind', 'value': 'Intent (text editing action)'},
    {'label': 'Purpose', 'value': 'Represents a command to undo the last text editing operation'},
    {'label': 'Key concept', 'value': 'Declares undo intent; Action binding performs the actual undo'},
    {'label': 'Related', 'value': 'RedoTextIntent, UndoHistoryController'},
    {'label': 'Use-case', 'value': 'Keyboard shortcut (Ctrl+Z) for undoing text changes'},
    {'label': 'Flutter layer', 'value': 'widgets (text editing intents)'},
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF0F172A),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('UndoTextIntent Summary'),
      ),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, index) {
          final row = rows[index];
          return ListTile(
            leading: Text(
              '${index + 1}',
              style: const TextStyle(color: Color(0xFF99F6E4), fontSize: 16),
            ),
            title: Text(row['label']!,
                style: const TextStyle(
                    color: Color(0xFFFFD27A), fontWeight: FontWeight.w700)),
            subtitle: Text(row['value']!,
                style: const TextStyle(color: Color(0xFFF8FAFC))),
          );
        },
      ),
    ),
  );
}
