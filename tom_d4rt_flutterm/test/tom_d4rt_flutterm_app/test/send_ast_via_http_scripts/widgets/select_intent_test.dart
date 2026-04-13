// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const intents = <Map<String, String>>[
    {
      'intent': 'SelectIntent(SelectionChangedCause.tap)',
      'effect': 'Select nearest selectable region around tap.',
    },
    {
      'intent': 'SelectIntent(SelectionChangedCause.keyboard)',
      'effect': 'Move and expand selection via keyboard navigation.',
    },
    {
      'intent': 'SelectIntent(SelectionChangedCause.longPress)',
      'effect': 'Select word and open text toolbar actions.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('SelectIntent')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: intents.length,
        itemBuilder: (context, index) {
          final row = intents[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Text(row['intent']!),
              subtitle: Text(row['effect']!),
            ),
          );
        },
      ),
    ),
  );
}
