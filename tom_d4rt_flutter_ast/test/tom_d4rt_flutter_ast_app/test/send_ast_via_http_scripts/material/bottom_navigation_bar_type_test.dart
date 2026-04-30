// ignore_for_file: avoid_print
// D4rt test script: Harness-safe BottomNavigationBarType summary demo.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== BottomNavigationBarType Deep Demo (Harness-Safe) ===');
  print('values: ${BottomNavigationBarType.values.length}');
  for (final type in BottomNavigationBarType.values) {
    print('  ${type.index}: ${type.name}');
  }

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'BottomNavigationBarType',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Fixed: all labels visible, equal-width items.'),
              const Text('Shifting: selected item emphasized, label behavior changes.'),
              const SizedBox(height: 14),
              const Divider(),
              ...BottomNavigationBarType.values.map(
                (type) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text('${type.index}. ${type.name}'),
                ),
              ),
              const Spacer(),
              BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: 0,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
