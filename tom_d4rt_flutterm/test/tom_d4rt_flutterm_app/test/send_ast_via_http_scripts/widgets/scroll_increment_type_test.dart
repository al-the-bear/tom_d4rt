// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const items = <String, String>{
    'line': 'Moves by a small logical unit for precision input.',
    'page': 'Moves by one viewport length for rapid navigation.',
  };

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('ScrollIncrementType')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: items.entries
              .map(
                (entry) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(entry.key),
                    subtitle: Text(entry.value),
                    trailing: const Icon(Icons.swap_vert_circle_outlined),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}
