// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const scenarios = <Map<String, String>>[
    {
      'input': 'single-line field',
      'selection': 'select entire value',
      'shortcut': 'Ctrl/Cmd + A',
    },
    {
      'input': 'multi-line editor',
      'selection': 'select all document text',
      'shortcut': 'Ctrl/Cmd + A',
    },
    {
      'input': 'read-only viewer',
      'selection': 'intent ignored',
      'shortcut': 'N/A',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('SelectAllTextIntent')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 10,
          childAspectRatio: 3.8,
        ),
        itemCount: scenarios.length,
        itemBuilder: (context, index) {
          final row = scenarios[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    row['input']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text('Selection: ${row['selection']}'),
                  Text('Shortcut: ${row['shortcut']}'),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
