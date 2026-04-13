// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== NestedScrollViewState Deep Demo (Harness-Safe) ===');

  const sections = <String>[
    'header composition',
    'body composition',
    'state transitions',
    'scroll coupling',
    'practical board',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: sections.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(sections[index]),
            );
          },
        ),
      ),
    ),
  );
}
