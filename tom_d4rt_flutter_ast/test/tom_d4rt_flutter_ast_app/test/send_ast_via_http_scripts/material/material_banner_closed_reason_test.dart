// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== MaterialBannerClosedReason Deep Demo (Harness-Safe) ===');

  final values = MaterialBannerClosedReason.values;
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
                'MaterialBannerClosedReason',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Available closed reasons in this runtime:'),
              const SizedBox(height: 12),
              ...values.map((v) => Text('${v.index}. ${v.name}')),
              const Spacer(),
              MaterialBanner(
                content: const Text('Banner preview'),
                actions: [
                  TextButton(onPressed: () {}, child: const Text('Dismiss')),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
