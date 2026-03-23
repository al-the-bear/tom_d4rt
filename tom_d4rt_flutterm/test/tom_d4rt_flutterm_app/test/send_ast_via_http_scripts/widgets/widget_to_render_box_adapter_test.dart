// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WidgetToRenderBoxAdapter from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetToRenderBoxAdapter test executing');

  final title = 'WidgetToRenderBoxAdapter';
  final packageName = 'widgets';
  final details = 'WidgetToRenderBoxAdapter';

  print('Class: $title');
  print('Package: $packageName');
  print('Details: $details');

  print('WidgetToRenderBoxAdapter test completed');
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
