// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ButtonBarLayoutBehavior Deep Demo (Harness-Safe) ===');

  final values = ButtonBarLayoutBehavior.values;
  for (final v in values) {
    print('  ${v.index}: ${v.name}');
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
                'ButtonBarLayoutBehavior',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('start: children align at the leading edge.'),
              const Text('padded: children include surrounding button padding.'),
              const SizedBox(height: 12),
              ...values.map((v) => Text('${v.index}. ${v.name}')),
              const Spacer(),
              const Row(
                children: [
                  ElevatedButton(onPressed: null, child: Text('Primary')),
                  SizedBox(width: 8),
                  OutlinedButton(onPressed: null, child: Text('Secondary')),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
