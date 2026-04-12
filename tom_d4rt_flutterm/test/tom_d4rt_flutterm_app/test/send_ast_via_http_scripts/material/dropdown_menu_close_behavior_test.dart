// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== DropdownMenuCloseBehavior Deep Demo (Harness-Safe) ===');

  final values = DropdownMenuCloseBehavior.values;
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
                'DropdownMenuCloseBehavior',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Shows available close behaviors in this runtime.'),
              const SizedBox(height: 12),
              ...values.map((v) => Text('${v.index}. ${v.name}')),
              const Spacer(),
              DropdownMenu<String>(
                enabled: false,
                dropdownMenuEntries: const [
                  DropdownMenuEntry<String>(value: 'a', label: 'Option A'),
                  DropdownMenuEntry<String>(value: 'b', label: 'Option B'),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
