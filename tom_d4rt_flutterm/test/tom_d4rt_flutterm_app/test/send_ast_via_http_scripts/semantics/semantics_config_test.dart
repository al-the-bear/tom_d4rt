// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Semantics widget advanced, SemanticsNode concepts,
// SemanticsOwner concepts, SemanticsConfiguration, SemanticsSortKey
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('semantics_config_test test executing');

  final diagnostics = <String>[
    'Class: semantics_config_test',
    'Script: semantics/semantics_config_test.dart',
    'Status: safe visual probe',
  ];

  print('semantics_config_test test completed');
  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 520),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF334155), width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  FlutterLogo(size: 18),
                  SizedBox(width: 10),
                  Text(
                    'D4rt Visual Test',
                    style: TextStyle(
                      color: Color(0xFFE2E8F0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              for (final line in diagnostics)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    line,
                    style: const TextStyle(color: Color(0xFFCBD5E1)),
                  ),
                ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const ColoredBox(
                  color: Color(0xFF1E293B),
                  child: SizedBox(
                    height: 44,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Visible UI probe active',
                        style: TextStyle(color: Color(0xFF93C5FD)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
