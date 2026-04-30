// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== AlignTransition Deep Demo (Harness-Safe) ===');

  const samples = <String>[
    'Alignment.topLeft',
    'Alignment.center',
    'Alignment.bottomRight',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'AlignTransition',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: samples.map((sample) => Card(child: ListTile(title: Text(sample)))).toList(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
