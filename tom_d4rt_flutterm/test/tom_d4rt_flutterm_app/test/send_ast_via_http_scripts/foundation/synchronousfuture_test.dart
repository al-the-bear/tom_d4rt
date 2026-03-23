// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

/// Deep visual demo for SynchronousFuture - immediately resolved future.
/// Shows synchronous Future with known value.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('SynchronousFuture Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Synchronous Future',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _FutureCard(
                  title: 'Regular Future',
                  timeline: ['Created', 'Event loop...', 'Resolved'],
                  async: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _FutureCard(
                  title: 'SynchronousFuture',
                  timeline: ['Created', 'Resolved'],
                  async: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.flash_on, color: Colors.amber),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'then() callback fires immediately, not after event loop',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
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
                  'Use Case:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'When you have a Future API but value is already known, avoiding unnecessary async delays.',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _FutureCard extends StatelessWidget {
  final String title;
  final List<String> timeline;
  final bool async;
  const _FutureCard({
    required this.title,
    required this.timeline,
    required this.async,
  });
  @override
  Widget build(BuildContext context) {
    final color = async ? Colors.orange : Colors.green;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 12),
          ...timeline.map(
            (step) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(
                    step.contains('...')
                        ? Icons.hourglass_empty
                        : Icons.check_circle,
                    size: 14,
                    color: step.contains('...') ? Colors.grey : color,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    step,
                    style: TextStyle(
                      fontSize: 11,
                      color: step.contains('...') ? Colors.grey : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
