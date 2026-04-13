// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const intents = <Map<String, String>>[
    {
      'command': 'forward',
      'target': 'maxScrollExtent',
      'note': 'Jump to the end of the document.',
    },
    {
      'command': 'backward',
      'target': 'minScrollExtent',
      'note': 'Return to the start of the document.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('ScrollToDocumentBoundaryIntent')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: intents
              .map(
                (entry) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text(entry['command']!),
                    subtitle: Text('${entry['target']}: ${entry['note']}'),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}
