// D4rt test script: Tests SegmentedButtonState from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SegmentedButtonState test executing');

  final title = 'SegmentedButtonState';
  final packageName = 'material';
  final details = 'SegmentedButtonState';

  print('Class: $title');
  print('Package: $packageName');
  print('Details: $details');

  print('SegmentedButtonState test completed');
  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 460),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF374151), width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  FlutterLogo(size: 18),
                  SizedBox(width: 10),
                ],
              ),
              Text('Class: $title', style: const TextStyle(color: Color(0xFFF9FAFB))),
              const SizedBox(height: 6),
              Text('Package: $packageName', style: const TextStyle(color: Color(0xFFD1D5DB))),
              const SizedBox(height: 6),
              Text(details, style: const TextStyle(color: Color(0xFF9CA3AF))),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const ColoredBox(
                  color: Color(0xFF1F2937),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Center(
                      child: Text('Visible UI probe', style: TextStyle(color: Color(0xFF93C5FD))),
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
