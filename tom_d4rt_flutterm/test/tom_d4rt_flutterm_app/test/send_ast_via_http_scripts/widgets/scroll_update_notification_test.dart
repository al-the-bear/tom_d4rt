// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const updates = <Map<String, String>>[
    {
      'delta': '+18.0',
      'phase': 'drag',
      'effect': 'continuous position updates',
    },
    {
      'delta': '+24.0',
      'phase': 'drag',
      'effect': 'overscroll clamped by physics',
    },
    {
      'delta': '-12.0',
      'phase': 'correction',
      'effect': 'position settles back into range',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('ScrollUpdateNotification')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: updates.length,
        separatorBuilder: (_, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final row = updates[index];
          return ListTile(
            tileColor: Colors.blueGrey.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text('Delta ${row['delta']} during ${row['phase']}'),
            subtitle: Text(row['effect']!),
          );
        },
      ),
    ),
  );
}
