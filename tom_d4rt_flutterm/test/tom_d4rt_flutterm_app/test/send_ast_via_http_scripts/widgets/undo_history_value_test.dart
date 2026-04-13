import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {'label': 'Class', 'value': 'UndoHistoryValue'},
    {'label': 'Kind', 'value': 'Immutable value object for undo/redo state'},
    {'label': 'Purpose', 'value': 'Describes whether undo and redo operations are currently available'},
    {'label': 'Key property', 'value': 'canUndo / canRedo — boolean availability flags'},
    {'label': 'Related', 'value': 'UndoHistoryController, UndoHistoryState'},
    {'label': 'Use-case', 'value': 'Enabling/disabling undo/redo buttons based on stack state'},
    {'label': 'Flutter layer', 'value': 'widgets (undo history)'},
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF0B1324),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('UndoHistoryValue Summary'),
      ),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, index) {
          final row = rows[index];
          return ListTile(
            leading: Text(
              '${index + 1}',
              style: const TextStyle(color: Color(0xFFA5F3FC), fontSize: 16),
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
