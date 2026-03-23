// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// Deep visual demo for FlutterError - structured error reporting.
/// Shows error summary, details, and stack trace formatting.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('FlutterError Demo')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Structured Error Reporting',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(11),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.error, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'FlutterError',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ErrorSection(
                        title: 'Summary',
                        content:
                            'A RenderFlex overflowed by 42 pixels on the right.',
                        icon: Icons.summarize,
                      ),
                      const SizedBox(height: 12),
                      _ErrorSection(
                        title: 'Context',
                        content:
                            'The overflowing RenderFlex has an orientation of Axis.horizontal.',
                        icon: Icons.info_outline,
                      ),
                      const SizedBox(height: 12),
                      _ErrorSection(
                        title: 'Hint',
                        content:
                            'Consider applying a flex factor or using Expanded.',
                        icon: Icons.lightbulb_outline,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FlutterError.onError:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text('• Override to customize error handling'),
                Text('• Used by crash reporting services'),
                Text('• Called on uncaught framework errors'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _ErrorSection extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  const _ErrorSection({
    required this.title,
    required this.content,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.red.shade700),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                  fontSize: 12,
                ),
              ),
              Text(content, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
