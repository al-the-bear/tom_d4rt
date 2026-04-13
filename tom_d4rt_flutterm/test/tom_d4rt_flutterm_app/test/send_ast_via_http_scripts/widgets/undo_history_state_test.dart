import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {'label': 'Class', 'value': 'UndoHistoryState'},
    {'label': 'Kind', 'value': 'State class for UndoHistoryController integration'},
    {'label': 'Purpose', 'value': 'Manages undo/redo stack state and value snapshots for editable content'},
    {'label': 'Key property', 'value': 'value — current UndoHistoryValue with undo/redo availability'},
    {'label': 'Related', 'value': 'UndoHistoryController, UndoHistoryValue'},
    {'label': 'Use-case', 'value': 'Text editors and form fields with undo/redo support'},
    {'label': 'Flutter layer', 'value': 'widgets (undo history)'},
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF0F172A),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('UndoHistoryState Summary'),
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
