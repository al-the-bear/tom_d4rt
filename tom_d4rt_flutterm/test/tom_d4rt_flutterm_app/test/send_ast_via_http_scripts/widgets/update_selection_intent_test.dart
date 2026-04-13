import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {'label': 'Class', 'value': 'UpdateSelectionIntent'},
    {'label': 'Kind', 'value': 'Intent (text selection action)'},
    {'label': 'Purpose', 'value': 'Represents a command to update text selection boundaries'},
    {'label': 'Key params', 'value': 'newSelection, cause — describes the target selection and trigger'},
    {'label': 'Related', 'value': 'ExtendSelectionByCharacterIntent, Actions'},
    {'label': 'Use-case', 'value': 'Programmatic or keyboard-driven text selection changes'},
    {'label': 'Flutter layer', 'value': 'widgets (text editing intents)'},
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF0F172A),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('UpdateSelectionIntent Summary'),
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
