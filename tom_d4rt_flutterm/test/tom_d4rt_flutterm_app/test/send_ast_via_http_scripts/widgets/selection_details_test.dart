// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {
      'field': 'baseOffset',
      'value': '12',
      'note': 'Anchor position of current selection.',
    },
    {
      'field': 'extentOffset',
      'value': '28',
      'note': 'Active edge while expanding selection.',
    },
    {
      'field': 'isDirectional',
      'value': 'true',
      'note': 'Preserves direction for keyboard traversal.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('SelectionDetails')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: rows.length,
        separatorBuilder: (_, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final row = rows[index];
          return ListTile(
            tileColor: Colors.indigo.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text('${row['field']}: ${row['value']}'),
            subtitle: Text(row['note']!),
          );
        },
      ),
    ),
  );
}
