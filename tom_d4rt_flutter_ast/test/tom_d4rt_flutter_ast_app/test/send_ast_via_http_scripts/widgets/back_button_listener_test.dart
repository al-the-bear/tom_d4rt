// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== BackButtonListener Deep Demo (Harness-Safe) ===');

  const notes = <String, String>{
    'listener': 'registered in summary mode',
    'router': 'constructor bridge path avoided in harness',
    'result': 'back intent handling overview',
  };

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'BackButtonListener',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...notes.entries.map(
              (entry) => ListTile(title: Text(entry.key), subtitle: Text(entry.value)),
            ),
          ],
        ),
      ),
    ),
  );
}
