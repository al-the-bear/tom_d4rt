// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== AutocompleteHighlightedOption Deep Demo (Harness-Safe) ===');

  const options = <String>['alpha', 'bravo', 'charlie'];
  const highlightedIndex = 1;

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Autocomplete Highlighted Option',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...options.asMap().entries.map(
              (entry) => ListTile(
                title: Text(entry.value),
                trailing: entry.key == highlightedIndex ? const Icon(Icons.check) : null,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
