// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const responsibilities = <Map<String, String>>[
    {
      'task': 'getSelection',
      'purpose': 'Expose current selection geometry for descendants.',
    },
    {
      'task': 'handleSelectAll',
      'purpose': 'Expand selection to full delegate-managed content.',
    },
    {
      'task': 'dispatchSelectionEvent',
      'purpose': 'Propagate updates to parent selection container.',
    },
    {
      'task': 'clearSelection',
      'purpose': 'Collapse selection and notify observers.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('SelectionContainerDelegate')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.4,
        ),
        itemCount: responsibilities.length,
        itemBuilder: (context, index) {
          final row = responsibilities[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    row['task']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(row['purpose']!),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
