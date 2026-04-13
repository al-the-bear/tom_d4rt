import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {'label': 'Class', 'value': 'TextSelectionGestureDetectorBuilderDelegate'},
    {'label': 'Kind', 'value': 'Abstract class / Delegate'},
    {'label': 'Purpose', 'value': 'Provides configuration callbacks for text-selection gesture handling'},
    {'label': 'Key method', 'value': 'forcePressEnabled — whether force press triggers selection'},
    {'label': 'Related', 'value': 'TextSelectionGestureDetectorBuilder'},
    {'label': 'Use-case', 'value': 'Custom editable text fields with gesture control'},
    {'label': 'Flutter layer', 'value': 'widgets (text editing)'},
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF0F1A1A),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('TextSelectionGestureDetectorBuilderDelegate Summary'),
      ),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, index) {
          final row = rows[index];
          return ListTile(
            leading: Text(
              '${index + 1}',
              style: const TextStyle(color: Color(0xFF6FE0D0), fontSize: 16),
            ),
            title: Text(row['label']!,
                style: const TextStyle(
                    color: Color(0xFFFFBE7A), fontWeight: FontWeight.w700)),
            subtitle: Text(row['value']!,
                style: const TextStyle(color: Color(0xFFD7EEEE))),
          );
        },
      ),
    ),
  );
}
