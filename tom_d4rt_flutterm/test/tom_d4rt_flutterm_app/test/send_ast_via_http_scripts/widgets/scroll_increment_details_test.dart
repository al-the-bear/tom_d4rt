// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {
      'source': 'keyboard',
      'increment': 'line',
      'behavior': 'small forward step',
    },
    {
      'source': 'keyboard',
      'increment': 'page',
      'behavior': 'viewport-sized jump',
    },
    {
      'source': 'semantics',
      'increment': 'line',
      'behavior': 'accessibility nudge',
    },
    {
      'source': 'semantics',
      'increment': 'page',
      'behavior': 'accessibility page jump',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('ScrollIncrementDetails')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Source')),
            DataColumn(label: Text('Type')),
            DataColumn(label: Text('Behavior')),
          ],
          rows: rows
              .map(
                (row) => DataRow(
                  cells: [
                    DataCell(Text(row['source']!)),
                    DataCell(Text(row['increment']!)),
                    DataCell(Text(row['behavior']!)),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}
