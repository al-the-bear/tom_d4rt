// ignore_for_file: avoid_print
// D4rt test script: Stable TargetPlatform summary demo for harness execution.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== TargetPlatform Deep Demo (Harness-Safe) ===');
  print('TargetPlatform values: ${TargetPlatform.values.length}');
  for (final platform in TargetPlatform.values) {
    print('  ${platform.index}: ${platform.name}');
  }

  final current = defaultTargetPlatform;
  print('defaultTargetPlatform: ${current.name}');

  final mobile = TargetPlatform.values
      .where(
        (p) =>
            p == TargetPlatform.android ||
            p == TargetPlatform.iOS ||
            p == TargetPlatform.fuchsia,
      )
      .map((p) => p.name)
      .join(', ');
  final desktop = TargetPlatform.values
      .where(
        (p) =>
            p == TargetPlatform.linux ||
            p == TargetPlatform.macOS ||
            p == TargetPlatform.windows,
      )
      .map((p) => p.name)
      .join(', ');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TargetPlatform',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Current: ${current.name}'),
        const SizedBox(height: 8),
        Text('Mobile: $mobile'),
        Text('Desktop: $desktop'),
        const SizedBox(height: 12),
        ...TargetPlatform.values.map(
          (p) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text('${p.index}. ${p.name}'),
          ),
        ),
      ],
    ),
  );
}
